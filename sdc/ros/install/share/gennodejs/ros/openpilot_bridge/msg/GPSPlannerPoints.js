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

class GPSPlannerPoints {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.accelTarget = null;
      this.pointsDEPRECATED = null;
      this.trackName = null;
      this.curPos = null;
      this.valid = null;
      this.speedLimit = null;
      this.curPosDEPRECATED = null;
      this.points = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('accelTarget')) {
        this.accelTarget = initObj.accelTarget
      }
      else {
        this.accelTarget = 0.0;
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
      if (initObj.hasOwnProperty('curPos')) {
        this.curPos = initObj.curPos
      }
      else {
        this.curPos = new ECEFPoint();
      }
      if (initObj.hasOwnProperty('valid')) {
        this.valid = initObj.valid
      }
      else {
        this.valid = false;
      }
      if (initObj.hasOwnProperty('speedLimit')) {
        this.speedLimit = initObj.speedLimit
      }
      else {
        this.speedLimit = 0.0;
      }
      if (initObj.hasOwnProperty('curPosDEPRECATED')) {
        this.curPosDEPRECATED = initObj.curPosDEPRECATED
      }
      else {
        this.curPosDEPRECATED = new ECEFPointDEPRECATED();
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
    // Serializes a message object of type GPSPlannerPoints
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [accelTarget]
    bufferOffset = _serializer.float32(obj.accelTarget, buffer, bufferOffset);
    // Serialize message field [pointsDEPRECATED]
    // Serialize the length for message field [pointsDEPRECATED]
    bufferOffset = _serializer.uint32(obj.pointsDEPRECATED.length, buffer, bufferOffset);
    obj.pointsDEPRECATED.forEach((val) => {
      bufferOffset = ECEFPointDEPRECATED.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [trackName]
    bufferOffset = _arraySerializer.string(obj.trackName, buffer, bufferOffset, null);
    // Serialize message field [curPos]
    bufferOffset = ECEFPoint.serialize(obj.curPos, buffer, bufferOffset);
    // Serialize message field [valid]
    bufferOffset = _serializer.bool(obj.valid, buffer, bufferOffset);
    // Serialize message field [speedLimit]
    bufferOffset = _serializer.float32(obj.speedLimit, buffer, bufferOffset);
    // Serialize message field [curPosDEPRECATED]
    bufferOffset = ECEFPointDEPRECATED.serialize(obj.curPosDEPRECATED, buffer, bufferOffset);
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = ECEFPoint.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GPSPlannerPoints
    let len;
    let data = new GPSPlannerPoints(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [accelTarget]
    data.accelTarget = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pointsDEPRECATED]
    // Deserialize array length for message field [pointsDEPRECATED]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.pointsDEPRECATED = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.pointsDEPRECATED[i] = ECEFPointDEPRECATED.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [trackName]
    data.trackName = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [curPos]
    data.curPos = ECEFPoint.deserialize(buffer, bufferOffset);
    // Deserialize message field [valid]
    data.valid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [speedLimit]
    data.speedLimit = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [curPosDEPRECATED]
    data.curPosDEPRECATED = ECEFPointDEPRECATED.deserialize(buffer, bufferOffset);
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
    length += ECEFPoint.getMessageSize(object.curPos);
    length += ECEFPointDEPRECATED.getMessageSize(object.curPosDEPRECATED);
    object.points.forEach((val) => {
      length += ECEFPoint.getMessageSize(val);
    });
    return length + 21;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/GPSPlannerPoints';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2dad0805756f4e9be824594497faa155';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    float32 accelTarget
    ECEFPointDEPRECATED[] pointsDEPRECATED
    string[] trackName
    ECEFPoint curPos
    bool valid
    float32 speedLimit
    ECEFPointDEPRECATED curPosDEPRECATED
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
    const resolved = new GPSPlannerPoints(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.accelTarget !== undefined) {
      resolved.accelTarget = msg.accelTarget;
    }
    else {
      resolved.accelTarget = 0.0
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

    if (msg.curPos !== undefined) {
      resolved.curPos = ECEFPoint.Resolve(msg.curPos)
    }
    else {
      resolved.curPos = new ECEFPoint()
    }

    if (msg.valid !== undefined) {
      resolved.valid = msg.valid;
    }
    else {
      resolved.valid = false
    }

    if (msg.speedLimit !== undefined) {
      resolved.speedLimit = msg.speedLimit;
    }
    else {
      resolved.speedLimit = 0.0
    }

    if (msg.curPosDEPRECATED !== undefined) {
      resolved.curPosDEPRECATED = ECEFPointDEPRECATED.Resolve(msg.curPosDEPRECATED)
    }
    else {
      resolved.curPosDEPRECATED = new ECEFPointDEPRECATED()
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

module.exports = GPSPlannerPoints;
