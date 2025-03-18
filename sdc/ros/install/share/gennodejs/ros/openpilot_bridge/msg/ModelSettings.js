// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ModelSettings {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.bigBoxX = null;
      this.bigBoxY = null;
      this.inputTransform = null;
      this.bigBoxHeight = null;
      this.bigBoxWidth = null;
      this.boxProjection = null;
      this.yuvCorrection = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('bigBoxX')) {
        this.bigBoxX = initObj.bigBoxX
      }
      else {
        this.bigBoxX = 0;
      }
      if (initObj.hasOwnProperty('bigBoxY')) {
        this.bigBoxY = initObj.bigBoxY
      }
      else {
        this.bigBoxY = 0;
      }
      if (initObj.hasOwnProperty('inputTransform')) {
        this.inputTransform = initObj.inputTransform
      }
      else {
        this.inputTransform = [];
      }
      if (initObj.hasOwnProperty('bigBoxHeight')) {
        this.bigBoxHeight = initObj.bigBoxHeight
      }
      else {
        this.bigBoxHeight = 0;
      }
      if (initObj.hasOwnProperty('bigBoxWidth')) {
        this.bigBoxWidth = initObj.bigBoxWidth
      }
      else {
        this.bigBoxWidth = 0;
      }
      if (initObj.hasOwnProperty('boxProjection')) {
        this.boxProjection = initObj.boxProjection
      }
      else {
        this.boxProjection = [];
      }
      if (initObj.hasOwnProperty('yuvCorrection')) {
        this.yuvCorrection = initObj.yuvCorrection
      }
      else {
        this.yuvCorrection = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ModelSettings
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [bigBoxX]
    bufferOffset = _serializer.int64(obj.bigBoxX, buffer, bufferOffset);
    // Serialize message field [bigBoxY]
    bufferOffset = _serializer.int64(obj.bigBoxY, buffer, bufferOffset);
    // Serialize message field [inputTransform]
    bufferOffset = _arraySerializer.float32(obj.inputTransform, buffer, bufferOffset, null);
    // Serialize message field [bigBoxHeight]
    bufferOffset = _serializer.int64(obj.bigBoxHeight, buffer, bufferOffset);
    // Serialize message field [bigBoxWidth]
    bufferOffset = _serializer.int64(obj.bigBoxWidth, buffer, bufferOffset);
    // Serialize message field [boxProjection]
    bufferOffset = _arraySerializer.float32(obj.boxProjection, buffer, bufferOffset, null);
    // Serialize message field [yuvCorrection]
    bufferOffset = _arraySerializer.float32(obj.yuvCorrection, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ModelSettings
    let len;
    let data = new ModelSettings(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [bigBoxX]
    data.bigBoxX = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [bigBoxY]
    data.bigBoxY = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [inputTransform]
    data.inputTransform = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [bigBoxHeight]
    data.bigBoxHeight = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [bigBoxWidth]
    data.bigBoxWidth = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [boxProjection]
    data.boxProjection = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [yuvCorrection]
    data.yuvCorrection = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.inputTransform.length;
    length += 4 * object.boxProjection.length;
    length += 4 * object.yuvCorrection.length;
    return length + 44;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/ModelSettings';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'eb1d31c1be30c211c4413eefd71f6439';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 bigBoxX
    int64 bigBoxY
    float32[] inputTransform
    int64 bigBoxHeight
    int64 bigBoxWidth
    float32[] boxProjection
    float32[] yuvCorrection
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ModelSettings(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.bigBoxX !== undefined) {
      resolved.bigBoxX = msg.bigBoxX;
    }
    else {
      resolved.bigBoxX = 0
    }

    if (msg.bigBoxY !== undefined) {
      resolved.bigBoxY = msg.bigBoxY;
    }
    else {
      resolved.bigBoxY = 0
    }

    if (msg.inputTransform !== undefined) {
      resolved.inputTransform = msg.inputTransform;
    }
    else {
      resolved.inputTransform = []
    }

    if (msg.bigBoxHeight !== undefined) {
      resolved.bigBoxHeight = msg.bigBoxHeight;
    }
    else {
      resolved.bigBoxHeight = 0
    }

    if (msg.bigBoxWidth !== undefined) {
      resolved.bigBoxWidth = msg.bigBoxWidth;
    }
    else {
      resolved.bigBoxWidth = 0
    }

    if (msg.boxProjection !== undefined) {
      resolved.boxProjection = msg.boxProjection;
    }
    else {
      resolved.boxProjection = []
    }

    if (msg.yuvCorrection !== undefined) {
      resolved.yuvCorrection = msg.yuvCorrection;
    }
    else {
      resolved.yuvCorrection = []
    }

    return resolved;
    }
};

module.exports = ModelSettings;
