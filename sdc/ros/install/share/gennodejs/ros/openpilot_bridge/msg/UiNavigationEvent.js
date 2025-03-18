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

class UiNavigationEvent {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.status = null;
      this.distanceTo = null;
      this.type = null;
      this.endRoadPointDEPRECATED = null;
      this.endRoadPoint = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
      if (initObj.hasOwnProperty('distanceTo')) {
        this.distanceTo = initObj.distanceTo
      }
      else {
        this.distanceTo = 0.0;
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('endRoadPointDEPRECATED')) {
        this.endRoadPointDEPRECATED = initObj.endRoadPointDEPRECATED
      }
      else {
        this.endRoadPointDEPRECATED = new ECEFPointDEPRECATED();
      }
      if (initObj.hasOwnProperty('endRoadPoint')) {
        this.endRoadPoint = initObj.endRoadPoint
      }
      else {
        this.endRoadPoint = new ECEFPoint();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UiNavigationEvent
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _serializer.uint32(obj.status, buffer, bufferOffset);
    // Serialize message field [distanceTo]
    bufferOffset = _serializer.float32(obj.distanceTo, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.uint32(obj.type, buffer, bufferOffset);
    // Serialize message field [endRoadPointDEPRECATED]
    bufferOffset = ECEFPointDEPRECATED.serialize(obj.endRoadPointDEPRECATED, buffer, bufferOffset);
    // Serialize message field [endRoadPoint]
    bufferOffset = ECEFPoint.serialize(obj.endRoadPoint, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UiNavigationEvent
    let len;
    let data = new UiNavigationEvent(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [distanceTo]
    data.distanceTo = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [endRoadPointDEPRECATED]
    data.endRoadPointDEPRECATED = ECEFPointDEPRECATED.deserialize(buffer, bufferOffset);
    // Deserialize message field [endRoadPoint]
    data.endRoadPoint = ECEFPoint.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += ECEFPointDEPRECATED.getMessageSize(object.endRoadPointDEPRECATED);
    length += ECEFPoint.getMessageSize(object.endRoadPoint);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/UiNavigationEvent';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6c5e4c8da028603156189c75ad9e7343';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    uint32 status # enum const: Status
    float32 distanceTo
    uint32 type # enum const: Type
    ECEFPointDEPRECATED endRoadPointDEPRECATED
    ECEFPoint endRoadPoint
    
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
    const resolved = new UiNavigationEvent(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    if (msg.distanceTo !== undefined) {
      resolved.distanceTo = msg.distanceTo;
    }
    else {
      resolved.distanceTo = 0.0
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.endRoadPointDEPRECATED !== undefined) {
      resolved.endRoadPointDEPRECATED = ECEFPointDEPRECATED.Resolve(msg.endRoadPointDEPRECATED)
    }
    else {
      resolved.endRoadPointDEPRECATED = new ECEFPointDEPRECATED()
    }

    if (msg.endRoadPoint !== undefined) {
      resolved.endRoadPoint = ECEFPoint.Resolve(msg.endRoadPoint)
    }
    else {
      resolved.endRoadPoint = new ECEFPoint()
    }

    return resolved;
    }
};

module.exports = UiNavigationEvent;
