#!/usr/bin/env python
import collections
import enum
import argparse
import xml.etree.ElementTree as ET
import copy
import time

import traci
import traci.constants as tc
import rospy

import utils


# https://sumo.dlr.de/docs/Definition_of_Vehicles,_Vehicle_Types,_and_Routes.html#abstract_vehicle_class
class SumoActorClass(enum.Enum):
    """
    SumoActorClass enumerates the different sumo actor classes.
    """
    IGNORING = "ignoring"
    PRIVATE = "private"
    EMERGENCY = "emergency"
    AUTHORITY = "authority"
    ARMY = "army"
    VIP = "vip"
    PEDESTRIAN = "pedestrian"
    PASSENGER = "passenger"
    HOV = "hov"
    TAXI = "taxi"
    BUS = "bus"
    COACH = "coach"
    DELIVERY = "delivery"
    TRUCK = "truck"
    TRAILER = "trailer"
    MOTORCYCLE = "motorcycle"
    MOPED = "moped"
    BICYCLE = "bicycle"
    EVEHICLE = "evehicle"
    TRAM = "tram"
    RAIL_URBAN = "rail_urban"
    RAIL = "rail"
    RAIL_ELECTRIC = "rail_electric"
    RAIL_FAST = "rail_fast"
    SHIP = "ship"
    CUSTOM1 = "custom1"
    CUSTOM2 = "custom2"


SumoActor = collections.namedtuple('SumoActor', 'actor_id type_id vclass transform signals extent color')


