// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ECEFPoint = require('./ECEFPoint.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class OrbKeyFrame {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.descriptors = null;
      this.id = null;
      this.dpos = null;
      this.pos = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('descriptors')) {
        this.descriptors = initObj.descriptors
      }
      else {
        this.descriptors = [];
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('dpos')) {
        this.dpos = initObj.dpos
      }
      else {
        this.dpos = [];
      }
      if (initObj.hasOwnProperty('pos')) {
        this.pos = initObj.pos
      }
      else {
        this.pos = new ECEFPoint();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OrbKeyFrame
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [descriptors]
    bufferOffset = _arraySerializer.string(obj.descriptors, buffer, bufferOffset, null);
    // Serialize message field [id]
    bufferOffset = _serializer.int64(obj.id, buffer, bufferOffset);
    // Serialize message field [dpos]
    // Serialize the length for message field [dpos]
    bufferOffset = _serializer.uint32(obj.dpos.length, buffer, bufferOffset);
    obj.dpos.forEach((val) => {
      bufferOffset = ECEFPoint.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [pos]
    bufferOffset = ECEFPoint.serialize(obj.pos, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OrbKeyFrame
    let len;
    let data = new OrbKeyFrame(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [descriptors]
    data.descriptors = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [id]
    data.id = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [dpos]
    // Deserialize array length for message field [dpos]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.dpos = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.dpos[i] = ECEFPoint.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [pos]
    data.pos = ECEFPoint.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.descriptors.forEach((val) => {
      length += 4 + val.length;
    });
    object.dpos.forEach((val) => {
      length += ECEFPoint.getMessageSize(val);
    });
    length += ECEFPoint.getMessageSize(object.pos);
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/OrbKeyFrame';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd8cc48e698f9b09e2b374a7618b05a1e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    string[] descriptors
    int64 id
    ECEFPoint[] dpos
    ECEFPoint pos
    
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
    const resolved = new OrbKeyFrame(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.descriptors !== undefined) {
      resolved.descriptors = msg.descriptors;
    }
    else {
      resolved.descriptors = []
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.dpos !== undefined) {
      resolved.dpos = new Array(msg.dpos.length);
      for (let i = 0; i < resolved.dpos.length; ++i) {
        resolved.dpos[i] = ECEFPoint.Resolve(msg.dpos[i]);
      }
    }
    else {
      resolved.dpos = []
    }

    if (msg.pos !== undefined) {
      resolved.pos = ECEFPoint.Resolve(msg.pos)
    }
    else {
      resolved.pos = new ECEFPoint()
    }

    return resolved;
    }
};

module.exports = OrbKeyFrame;
