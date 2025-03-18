#!/usr/bin/env python
import collections
import enum
import argparse
import functools
import copy
import time
import struct
import os
import sys
import threading

if 'SUMO_HOME' in os.environ:
     SUMO_HOME = os.environ['SUMO_HOME']
     tools = os.path.join(SUMO_HOME, 'tools')
     sys.path.append(tools)
else:
     sys.exit("please declare environment variable 'SUMO_HOME'")
import traci
import traci.constants as tc
import rospy

import utils
from utils import SumoActor
from utils import trace, GlobalExceptionHandler

LAUNCH_SUMO = False

def SumoAdvExceptionHandler(func):

    @GlobalExceptionHandler("SumoAdv")
    def _run(inst, _func, *_args, **_kwargs):
        return func(inst, *_args, **_kwargs)

    def wrap(self, *args, **kwargs):
        value = _run(self, func, *args, **kwargs)
        
        if value is not False: return value

        try:
            self.vehicle_operation_lock.release()
        except: pass

        if self.traci_reconnect_mutex.acquire(False):
            self._reset()
            if LAUNCH_SUMO:
                launch_sumo(relaunch=True, **self.sumo_command_kwargs)
            else:
                connect_sumo(relaunch=True, text=func.__name__)

            [cb() for cb in self.reset_callbacks]

            self.traci_reconnect_mutex.release()
            return_value = wrap(self, *args, **kwargs)
            return return_value
        else:
            with self.traci_reconnect_mutex:
                return wrap(self, *args, **kwargs)
    return wrap

def launch_sumo(
        cfg_file, use_gui=False, 
        is_debug_build=True, use_gdb=False, relaunch=False):
    
    @GlobalExceptionHandler("SumoAdv-TraCI.close")
    def _close():
        traci.close(False)
        rospy.loginfo("[SumoAdv] TraCI Stopped .")

    @GlobalExceptionHandler("SumoAdv-TraCI.start")
    def _start(_cmd_list, _cfg_file):
        rospy.loginfo("[SumoAdv] Starting SUMO from TraCI API.")
        traci.start(_cmd_list)
        rospy.loginfo("[SumoAdv] Sumo launched with cfg_file {}."\
            "".format(_cfg_file))
        traci.route.add("dummy_route", [traci.edge.getIDList()[0]])
        return True

    _close()
    
    cmd_bin_path = os.path.join(SUMO_HOME, 'bin')
    cmd = "sumo-gui" if use_gui else "sumo"
    if is_debug_build: cmd += "D"
    cmd_list = ["{}/{}".format(cmd_bin_path, cmd), "-c", cfg_file]
    if use_gdb: cmd_list = ["gdb", "-ex=r", "--args"] + cmd_list
    while not rospy.is_shutdown():
        if _start(cmd_list, cfg_file):
            break
        else:
            rospy.logfatal("Launch SUMO failed: {} with commands {}. "\
                "will try again in 5 seconds.".format(error, cmd_list))
            time.sleep(5.)

def connect_sumo(relaunch=False, text=None):

    @GlobalExceptionHandler("SumoAdv-TraCI.close")
    def _close():
        traci.close(False)
        rospy.loginfo("[SumoAdv] TraCI Stopped .")

    @GlobalExceptionHandler("SumoAdv-TraCI.init")
    def _init():
        rospy.loginfo("[SumoAdv] Trying to connect to SUMO.")
        traci.init(port=9000)
        traci.setOrder(1)
        traci.route.add("dummy_route", [traci.edge.getIDList()[0]])
        return True

    if text:
        rospy.logdebug("msgs: {}".format(text))

    if relaunch:
        _close()

    while not rospy.is_shutdown() :
        if _init(): 
            break
        else:
            time.sleep(5.)

    rospy.loginfo("[SumoAdv] SUMO Connected.")


