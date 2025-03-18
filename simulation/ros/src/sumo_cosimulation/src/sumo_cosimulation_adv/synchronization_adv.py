#!/usr/bin/env python
from collections import deque
import threading
import time, datetime
import json

import numpy as np
import rospy
from simulation_srvs.srv import SimulationDeleteAgent, SimulationDeleteAgentResponse
from rosgraph_msgs.msg import Clock
from itri_msgs.msg import WaypointArray
    
from module_interface import MmslAdv, SumoAdv
import module_interface.utils as utils

def float_gcd(a, b, rtol=1e-05, atol=1e-08):
    t = min(abs(a), abs(b))
    while abs(b) > rtol * t + atol:
        a, b = b, a % b
    return a

class SimulationSynchronizationAdv:
    
    def __init__(self):
        rospy.init_node("sumo_simadv_cosim")
        rospy.wait_for_service("/simulation/agent_srv/create")

        sumo_port = rospy.get_param("~sumo_port", 9000)
        synchronize_mode = rospy.get_param("~synchronize_mode", True)
        self.use_sim_time = rospy.get_param("/use_sim_time", True)
        self.sync_by_tick = rospy.get_param("/sumo_cosim/sync_by_tick", True)
        self.wait_for_waypoints = rospy.get_param("/sumo_cosim/wait_for_waypoints", True)
        self.fastforward_seconds = rospy.get_param("/sumo_cosim/fastforward_seconds", 200.)
        if self.wait_for_waypoints:
            rospy.Subscriber("/waypoints", WaypointArray, self.callback_waypoints)
            rospy.logwarn("[SyncAdv] /sumo_cosim/wait_for_waypoints is set to True, "\
                "there must be at least 1 ego with no namespace assigned.")

        # Calculate float GCD of both mmsl_dt and sumo_dt
        self.mmsl_dt = rospy.get_param("/sumo_cosim/mmsl_dt", 0.01)
        self.sumo_dt = rospy.get_param("/sumo_cosim/sumo_dt", 0.05)
        self.gcd_dt = float_gcd(self.mmsl_dt, self.sumo_dt)
        self.mmsl_n_iter_per_tick = int(np.around(self.mmsl_dt / self.gcd_dt))
        self.sumo_n_iter_per_tick = int(np.around(self.sumo_dt / self.gcd_dt))
        self.n_tick = 0
        self.mmsl_actor_to_update = None
        self.sumo_actor_to_update = None

        # Get offset data for map alignment
        offset_data_path = rospy.get_param("/sumo_cosim/offset_data_path")
        route_name = rospy.get_param("route_mission_handler/route")
        with open(offset_data_path, 'r') as f:
            self.offset = json.load(f)[route_name]
            if isinstance(self.offset, dict):
                self.offset = list(np.array(self.offset["sumo"]) \
                    - np.array(self.offset["mmsl"]))
            rospy.loginfo("[SyncAdv] Map offset of {}: {}"\
                "".format(route_name, self.offset))

        assert not (self.sync_by_tick and not self.use_sim_time), ""\
            "[SyncAdv] With sync_by_tick mode, "\
            "use_sim_time must be set to True."

        self.mmsl = MmslAdv(
            self.sumo_dt, 
            synchronize_mode, 
            self.use_sim_time, 
            self.sync_by_tick)

        rospy.loginfo("[SyncAdv] MmslAdv Created.")
        self.sumo = SumoAdv(self.sumo_dt, [self.mmsl.reset])
        rospy.loginfo("[SyncAdv] SumoAdv Created.")

        self.delete_server = rospy.Service(
            "/cosim/delete", SimulationDeleteAgent, self._delete_server)

        if self.use_sim_time: self.current_time = rospy.Time()
        else: self.current_time = rospy.Time.now()


        # Clock
        self.clock_publisher = rospy.Publisher("/clock", Clock, queue_size=1)
        self.update_rate = rospy.Rate(1/self.gcd_dt)
        self.clock_dt = rospy.Duration(self.gcd_dt)
        self.sub_clock_dt = rospy.Duration(self.gcd_dt/10.)

        if not self.sync_by_tick:
            self._clock_publish_thread = threading.Thread(
                target = self._clock_publish_thread_runner)
            self._clock_publish_thread.start()


        rospy.loginfo("[SyncAdv] Constructed.")

    def _clock_publish_thread_runner(self):
        while not rospy.is_shutdown():
            self.current_time += self.sub_clock_dt
            self.clock_publisher.publish(self.current_time)
            # time.sleep(0.0015)

    def tick(self, force_tick=False):
        if self.n_tick % self.mmsl_n_iter_per_tick == 0 or force_tick:
            if self.sumo_actor_to_update:
                self.mmsl.set_external_actors(
                    utils.sumo_actors_to_mmsl(self.sumo_actor_to_update, self.offset))
                self.sumo_actor_to_update = None
            self.mmsl.tick()
            self.mmsl_actor_to_update, mmsl_message = self.mmsl.get_all()

        if self.n_tick % self.sumo_n_iter_per_tick == 0 or force_tick:
            if self.mmsl_actor_to_update:
                self.sumo.set_external_actors(
                    utils.mmsl_actors_to_sumo(self.mmsl_actor_to_update, self.offset))    
                self.mmsl_actor_to_update = None
            self.sumo.tick()
            self.sumo_actor_to_update, sumo_message = self.sumo.get_all()

        self.n_tick += 1


    def destroy(self):
        self.mmsl.destroy()
        if hasattr(self, '_clock_publish_thread'):
            self._clock_publish_thread.join()
        # self.sumo.destroy()

    def run(self):
        self.got_waypoints = not self.wait_for_waypoints
        update_mmsl_once = False
        tick_mmsl_once = False
        sumo_actor_to_update = None

        while not rospy.is_shutdown():

            if self.sync_by_tick:
                self.current_time += self.clock_dt
                self.clock_publisher.publish(self.current_time)

            if self.current_time.to_sec() < self.fastforward_seconds and \
                    self.sumo.get_current_time() < self.fastforward_seconds:
                # prerun clock for sumo
                # If a saved state is loaded, it is possible that 
                #    self.sumo.get_current_time() <= self.fastforward_seconds will be false.
                rospy.loginfo_once("[SyncAdv] SUMO fastfoward start.")
                rospy.loginfo_throttle(self.fastforward_seconds/3., "[SyncAdv] SUMO fastfoward time {}/{}"\
                    "".format(self.current_time.to_sec(), self.fastforward_seconds))
                if self.n_tick % self.sumo_n_iter_per_tick == 0:
                    self.sumo.tick()
                self.n_tick += 1
                if self.current_time.to_sec() > 20. and not tick_mmsl_once:
                    self.mmsl.tick()
                    tick_mmsl_once = True
                    
                # No sleep for fastforward time.

            elif self.wait_for_waypoints and not self.got_waypoints:  ## Puase sumo before waypoints are published
                rospy.loginfo_once("[SyncAdv] Waiting for ego to publish waypoints.")
                if not update_mmsl_once and self.n_tick % self.mmsl_n_iter_per_tick == 0:
                    self.mmsl.tick()
                    self.tick(force_tick=True)
                    self.sumo.remove_nearby(self.mmsl.get_all_mmsl_id(), 5.)
                    update_mmsl_once = True
                if sumo_actor_to_update is None:
                    sumo_actor_to_update, sumo_message = self.sumo.get_all()
                self.mmsl.set_external_actors(
                    utils.sumo_actors_to_mmsl(sumo_actor_to_update, self.offset))
                self.mmsl.tick()
                self.n_tick += 1
                if not self.use_sim_time:
                    self.update_rate.sleep()

            else:  # Start Running
                rospy.loginfo_once("[SyncAdv] Start running comsimulation.")
                self.tick()
                if not self.use_sim_time:
                    self.update_rate.sleep()


    def callback_waypoints(self, msg):
        self.got_waypoints = True

    def _delete_server(self, req):
        rospy.loginfo("[SyncAdv] Get delete request: {}".format(req))
        if req.agentId.startswith("sumo."):
            agentId = req.agentId[5:]
            self.sumo.force_destroy_actor(agentId)
        else:
            rospy.logwarn("Unknown agent name in delete server: "\
                "{}".format(req.agentId))
        return SimulationDeleteAgentResponse(True)

if __name__ == "__main__":
    ss = SimulationSynchronizationAdv()
    rospy.on_shutdown(ss.destroy)
    ss.run()

