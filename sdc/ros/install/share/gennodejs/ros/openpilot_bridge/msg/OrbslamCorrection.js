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

class OrbslamCorrection {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.correctionMonoTime = null;
      this.prePositionECEF = null;
      this.postPositionECEF = null;
      this.postPoseQuatECEF = null;
      this.numInliers = null;
      this.prePoseQuatECEF = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('correctionMonoTime')) {
        this.correctionMonoTime = initObj.correctionMonoTime
      }
      else {
        this.correctionMonoTime = 0;
      }
      if (initObj.hasOwnProperty('prePositionECEF')) {
        this.prePositionECEF = initObj.prePositionECEF
      }
      else {
        this.prePositionECEF = [];
      }
      if (initObj.hasOwnProperty('postPositionECEF')) {
        this.postPositionECEF = initObj.postPositionECEF
      }
      else {
        this.postPositionECEF = [];
      }
      if (initObj.hasOwnProperty('postPoseQuatECEF')) {
        this.postPoseQuatECEF = initObj.postPoseQuatECEF
      }
      else {
        this.postPoseQuatECEF = [];
      }
      if (initObj.hasOwnProperty('numInliers')) {
        this.numInliers = initObj.numInliers
      }
      else {
        this.numInliers = 0;
      }
      if (initObj.hasOwnProperty('prePoseQuatECEF')) {
        this.prePoseQuatECEF = initObj.prePoseQuatECEF
      }
      else {
        this.prePoseQuatECEF = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OrbslamCorrection
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [correctionMonoTime]
    bufferOffset = _serializer.int64(obj.correctionMonoTime, buffer, bufferOffset);
    // Serialize message field [prePositionECEF]
    bufferOffset = _arraySerializer.float32(obj.prePositionECEF, buffer, bufferOffset, null);
    // Serialize message field [postPositionECEF]
    bufferOffset = _arraySerializer.float32(obj.postPositionECEF, buffer, bufferOffset, null);
    // Serialize message field [postPoseQuatECEF]
    bufferOffset = _arraySerializer.float32(obj.postPoseQuatECEF, buffer, bufferOffset, null);
    // Serialize message field [numInliers]
    bufferOffset = _serializer.int64(obj.numInliers, buffer, bufferOffset);
    // Serialize message field [prePoseQuatECEF]
    bufferOffset = _arraySerializer.float32(obj.prePoseQuatECEF, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OrbslamCorrection
    let len;
    let data = new OrbslamCorrection(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [correctionMonoTime]
    data.correctionMonoTime = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [prePositionECEF]
    data.prePositionECEF = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [postPositionECEF]
    data.postPositionECEF = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [postPoseQuatECEF]
    data.postPoseQuatECEF = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [numInliers]
    data.numInliers = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [prePoseQuatECEF]
    data.prePoseQuatECEF = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 4 * object.prePositionECEF.length;
    length += 4 * object.postPositionECEF.length;
    length += 4 * object.postPoseQuatECEF.length;
    length += 4 * object.prePoseQuatECEF.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/OrbslamCorrection';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5782313d8262eba95695c847d7e1398d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    int64 correctionMonoTime
    float32[] prePositionECEF
    float32[] postPositionECEF
    float32[] postPoseQuatECEF
    int64 numInliers
    float32[] prePoseQuatECEF
    
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
    const resolved = new OrbslamCorrection(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.correctionMonoTime !== undefined) {
      resolved.correctionMonoTime = msg.correctionMonoTime;
    }
    else {
      resolved.correctionMonoTime = 0
    }

    if (msg.prePositionECEF !== undefined) {
      resolved.prePositionECEF = msg.prePositionECEF;
    }
    else {
      resolved.prePositionECEF = []
    }

    if (msg.postPositionECEF !== undefined) {
      resolved.postPositionECEF = msg.postPositionECEF;
    }
    else {
      resolved.postPositionECEF = []
    }

    if (msg.postPoseQuatECEF !== undefined) {
      resolved.postPoseQuatECEF = msg.postPoseQuatECEF;
    }
    else {
      resolved.postPoseQuatECEF = []
    }

    if (msg.numInliers !== undefined) {
      resolved.numInliers = msg.numInliers;
    }
    else {
      resolved.numInliers = 0
    }

    if (msg.prePoseQuatECEF !== undefined) {
      resolved.prePoseQuatECEF = msg.prePoseQuatECEF;
    }
    else {
      resolved.prePoseQuatECEF = []
    }

    return resolved;
    }
};

module.exports = OrbslamCorrection;