class SumoSimulation:
    def __init__(self, cfg_file=None, port=9000, extra_cmd=[]):

        self.LoadParameters()
        self.sumocfg_file = cfg_file or self.sumocfg_file
        self.extra_cmd = extra_cmd or self.extra_cmd
        self.sumo_port = port
        rospy.loginfo("Using SUMO port {}".format(self.sumo_port))
        while(not self.TryConnectTraCI()):
            rospy.logwarn_throttle(10, "Connect to TracCI failed."\
                "Try again in 5 sec.")
            time.sleep(5.0)

        # Structures to keep track of the spawned and destroyed vehicles at each time step.
        self._InitActorKeepers()


    def TryConnectTraCI(self):
        # Creating a random route to be able to spawn actors.
        isSuccess = False
        if self.sumocfg_file and self.launch_sumo:
            cmd = "sumo-gui" if self.launch_gui else "sumo" 
            try:
                traci.start([cmd, "-c", self.sumocfg_file] + self.extra_cmd)
                isSuccess = True
            except Exception as e:
                rospy.logfatal("{} - cfg = {}".format(e, self.sumocfg_file))
        else:
            assert self.sumo_port, "A port should be assigned if not calling sumo-gui."
            try:
                traci.init(port=self.sumo_port)
                traci.setOrder(1)
                isSuccess = True
            except traci.exceptions.FatalTraCIError as e:
                rospy.logwarn_throttle(10, "traci.exceptions.FatalTraCIError: {}".format(e))
        try:
            traci.route.add("dummy_route", [traci.edge.getIDList()[0]])
        except AttributeError as e:
            rospy.logwarn_throttle(10, "AttributeError: {}".format(e))
        except traci.exceptions.FatalTraCIError as e:
            rospy.logwarn_throttle(10, "traci.exceptions.FatalTraCIError: {}".format(e))
        return isSuccess

    def _InitActorKeepers(self):
        # Variable to asign an id to new added actors.
        self._sequential_id = 0
        # Structures to keep track of the spawned and destroyed vehicles at each time step.
        self.spawned_actors = {"veh": set(), "ped": set()}
        self.destroyed_actors = {"veh": set(), "ped": set()}
        self.active_actors = {"veh": set(), "ped": set()}
        self.last_active = {"veh": set(), "ped": set()}

        self.total_spawned_agents = {"veh": set(), "ped": set()}
        self.force_removed_agents = set()

        self.external_actors = {"veh": set(), "ped": set()}



    def GetInformation(self):
        return {
            "n_active_agents": len(self.active_actors["veh"] | self.active_actors["ped"]),
            "n_total_spawned_agents": len(self.total_spawned_agents["veh"] | self.total_spawned_agents["ped"]),
            "n_agents_force_removed": len(self.force_removed_agents)
        }


    def LoadParameters(self):
        try:
            # "/project/mmsl_simulation/src/sumo_cosimulation/data/III_itri_v5/final.sumocfg"
            self.launch_sumo = rospy.get_param("sumo_cosimulation/launch_sumo", False)
            self.sumocfg_file = rospy.get_param("sumo_cosimulation/sumocfg", None)
            self.launch_gui = rospy.get_param("sumo_cosimulation/launch_gui", False)
            self.extra_cmd = rospy.get_param("sumo_cosimulation/extra_cmd", [])
            self.use_pedestrian = rospy.get_param("sumo_cosimulation/use_pedestrian", True)

            if self.launch_sumo:
                rospy.loginfo("[Sumo Simulation] Launching sumo from docker.")
            else:
                rospy.loginfo("[Sumo Simulation] Launching sumo from host.")

            # Get sumo dt from sumo config file.
            tree = ET.parse(self.sumocfg_file)
            root = tree.getroot()
            self._dt = float(root.find("time").find("step-length").attrib["value"]) or 0.1

        except Exception as e:
            rospy.logwarn(e)
            self.sumocfg_file = None
            self._dt = 0.1

    @property
    def dt(self):
        return self._dt
    
    @staticmethod
    def subscribe_vehicle(actor_id):
        """
        Subscribe the given actor to the following variables:

            * Type, Vehicle class, Color, Length, Width, Height, Position3D (i.e., x, y, z),
            * Angle, Slope, Speed, Lateral speed, Signals.
        """
        traci.vehicle.subscribe(actor_id, [
            traci.constants.VAR_TYPE, traci.constants.VAR_VEHICLECLASS, traci.constants.VAR_COLOR,
            traci.constants.VAR_LENGTH, traci.constants.VAR_WIDTH, traci.constants.VAR_HEIGHT,
            traci.constants.VAR_POSITION3D, traci.constants.VAR_ANGLE, traci.constants.VAR_SLOPE,
            traci.constants.VAR_SPEED, traci.constants.VAR_SIGNALS
        ])

    @staticmethod
    def subscribe_pedestrian(actor_id):
        traci.person.subscribe(actor_id, [
            traci.constants.VAR_TYPE, traci.constants.VAR_COLOR,
            traci.constants.VAR_LENGTH, traci.constants.VAR_WIDTH, traci.constants.VAR_HEIGHT,
            traci.constants.VAR_POSITION3D, traci.constants.VAR_ANGLE, traci.constants.VAR_SLOPE,
            traci.constants.VAR_SPEED
        ])

    @staticmethod
    def unsubscribe(actor_id):
        # print("to unsubscribe: {}".format(actor_id))
        traci.vehicle.unsubscribe(actor_id)

    def get_actor(self, actor_id):

        if actor_id in self.active_actors["veh"]:
            results = traci.vehicle.getSubscriptionResults(actor_id)
            is_veh = True
        else:
            results = traci.person.getSubscriptionResults(actor_id)
            is_veh = False

        try:
            if is_veh:
                vclass = SumoActorClass(results[traci.constants.VAR_VEHICLECLASS])
                signals = results[traci.constants.VAR_SIGNALS]
            else:
                vclass = SumoActorClass.PEDESTRIAN
                signals = None

            type_id = results[traci.constants.VAR_TYPE]
            color = results[traci.constants.VAR_COLOR]

            length = results[traci.constants.VAR_LENGTH]
            width = results[traci.constants.VAR_WIDTH]
            height = results[traci.constants.VAR_HEIGHT]

            location = list(results[traci.constants.VAR_POSITION3D])
            rotation = [0.0, results[traci.constants.VAR_SLOPE], results[traci.constants.VAR_ANGLE]]
            transform = utils.Transform(utils.Location(location[0], location[1], location[2]),
                                        utils.Rotation(rotation[0], rotation[1], rotation[2]))

            extent = utils.Vector3D(length, width, height)

            return SumoActor(actor_id, type_id, vclass, transform, signals, extent, color)

        except KeyError as e:
            print(e)
            return -1

    def force_destroy_actors(self, actor_ids):
        self.force_removed_agents |= set(actor_ids)

        self.destroy_actors(actor_ids)

    def destroy_actors(self, actor_ids):
        for actor_id in actor_ids:
            if actor_id in self.active_actors["veh"] \
                    or actor_id in self.active_actors["ped"]:
                self.destroy_actor(actor_id)

    @staticmethod
    def destroy_actor(actor_id):
        """
        Destroys the given actor.
        """
        traci.vehicle.remove(actor_id)

    def spawn_actor(self, type_id=None, color=None, ego=False, agent_id=None):
        """
        Spawns a new actor.

            :param type_id: vtype to be spawned.
            :param color: color attribute for this specific actor.
            :return: actor id if the actor is successfully spawned. Otherwise, INVALID_ACTOR_ID.
        """
        # print("00sumo spawn - is ego: {}".format(ego))
        # print("00sumo spawn - is ego: {}".format(ego))
        # print("00sumo spawn - is ego: {}".format(ego))
        # print("00sumo spawn - is ego: {}".format(ego))
        # print("00sumo spawn - is ego: {}".format(ego))
        type_id = type_id or "vehicle.chrysler.pacifica"
        if ego:
            actor_id = "ego_vehicle"
            color = "0, 0, 0, 0"
        else:
            actor_id = agent_id or "mmsl_{}".format(self._sequential_id)
            self._sequential_id += 1
            color = "0, 0, 0, 0"

        try:
            traci.vehicle.add(actor_id, 'dummy_route', typeID=type_id)
        except traci.exceptions.TraCIException as error:
            rospy.logwarn_throttle(10, "Spawn sumo actor failed: {} "\
                "( Only critical if this warning shown twice. )".format(error))
            return False

        if color is not None:
            color = color.split(',')
            traci.vehicle.setColor(actor_id, color)

        SumoSimulation.subscribe_vehicle(actor_id)        
        self.external_actors["veh"] |= set([actor_id])
        self.active_actors["veh"] |= self.external_actors["veh"]

        return actor_id

    def update_actors(self, actor_ids, transforms, signals=None):
        n_actors = len(actor_ids)
        signals = signals or ([None] * n_actors)
        for actor_id, transform, signal in zip(actor_ids, transforms, signals):
            self.update_actor(actor_id, transform, signal)
            print("sumo update - id: {}, trans: {}".format(actor_id, transform.location))

    def update_actor(self, actor_id, transform, signals=None):
        """
        Updates actor state.

            :param actor_id: id of the actor to be updated.
            :param transform: new actor transform (i.e., position and rotation).
            :param signals: new actor signals.
            :return: True if successfully updated. Otherwise, False.
        """
        loc_x, loc_y = transform.location.x, transform.location.y
        yaw = transform.rotation.yaw

        if actor_id in self.active_actors["veh"]:
            traci.vehicle.moveToXY(actor_id, "", 0, loc_x, loc_y, angle=yaw, keepRoute=2)
            if signals is not None:
                traci.vehicle.setSignals(vehicle_id, signals)
            return True
        elif actor_id in self.active_actors["ped"]:
            traci.person.moveToXY(actor_id, "", 0., loc_x, loc_7, angle=yaw)
            return True
        else:
            rospy.logwarn_throttle(10, "Can\'t find actor with id {} in sumo. "\
                "( Only critical if this warning shown twice. )".format(actor_id))
            return False


    def hold_external_actors(self):
        for a in self.external_actors["veh"] + self.external_actors["ped"]:
            try:
                transform = self.get_actor(a).transform
                self.update_actor(a, transform)
            except Exception as e:
                print(e)


    def tick(self):
        try:
            traci.simulationStep()
        except traci.exceptions.FatalTraCIError as e:
            rospy.logwarn(e)
            while(not self.TryConnectTraCI()):
                rospy.loginfo_throttle(10, "Trying to reconnect to TraCI.")
                time.sleep(5.);
            rospy.loginfo("Reconnected! Destroy all previous actors.")
            returnSets = (
                set(), self.spawned_actors["veh"] | self.spawned_actors["ped"], set())
            self._InitActorKeepers()
            return returnSets


        # self.hold_external_actors()

        # self.spawned_actors["veh"] = set(traci.simulation.getDepartedIDList())
        # self.destroyed_actors["veh"] = set(traci.simulation.getArrivedIDList())
        # for a in self.spawned_actors["veh"]:
        #     SumoSimulation.subscribe_vehicle(a)
        # self.active_actors["veh"] |= self.spawned_actors["veh"]
        # self.active_actors["veh"] -= self.destroyed_actors["veh"]
        # self.total_spawned_agents["veh"] |= self.spawned_actors["veh"]

        self.active_actors["veh"] = set(traci.vehicle.getIDList())
        self.spawned_actors["veh"] = self.active_actors["veh"] - self.last_active["veh"]
        self.destroyed_actors["veh"] = self.last_active["veh"] - self.active_actors["veh"]
        self.total_spawned_agents["veh"] |= self.spawned_actors["veh"]
        self.last_active["veh"] = self.active_actors["veh"]
        for a in self.spawned_actors["veh"]:
            SumoSimulation.subscribe_vehicle(a)

        if self.use_pedestrian:
            self.active_actors["ped"] = set(traci.person.getIDList())
            self.spawned_actors["ped"] = self.active_actors["ped"] - self.last_active["ped"]
            self.destroyed_actors["ped"] = self.last_active["ped"] - self.active_actors["ped"]
            self.total_spawned_agents["ped"] |= self.spawned_actors["ped"]
            self.last_active["ped"] = self.active_actors["ped"]
            for a in self.spawned_actors["ped"]:
                SumoSimulation.subscribe_pedestrian(a)

        return (self.spawned_actors["veh"] | self.spawned_actors["ped"],
                self.destroyed_actors["veh"] | self.destroyed_actors["ped"],
                self.active_actors["veh"] | self.active_actors["ped"])


    def destroy(self):
        traci.close()

    def __del__(self):
        traci.close()


