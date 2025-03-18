// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ECEFPointDEPRECATED = require('./ECEFPointDEPRECATED.js');
let ECEFPoint = require('./ECEFPoint.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class GPSPlannerPlan {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.acceleration = null;
      this.pointsDEPRECATED = null;
      this.trackName = null;
      this.poly = null;
      this.xLookahead = null;
      this.valid = null;
      this.speed = null;
      this.points = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('acceleration')) {
        this.acceleration = initObj.acceleration
      }
      else {
        this.acceleration = 0.0;
      }
      if (initObj.hasOwnProperty('pointsDEPRECATED')) {
        this.pointsDEPRECATED = initObj.pointsDEPRECATED
      }
      else {
        this.pointsDEPRECATED = [];
      }
      if (initObj.hasOwnProperty('trackName')) {
        this.trackName = initObj.trackName
      }
      else {
        this.trackName = [];
      }
      if (initObj.hasOwnProperty('poly')) {
        this.poly = initObj.poly
      }
      else {
        this.poly = [];
      }
      if (initObj.hasOwnProperty('xLookahead')) {
        this.xLookahead = initObj.xLookahead
      }
      else {
        this.xLookahead = 0.0;
      }
      if (initObj.hasOwnProperty('valid')) {
        this.valid = initObj.valid
      }
      else {
        this.valid = false;
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0.0;
      }
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GPSPlannerPlan
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [acceleration]
    bufferOffset = _serializer.float32(obj.acceleration, buffer, bufferOffset);
    // Serialize message field [pointsDEPRECATED]
    // Serialize the length for message field [pointsDEPRECATED]
    bufferOffset = _serializer.uint32(obj.pointsDEPRECATED.length, buffer, bufferOffset);
    obj.pointsDEPRECATED.forEach((val) => {
      bufferOffset = ECEFPointDEPRECATED.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [trackName]
    bufferOffset = _arraySerializer.string(obj.trackName, buffer, bufferOffset, null);
    // Serialize message field [poly]
    bufferOffset = _arraySerializer.float32(obj.poly, buffer, bufferOffset, null);
    // Serialize message field [xLookahead]
    bufferOffset = _serializer.float32(obj.xLookahead, buffer, bufferOffset);
    // Serialize message field [valid]
    bufferOffset = _serializer.bool(obj.valid, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _serializer.float32(obj.speed, buffer, bufferOffset);
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = ECEFPoint.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GPSPlannerPlan
    let len;
    let data = new GPSPlannerPlan(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [acceleration]
    data.acceleration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pointsDEPRECATED]
    // Deserialize array length for message field [pointsDEPRECATED]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.pointsDEPRECATED = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.pointsDEPRECATED[i] = ECEFPointDEPRECATED.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [trackName]
    data.trackName = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [poly]
    data.poly = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [xLookahead]
    data.xLookahead = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [valid]
    data.valid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [points]
    // Deserialize array length for message field [points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points[i] = ECEFPoint.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.pointsDEPRECATED.forEach((val) => {
      length += ECEFPointDEPRECATED.getMessageSize(val);
    });
    object.trackName.forEach((val) => {
      length += 4 + val.length;
    });
    length += 4 * object.poly.length;
    object.points.forEach((val) => {
      length += ECEFPoint.getMessageSize(val);
    });
    return length + 29;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/GPSPlannerPlan';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '998c57b3107ccfd3fc1d648cdbc3c857';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 acceleration
    ECEFPointDEPRECATED[] pointsDEPRECATED
    string[] trackName
    float32[] poly
    float32 xLookahead
    bool valid
    float32 speed
    ECEFPoint[] points
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: openpilot_bridge/ECEFPointDEPRECATED
    Header header
    
    float32 y
    float32 x
    float32 z
    
    ================================================================================
    MSG: openpilot_bridge/ECEFPoint
    Header header
    
    float32 y
    float32 x
    float32 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GPSPlannerPlan(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.acceleration !== undefined) {
      resolved.acceleration = msg.acceleration;
    }
    else {
      resolved.acceleration = 0.0
    }

    if (msg.pointsDEPRECATED !== undefined) {
      resolved.pointsDEPRECATED = new Array(msg.pointsDEPRECATED.length);
      for (let i = 0; i < resolved.pointsDEPRECATED.length; ++i) {
        resolved.pointsDEPRECATED[i] = ECEFPointDEPRECATED.Resolve(msg.pointsDEPRECATED[i]);
      }
    }
    else {
      resolved.pointsDEPRECATED = []
    }

    if (msg.trackName !== undefined) {
      resolved.trackName = msg.trackName;
    }
    else {
      resolved.trackName = []
    }

    if (msg.poly !== undefined) {
      resolved.poly = msg.poly;
    }
    else {
      resolved.poly = []
    }

    if (msg.xLookahead !== undefined) {
      resolved.xLookahead = msg.xLookahead;
    }
    else {
      resolved.xLookahead = 0.0
    }

    if (msg.valid !== undefined) {
      resolved.valid = msg.valid;
    }
    else {
      resolved.valid = false
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0.0
    }

    if (msg.points !== undefined) {
      resolved.points = new Array(msg.points.length);
      for (let i = 0; i < resolved.points.length; ++i) {
        resolved.points[i] = ECEFPoint.Resolve(msg.points[i]);
      }
    }
    else {
      resolved.points = []
    }

    return resolved;
    }
};

module.exports = GPSPlannerPlan;