class SumoAdv:

    def __init__(self, sumo_dt, reset_callbacks=[]):

        self._reset()
        self.use_person = False
        self.dt = sumo_dt
        self.reset_callbacks = reset_callbacks

        self.sumo_command_kwargs = {
            "cfg_file": rospy.get_param("~cfg_file"),
            "use_gui": rospy.get_param("~sumo_gui", False),
            "is_debug_build": rospy.get_param("~sumo_with_debug_build", True),
            "use_gdb": rospy.get_param("~use_gdb_in_sumo", False)}

        self.traci_reconnect_mutex = threading.Lock()
        self.vehicle_operation_lock = threading.Lock()

        if LAUNCH_SUMO:
            launch_sumo(relaunch=False, **self.sumo_command_kwargs)
        else:
            connect_sumo(text="ok")

    def _reset(self):
        self._actors = {}
        self._external_ids = []
        self._last_speed = {}  # "aid": speed

    @SumoAdvExceptionHandler
    def get_current_time(self):
        return traci.simulation.getTime()

    @SumoAdvExceptionHandler
    def get_all(self):
        @GlobalExceptionHandler("SumoAdv-_get_all_wrapper")
        def _get_all_wrapper(func, _id, domain):
            sumo_actor = func(_id, domain)
            return sumo_actor

        with self.vehicle_operation_lock:
            vehicle_ids = set(traci.vehicle.getIDList())

            for vid in vehicle_ids:
                traci_operation = traci_get_subscribed_actor            
                if vid not in self._actors.keys():
                    traci_subscribe_vehicle(vid)
                    traci_operation = traci_get_actor

                result = _get_all_wrapper(
                    traci_operation, vid, traci.vehicle)
                if result:
                    self._actors[vid] = result
                else:
                    if vid in self._actors:
                        del self._actors[vid]

        if self.use_person:
            with self.vehicle_operation_lock:
                person_ids = set(traci.person.getIDList())
                for pid in person_ids:
                    traci_operation = traci_get_subscribed_actor
                    if pid not in self._actors.keys():
                        traci_subscribe_person(pid)
                        traci_operation = traci_get_actor

                    result = _get_all_wrapper(
                        traci_operation, pid, traci.person)
                    if result:
                        self.actors[pid] = result
                    else:
                        if pid in self._actors:
                            del self._actors[pid]
                
        else:
            person_ids = set()

        actor_ids_union = vehicle_ids | person_ids
        for aid in self._actors.keys():
            if aid not in actor_ids_union:
                del self._actors[aid]

        return list(self._actors.values()), ""

    @SumoAdvExceptionHandler
    def set_external_actors(self, actors):
        for actor in actors:
            assert isinstance(actor, SumoActor), type(actor)
            aid, trans, speed = actor.actor_id, actor.transform, actor.speed

            if aid not in self._external_ids:
                with self.vehicle_operation_lock:
                    traci_try_spawn_vehicle(aid)
                self._external_ids.append(aid)
                self._last_speed[aid] = speed.x

            if aid in self._external_ids:
                accel = (speed.x - self._last_speed[aid]) / self.dt
                with self.vehicle_operation_lock:
                    traci_update_actor(aid, actor, trans, self._last_speed[aid], accel, traci.vehicle)
                self._last_speed[aid] = speed.x
    
    @SumoAdvExceptionHandler
    def tick(self, n_tick=0):
        with self.vehicle_operation_lock:
            traci_tick()
        return True

    @SumoAdvExceptionHandler
    def remove_nearby(self, target_ids, threshold):
        id_list = traci.vehicle.getIDList()
        for target_id in target_ids:
            target_id = "mmsl/" + target_id
            target_lane_id = traci.vehicle.getLaneID(target_id)
            target_lane_position = traci.vehicle.getLanePosition(target_id)
            for aid in id_list:
                if aid == target_id: continue
                actor_lane_id = traci.vehicle.getLaneID(aid)
                if actor_lane_id != target_lane_id: continue
                actor_lane_position = traci.vehicle.getLanePosition(aid)
                dist = abs(target_lane_position - actor_lane_position)
                if dist < threshold:
                    if aid in target_ids:
                        rospy.loginfo("Mmsl actor {} and {} is too close({:.2f})"\
                            "".format(target_id, aid, dist))
                    else:
                        self.force_destroy_actor(aid)
                        rospy.loginfo("Remove aid {} since it's close to ({:.2f}) {}"\
                            "".format(aid, dist, target_id))
    
    @SumoAdvExceptionHandler
    def force_destroy_actor(self, aid):
        if self.vehicle_operation_lock.acquire(True):
            vehicle_ids_from_sumo = set(traci.vehicle.getIDList())
            if aid in vehicle_ids_from_sumo:
                traci.vehicle.unsubscribe(aid)
                traci.vehicle.remove(aid, reason=0)
            self.vehicle_operation_lock.release()
        
    @SumoAdvExceptionHandler
    def destroy(self):
        traci_destroy()

    @SumoAdvExceptionHandler
    def __del__(self):
        traci_destroy()


# Traci Operations

@GlobalExceptionHandler("SumoAdv-TraCIOp")
def traci_tick():
    traci.simulationStep()

@GlobalExceptionHandler("SumoAdv-TraCIOp")
def traci_try_spawn_vehicle(aid, type_id=None):
    type_id = type_id or "pacifica"
    aid = "mmsl/{}".format(aid)
    traci.vehicle.add(aid, "dummy_route", typeID=type_id)
    rospy.logdebug("[SumoAdv] Success adding vehicle \"{}\" "\
        "with type \"{}\"".format(aid, type_id))
    return True

