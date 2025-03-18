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

class TrackingStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.halfCycleSubtracted = null;
      this.carrierPhaseValid = null;
      this.pseudorangeValid = null;
      this.halfCycleValid = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('halfCycleSubtracted')) {
        this.halfCycleSubtracted = initObj.halfCycleSubtracted
      }
      else {
        this.halfCycleSubtracted = false;
      }
      if (initObj.hasOwnProperty('carrierPhaseValid')) {
        this.carrierPhaseValid = initObj.carrierPhaseValid
      }
      else {
        this.carrierPhaseValid = false;
      }
      if (initObj.hasOwnProperty('pseudorangeValid')) {
        this.pseudorangeValid = initObj.pseudorangeValid
      }
      else {
        this.pseudorangeValid = false;
      }
      if (initObj.hasOwnProperty('halfCycleValid')) {
        this.halfCycleValid = initObj.halfCycleValid
      }
      else {
        this.halfCycleValid = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrackingStatus
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [halfCycleSubtracted]
    bufferOffset = _serializer.bool(obj.halfCycleSubtracted, buffer, bufferOffset);
    // Serialize message field [carrierPhaseValid]
    bufferOffset = _serializer.bool(obj.carrierPhaseValid, buffer, bufferOffset);
    // Serialize message field [pseudorangeValid]
    bufferOffset = _serializer.bool(obj.pseudorangeValid, buffer, bufferOffset);
    // Serialize message field [halfCycleValid]
    bufferOffset = _serializer.bool(obj.halfCycleValid, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrackingStatus
    let len;
    let data = new TrackingStatus(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [halfCycleSubtracted]
    data.halfCycleSubtracted = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [carrierPhaseValid]
    data.carrierPhaseValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [pseudorangeValid]
    data.pseudorangeValid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [halfCycleValid]
    data.halfCycleValid = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/TrackingStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1e90e81b8d405c8d5cd8beba0fd09111';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    bool halfCycleSubtracted
    bool carrierPhaseValid
    bool pseudorangeValid
    bool halfCycleValid
    
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
    const resolved = new TrackingStatus(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.halfCycleSubtracted !== undefined) {
      resolved.halfCycleSubtracted = msg.halfCycleSubtracted;
    }
    else {
      resolved.halfCycleSubtracted = false
    }

    if (msg.carrierPhaseValid !== undefined) {
      resolved.carrierPhaseValid = msg.carrierPhaseValid;
    }
    else {
      resolved.carrierPhaseValid = false
    }

    if (msg.pseudorangeValid !== undefined) {
      resolved.pseudorangeValid = msg.pseudorangeValid;
    }
    else {
      resolved.pseudorangeValid = false
    }

    if (msg.halfCycleValid !== undefined) {
      resolved.halfCycleValid = msg.halfCycleValid;
    }
    else {
      resolved.halfCycleValid = false
    }

    return resolved;
    }
};

module.exports = TrackingStatus;
