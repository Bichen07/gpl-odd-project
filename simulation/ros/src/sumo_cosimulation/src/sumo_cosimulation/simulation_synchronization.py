#!/usr/bin/env python
from collections import deque
import time, datetime

import numpy as np
import rospy
from std_msgs.msg import Float32
from sumo_cosimulation.msg import CoSimulationOverview
from sumo_cosimulation.srv import RequestAccidentOverview
import traci

from module_interface import MmslSimulation, SumoSimulation
import module_interface.utils as utils

class SimulationSynchronization:

    def __init__(self):

        rospy.init_node("sumo_cosimulation")
        self.LoadParameters()

        sumo_port = rospy.get_param("~sumo_port", 9000)
        self.sumo = SumoSimulation(port=sumo_port)
        self.mmsl = MmslSimulation(sumo_dt=self.sumo.dt)

        self.has_ego = self.sumo.spawn_actor(
            "vehicle.chrysler.pacifica", ego=True)
        self.has_agent = {}
        self.ran_iters = 0

        # Time Control
        self.current_time = rospy.Time.now()
        self.ros_dt = rospy.Duration(self.dt)
        self.n_mmsl_tick_per_sumo_tick = int(self.sumo.dt / self.dt)
        if self.sumo.dt / self.dt != self.n_mmsl_tick_per_sumo_tick:
            rospy.logwarn("[SimulationSynchronization] sumo dt {} "\
                "is not divisible by mmsl dt {}, "\
                "pleas fix it in config file."\
                "".format(self.sumo.dt, self.dt))

        self.real_time_factor_callback = rospy.Subscriber(
            "simulation/real_time_factor", Float32, 
            self.RealTimeFactorCallback)
        self.real_time_factor = 0.0
        
        self.cosimulation_overview_publisher = rospy.Publisher(
            "simulation/overview", 
            CoSimulationOverview, queue_size=1)
        self.request_accident_overview = rospy.ServiceProxy(
            "simulation/request_accident_overview", 
            RequestAccidentOverview)
        self.cosimulation_overview = CoSimulationOverview()
        self.cosimulation_overview.header.seq = self.ran_iters
        self.cosimulation_overview.header.stamp = rospy.Time.now()
        self.wall_time_start = time.time()
        self.is_new_round = False
        self.past_rounds_simulation_duration = [0.0]

        if self.WaitForService():
            rospy.loginfo("Accident Recorder is now Running.")
        else:
            rospy.logwarn("Accident Recorder is not Running.")

    def WaitForService(self):
        for i in range(10):
            try:
                rospy.wait_for_service(
                    "simulation/request_accident_overview", 
                    timeout=0.1)
                return True
            except rospy.exceptions.ROSException as e:
                rospy.logwarn_throttle(5, "waiting for service"\
                    " simulation/request_accident_overview")
        return False
        

    def RealTimeFactorCallback(self, msg):
        self.real_time_factor = msg.data

    def LoadParameters(self):
        self.sync_mode = rospy.get_param("/use_sim_time", True)
        self.dt = rospy.get_param("/time_step", 0.01)  # physic engine dt

    def _UpdateOnce(self):

        spawned_actors, destroyed_actors, active_actors = self.sumo.tick()
        
        if not self.has_ego:
            self.has_ego = self.sumo.spawn_actor("vehicle.chrysler.pacifica", ego=True)

        egoCarState = self.mmsl.get_ego()
        self.has_ego = self.sumo.update_actor("ego_vehicle", 
            utils.mmsl_car_state_to_transform(egoCarState))

        spawn, update, remove = self.mmsl.get_actors()

        if remove:
            self.sumo.destroy_actors(remove)

        if spawn:
            for type_id, agent_id, state in zip(
                    spawn["type_ids"], spawn["agent_ids"], spawn["car_states"]):
                self.has_agent[agent_id] = self.sumo.spawn_actor(type_id, None, False, agent_id)
                    
                update["agent_ids"].append(agent_id)
                update["car_states"].append(state)
        if update:
            for agent_id, state in zip(update["agent_ids"], update["car_states"]):
                if not self.has_agent[agent_id]:
                    self.has_agent[agent_id] = self.sumo.spawn_actor(None, None, False, agent_id)
                transform = utils.mmsl_car_state_to_transform(state)
                self.has_agent[agent_id] = self.sumo.update_actor(agent_id, transform)
                

        if self.mmsl.check_service():

            self.mmsl.destroy_actors(destroyed_actors - set(["ego_vehicle"]))
            for actor_id in active_actors - set(["ego_vehicle"]) - set(self.mmsl.agent_dict.keys()):
                actor = self.sumo.get_actor(actor_id)
                actor_config = utils.sumo_actor_to_mmsl_format(actor)
                self.mmsl.spawn_actor(*actor_config)

            ids = []
            carStates = []
            for actor_id in active_actors - spawned_actors - set(["ego_vehicle"]):
                actor = self.sumo.get_actor(actor_id)
                carState = utils.sumo_actor_to_car_state(actor)
                ids.append(actor_id)
                carStates.append(carState)

            self.mmsl.update_vehicles(ids, carStates)

        return self.sumo.GetInformation()

    def RunOnce(self):
        self.current_time += self.ros_dt
        agents_to_remove, mmsl_information = self.mmsl.tick(self.current_time)
        self.is_new_round = self.is_new_round or mmsl_information["is_new_round"]
        mmsl_information["is_new_round"] = self.is_new_round
        self.sumo.force_destroy_actors(agents_to_remove)

        self.ran_iters += 1

        self.past_rounds_simulation_duration[-1] += self.ros_dt.to_sec()

        if self.ran_iters % self.n_mmsl_tick_per_sumo_tick == 0:
            sumo_information = self._UpdateOnce()
            self.PublishCoSimulationOverview(mmsl_information, sumo_information)
            self.is_new_round = False

    def Run(self):
        while not rospy.is_shutdown():
            self.RunOnce()

    def PublishCoSimulationOverview(self, mmsl_information, sumo_information):

        reduce_update_condition = int(self.ran_iters / self.n_mmsl_tick_per_sumo_tick) % 5 == 0

        if mmsl_information["is_new_round"] or reduce_update_condition:

            self.cosimulation_overview.header.seq = self.ran_iters
            self.cosimulation_overview.header.stamp = self.current_time
            
            self.cosimulation_overview.real_time_factor = "{:.2f}".format(self.real_time_factor)

            total_wall_time_duration = time.time() - self.wall_time_start
            total_simulation_duration = self.current_time.to_sec()

            self.cosimulation_overview.total_wall_time_duration = str(datetime.timedelta(seconds=int(total_wall_time_duration)))
            self.cosimulation_overview.total_simulation_duration = str(datetime.timedelta(seconds=int(total_simulation_duration)))
            self.cosimulation_overview.current_round_simulation_duration = str(datetime.timedelta(seconds=int(self.past_rounds_simulation_duration[-1])))

            if self.cosimulation_overview.total_wall_time_duration > 1e-2:
                rtf = total_simulation_duration / total_wall_time_duration
                self.cosimulation_overview.overall_real_time_factor = "{:.2f}".format(rtf)

            if mmsl_information["is_new_round"]:
                self.cosimulation_overview.n_rounds_completed += 1
                self.cosimulation_overview.past_rounds_simulation_duration.append(
                    str(datetime.timedelta(seconds=int(self.past_rounds_simulation_duration[-1]))))
                self.cosimulation_overview.current_round_simulation_duration = str(datetime.timedelta(seconds=int(total_wall_time_duration)))
                self.past_rounds_simulation_duration.append(0.0)

            self.cosimulation_overview.n_active_agents = sumo_information["n_active_agents"]
            self.cosimulation_overview.n_total_spawned_agents = sumo_information["n_total_spawned_agents"]
            self.cosimulation_overview.n_agents_force_removed = sumo_information["n_agents_force_removed"]

            try:
                self.cosimulation_overview.accident_overview = \
                    self.request_accident_overview(mmsl_information["is_new_round"]).accident_overview
            except:
                pass

            self.cosimulation_overview_publisher.publish(self.cosimulation_overview)


    def Destroy(self):
        self.mmsl.destroy(self.sumo.active_actors)
        self.sumo.destroy()


if __name__ == "__main__":
    
    while not rospy.is_shutdown():
        try:
            ss = SimulationSynchronization()
            ss.Run()
        except traci.exceptions.FatalTraCIError as e:
            rospy.logfatal("traci.exceptions.FatalTraCIError: {}\n".format(e))
            ss.mmsl.destroy_all_marker(ss.mmsl.scenario_visualization_publisher)
            ss.mmsl.destroy_actors()