def main(args):

    if args.stand_alone:
        if not args.on_host:
            cfg = args.root_path + "/data/" + args.cfg
            sumo = SumoSimulation(cfg)
        else:
            cfg = args.root_path_on_host + "/data/" + args.cfg
            sumo = SumoSimulation(cfg)
    else:
        sumo = SumoSimulation(port=9000)

    ego = False
    actor_id = None
    
    while True:
        sumo.tick()

        try:
            if not actor_id:
                actor_id = sumo.spawn_actor("vehicle.audi.tt", ego=True)
        except: 
            pass
        # print(sumo.active_actors)
        # if sumo.active_actors:
        #     print(sumo.active_actors)


            
            



if __name__ == "__main__":

    argparser = argparse.ArgumentParser(description=__doc__)
    argparser.add_argument('--on-host', action="store_true", help='run sumo on host.')
    argparser.add_argument('--root-path', type=str, help='sumo root path on docker.', default="/project/mmsl_simulation/src/sumo_cosimulation")
    argparser.add_argument('--root-path-on-host', type=str, help='sumo root path on host.', default="/home/zack/source_code/simulation/ros/src/sumo_cosimulation/")

    argparser.add_argument('--cfg', type=str, help='sumo configuration file', default="III_itri_v3-7/final.sumocfg")
    argparser.add_argument('--stand-alone', action="store_true", help='run sumo only.')
    args = argparser.parse_args()
    main(args)