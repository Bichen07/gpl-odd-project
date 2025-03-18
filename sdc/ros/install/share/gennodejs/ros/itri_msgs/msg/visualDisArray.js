// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let visualDis = require('./visualDis.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class visualDisArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.carDis = null;
      this.busDis = null;
      this.truckDis = null;
      this.bicycleDis = null;
      this.motorbikeDis = null;
      this.personDis = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('carDis')) {
        this.carDis = initObj.carDis
      }
      else {
        this.carDis = [];
      }
      if (initObj.hasOwnProperty('busDis')) {
        this.busDis = initObj.busDis
      }
      else {
        this.busDis = [];
      }
      if (initObj.hasOwnProperty('truckDis')) {
        this.truckDis = initObj.truckDis
      }
      else {
        this.truckDis = [];
      }
      if (initObj.hasOwnProperty('bicycleDis')) {
        this.bicycleDis = initObj.bicycleDis
      }
      else {
        this.bicycleDis = [];
      }
      if (initObj.hasOwnProperty('motorbikeDis')) {
        this.motorbikeDis = initObj.motorbikeDis
      }
      else {
        this.motorbikeDis = [];
      }
      if (initObj.hasOwnProperty('personDis')) {
        this.personDis = initObj.personDis
      }
      else {
        this.personDis = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type visualDisArray
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [carDis]
    // Serialize the length for message field [carDis]
    bufferOffset = _serializer.uint32(obj.carDis.length, buffer, bufferOffset);
    obj.carDis.forEach((val) => {
      bufferOffset = visualDis.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [busDis]
    // Serialize the length for message field [busDis]
    bufferOffset = _serializer.uint32(obj.busDis.length, buffer, bufferOffset);
    obj.busDis.forEach((val) => {
      bufferOffset = visualDis.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [truckDis]
    // Serialize the length for message field [truckDis]
    bufferOffset = _serializer.uint32(obj.truckDis.length, buffer, bufferOffset);
    obj.truckDis.forEach((val) => {
      bufferOffset = visualDis.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [bicycleDis]
    // Serialize the length for message field [bicycleDis]
    bufferOffset = _serializer.uint32(obj.bicycleDis.length, buffer, bufferOffset);
    obj.bicycleDis.forEach((val) => {
      bufferOffset = visualDis.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [motorbikeDis]
    // Serialize the length for message field [motorbikeDis]
    bufferOffset = _serializer.uint32(obj.motorbikeDis.length, buffer, bufferOffset);
    obj.motorbikeDis.forEach((val) => {
      bufferOffset = visualDis.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [personDis]
    // Serialize the length for message field [personDis]
    bufferOffset = _serializer.uint32(obj.personDis.length, buffer, bufferOffset);
    obj.personDis.forEach((val) => {
      bufferOffset = visualDis.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type visualDisArray
    let len;
    let data = new visualDisArray(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [carDis]
    // Deserialize array length for message field [carDis]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.carDis = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.carDis[i] = visualDis.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [busDis]
    // Deserialize array length for message field [busDis]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.busDis = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.busDis[i] = visualDis.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [truckDis]
    // Deserialize array length for message field [truckDis]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.truckDis = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.truckDis[i] = visualDis.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [bicycleDis]
    // Deserialize array length for message field [bicycleDis]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.bicycleDis = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.bicycleDis[i] = visualDis.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [motorbikeDis]
    // Deserialize array length for message field [motorbikeDis]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.motorbikeDis = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.motorbikeDis[i] = visualDis.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [personDis]
    // Deserialize array length for message field [personDis]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.personDis = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.personDis[i] = visualDis.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 28 * object.carDis.length;
    length += 28 * object.busDis.length;
    length += 28 * object.truckDis.length;
    length += 28 * object.bicycleDis.length;
    length += 28 * object.motorbikeDis.length;
    length += 28 * object.personDis.length;
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/visualDisArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e2e9c59e0f49a1e406fa51abca933f4d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    visualDis[] carDis
    visualDis[] busDis
    visualDis[] truckDis
    visualDis[] bicycleDis
    visualDis[] motorbikeDis
    visualDis[] personDis
    
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
    MSG: itri_msgs/visualDis
    int32 realDis_x
    int32 realDis_y
    int32 x
    int32 y
    int32 height
    int32 width
    float32 score
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new visualDisArray(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.carDis !== undefined) {
      resolved.carDis = new Array(msg.carDis.length);
      for (let i = 0; i < resolved.carDis.length; ++i) {
        resolved.carDis[i] = visualDis.Resolve(msg.carDis[i]);
      }
    }
    else {
      resolved.carDis = []
    }

    if (msg.busDis !== undefined) {
      resolved.busDis = new Array(msg.busDis.length);
      for (let i = 0; i < resolved.busDis.length; ++i) {
        resolved.busDis[i] = visualDis.Resolve(msg.busDis[i]);
      }
    }
    else {
      resolved.busDis = []
    }

    if (msg.truckDis !== undefined) {
      resolved.truckDis = new Array(msg.truckDis.length);
      for (let i = 0; i < resolved.truckDis.length; ++i) {
        resolved.truckDis[i] = visualDis.Resolve(msg.truckDis[i]);
      }
    }
    else {
      resolved.truckDis = []
    }

    if (msg.bicycleDis !== undefined) {
      resolved.bicycleDis = new Array(msg.bicycleDis.length);
      for (let i = 0; i < resolved.bicycleDis.length; ++i) {
        resolved.bicycleDis[i] = visualDis.Resolve(msg.bicycleDis[i]);
      }
    }
    else {
      resolved.bicycleDis = []
    }

    if (msg.motorbikeDis !== undefined) {
      resolved.motorbikeDis = new Array(msg.motorbikeDis.length);
      for (let i = 0; i < resolved.motorbikeDis.length; ++i) {
        resolved.motorbikeDis[i] = visualDis.Resolve(msg.motorbikeDis[i]);
      }
    }
    else {
      resolved.motorbikeDis = []
    }

    if (msg.personDis !== undefined) {
      resolved.personDis = new Array(msg.personDis.length);
      for (let i = 0; i < resolved.personDis.length; ++i) {
        resolved.personDis[i] = visualDis.Resolve(msg.personDis[i]);
      }
    }
    else {
      resolved.personDis = []
    }

    return resolved;
    }
};

module.exports = visualDisArray;
