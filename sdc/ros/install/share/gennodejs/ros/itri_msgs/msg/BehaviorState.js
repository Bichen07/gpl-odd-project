// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class BehaviorState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.behavior_state = null;
      this.behavior_stete_string = null;
      this.obj_id = null;
      this.obstacles = null;
      this.avoidance = null;
    }
    else {
      if (initObj.hasOwnProperty('behavior_state')) {
        this.behavior_state = initObj.behavior_state
      }
      else {
        this.behavior_state = 0;
      }
      if (initObj.hasOwnProperty('behavior_stete_string')) {
        this.behavior_stete_string = initObj.behavior_stete_string
      }
      else {
        this.behavior_stete_string = '';
      }
      if (initObj.hasOwnProperty('obj_id')) {
        this.obj_id = initObj.obj_id
      }
      else {
        this.obj_id = 0;
      }
      if (initObj.hasOwnProperty('obstacles')) {
        this.obstacles = initObj.obstacles
      }
      else {
        this.obstacles = false;
      }
      if (initObj.hasOwnProperty('avoidance')) {
        this.avoidance = initObj.avoidance
      }
      else {
        this.avoidance = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BehaviorState
    // Serialize message field [behavior_state]
    bufferOffset = _serializer.int32(obj.behavior_state, buffer, bufferOffset);
    // Serialize message field [behavior_stete_string]
    bufferOffset = _serializer.string(obj.behavior_stete_string, buffer, bufferOffset);
    // Serialize message field [obj_id]
    bufferOffset = _serializer.int32(obj.obj_id, buffer, bufferOffset);
    // Serialize message field [obstacles]
    bufferOffset = _serializer.bool(obj.obstacles, buffer, bufferOffset);
    // Serialize message field [avoidance]
    bufferOffset = _serializer.bool(obj.avoidance, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BehaviorState
    let len;
    let data = new BehaviorState(null);
    // Deserialize message field [behavior_state]
    data.behavior_state = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [behavior_stete_string]
    data.behavior_stete_string = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [obj_id]
    data.obj_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [obstacles]
    data.obstacles = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [avoidance]
    data.avoidance = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.behavior_stete_string.length;
    return length + 14;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/BehaviorState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b7ef9dd36a2ceb7fe32edd273643bca2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 behavior_state
    string behavior_stete_string
    
    uint8 INITIAL = 0
    uint8 AEB = 1
    uint8 LANE_FOLLOW = 2
    uint8 LANE_CHANGE = 3
    uint8 AVOIDANCE = 4
    uint8 STOP = 5
    uint8 PARKING = 6
    uint8 EMERGENCY = 7
    uint8 FINISH = 8
    uint8 ACC = 9
    uint8 BUMP = 10
    uint8 INTERSECTION = 11
    uint8 TRAFFIC_LIGHT_RED = 12
    uint8 TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT = 13
    uint8 TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT = 14
    uint8 CURVE = 15
    uint8 SPEEDUP = 16
    uint8 DestinationWaypoints = 17
    uint8 DestinationGlobalPath = 18
    
    
    int32 obj_id
    bool obstacles
    bool avoidance
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BehaviorState(null);
    if (msg.behavior_state !== undefined) {
      resolved.behavior_state = msg.behavior_state;
    }
    else {
      resolved.behavior_state = 0
    }

    if (msg.behavior_stete_string !== undefined) {
      resolved.behavior_stete_string = msg.behavior_stete_string;
    }
    else {
      resolved.behavior_stete_string = ''
    }

    if (msg.obj_id !== undefined) {
      resolved.obj_id = msg.obj_id;
    }
    else {
      resolved.obj_id = 0
    }

    if (msg.obstacles !== undefined) {
      resolved.obstacles = msg.obstacles;
    }
    else {
      resolved.obstacles = false
    }

    if (msg.avoidance !== undefined) {
      resolved.avoidance = msg.avoidance;
    }
    else {
      resolved.avoidance = false
    }

    return resolved;
    }
};

// Constants for message
BehaviorState.Constants = {
  INITIAL: 0,
  AEB: 1,
  LANE_FOLLOW: 2,
  LANE_CHANGE: 3,
  AVOIDANCE: 4,
  STOP: 5,
  PARKING: 6,
  EMERGENCY: 7,
  FINISH: 8,
  ACC: 9,
  BUMP: 10,
  INTERSECTION: 11,
  TRAFFIC_LIGHT_RED: 12,
  TRAFFIC_LIGHT_WAIT_FOR_TURN_LEFT: 13,
  TRAFFIC_LIGHT_WAIT_FOR_TURN_RIGHT: 14,
  CURVE: 15,
  SPEEDUP: 16,
  DESTINATIONWAYPOINTS: 17,
  DESTINATIONGLOBALPATH: 18,
}

module.exports = BehaviorState;