# @GlobalExceptionHandler("SumoAdv-TraCIOp")
def traci_update_actor(aid, actor, transform, last_speed, accel, domain=traci.vehicle):
    loc_x, loc_y = transform.location.x, transform.location.y
    yaw = transform.rotation.yaw
    signals = actor.turn_signal
    sumo_id = "mmsl/{}".format(aid)

    @GlobalExceptionHandler("SumoAdv-TraCIOp-moveToXY")
    def _move():
        # print("last_speed: {:.4f}, accel: {:.4f}".format(last_speed, accel))
        domain.moveToXY(
            vehID = sumo_id, 
            edgeID = "", 
            lane = 0,
            x = loc_x, y = loc_y, angle = yaw, 
            keepRoute = 2)
        domain.setPreviousSpeed(sumo_id, last_speed)
        # domain.setAccel(sumo_id, accel)
        return True

    @GlobalExceptionHandler("SumoAdv-TraCIOp-setSignals")
    def _set_signal():
        domain.setSignals(
            vehID="mmsl/{}".format(aid),
            signals=signals)
        return True

    if _move() and _set_signal():
        return True
    else:
        rospy.logwarn_once(10, "[SumoAdv] Update actor "\
            " \"{}\" failed. It's likely that pacifica "\
            "model defined in \".rou.xml\" is not spawned by "\
            "SUMO yet or a collision happened and external "\
            "agent was removed by SUMO. For the first case "\
            "try to wait longer or add a vehicle tag with "\
            "pacifica in \".rou.xml\" file. For the second, "\
            "SumoAdv will try to respawn the vehicle again. "
            "(Only critical if keep showing)"\
            "".format(aid))
        traci_try_spawn_vehicle(aid)
        return False

def traci_get_actor(aid, domain=traci.vehicle):
    transform = utils.Transform(
        utils.Location(*list(domain.getPosition3D(aid))),
        utils.Rotation(0., domain.getSlope(aid), domain.getAngle(aid)))
    extent = utils.Vector3D(
        domain.getLength(aid), domain.getWidth(aid), 1.8)
    if domain == traci.vehicle:
        speed = utils.Vector3D(domain.getSpeed(aid), domain.getLateralSpeed(aid), 0.)
        turn_signal = domain.getSignals(aid)
    else:
        speed = utils.Vector3D(domain.getSpeed(aid), 0., 0.)
        turn_signal = 0
    return SumoActor(aid, domain.getTypeID, transform, extent, speed, turn_signal)

def traci_get_subscribed_actor(aid, domain=traci.vehicle):
    results = domain.getSubscriptionResults(aid)
    try:
        type_id = results[traci.constants.VAR_TYPE]
    except KeyError:
        type_id = ""
    transform = utils.Transform(
        utils.Location(*list(results[traci.constants.VAR_POSITION3D])),
        utils.Rotation(
            0., 
            results[traci.constants.VAR_SLOPE], 
            results[traci.constants.VAR_ANGLE]))
    extent = utils.Vector3D(
        results[traci.constants.VAR_LENGTH], 
        results[traci.constants.VAR_WIDTH], 
        results[traci.constants.VAR_HEIGHT])
    if domain == traci.vehicle:
        speed = utils.Vector3D(
            results[traci.constants.VAR_SPEED],
            results[traci.constants.VAR_SPEED_LAT],
            0.)
        turn_signal = results[traci.constants.VAR_SIGNALS]
    else:
        speed = utils.Vector3D(
            results[traci.constants.VAR_SPEED],
            0.,
            0.)
        turn_signal = 0
    return SumoActor(aid, type_id, transform, extent, speed, turn_signal)

@GlobalExceptionHandler("SumoAdv-TraCIOp")
def traci_subscribe_vehicle(actor_id):
    """
    Subscribe the given actor to the following variables:

        * Type, Vehicle class, Color, Length, Width, Height, Position3D (i.e., x, y, z),
        * Angle, Slope, Speed, Lateral speed, Signals.
    """
    traci.vehicle.subscribe(actor_id, [
        traci.constants.VAR_TYPE, traci.constants.VAR_VEHICLECLASS, traci.constants.VAR_COLOR,
        traci.constants.VAR_LENGTH, traci.constants.VAR_WIDTH, traci.constants.VAR_HEIGHT,
        traci.constants.VAR_POSITION3D, traci.constants.VAR_ANGLE, traci.constants.VAR_SLOPE,
        traci.constants.VAR_SPEED, traci.constants.VAR_SPEED_LAT, traci.constants.VAR_SIGNALS
    ])

@GlobalExceptionHandler("SumoAdv-TraCIOp")
def traci_subscribe_person(actor_id):
    traci.person.subscribe(actor_id, [
        traci.constants.VAR_TYPE, traci.constants.VAR_COLOR,
        traci.constants.VAR_LENGTH, traci.constants.VAR_WIDTH, traci.constants.VAR_HEIGHT,
        traci.constants.VAR_POSITION3D, traci.constants.VAR_ANGLE, traci.constants.VAR_SLOPE,
        traci.constants.VAR_SPEED
    ])

def traci_destroy_actor(actor_id, domain=traci.vehicle):
    """
    Destroys the given actor.
    """
    traci_remove(actor_id, domain)
    traci_unsubscribe(actor_id, domain)

@GlobalExceptionHandler("SumoAdv-TraCIOp")
def traci_remove(actor_id, domain=traci.vehicle):
    domain.remove(actor_id)

@GlobalExceptionHandler("SumoAdv-TraCIOp")
def traci_unsubscribe(actor_id, domain=traci.vehicle):
    domain.unsubscribe(actor_id)

@GlobalExceptionHandler("SumoAdv-TraCIOp")
def traci_destroy():
    traci.close(False)