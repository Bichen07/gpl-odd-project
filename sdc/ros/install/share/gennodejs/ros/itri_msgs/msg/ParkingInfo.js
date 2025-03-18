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

class ParkingInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.totalParkingPathCount = null;
      this.currentPathNumber = null;
    }
    else {
      if (initObj.hasOwnProperty('totalParkingPathCount')) {
        this.totalParkingPathCount = initObj.totalParkingPathCount
      }
      else {
        this.totalParkingPathCount = 0;
      }
      if (initObj.hasOwnProperty('currentPathNumber')) {
        this.currentPathNumber = initObj.currentPathNumber
      }
      else {
        this.currentPathNumber = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ParkingInfo
    // Serialize message field [totalParkingPathCount]
    bufferOffset = _serializer.int32(obj.totalParkingPathCount, buffer, bufferOffset);
    // Serialize message field [currentPathNumber]
    bufferOffset = _serializer.int32(obj.currentPathNumber, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ParkingInfo
    let len;
    let data = new ParkingInfo(null);
    // Deserialize message field [totalParkingPathCount]
    data.totalParkingPathCount = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [currentPathNumber]
    data.currentPathNumber = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/ParkingInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4ee64eeb93cd6229d15145ec3ca31a85';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 totalParkingPathCount
    int32 currentPathNumber
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ParkingInfo(null);
    if (msg.totalParkingPathCount !== undefined) {
      resolved.totalParkingPathCount = msg.totalParkingPathCount;
    }
    else {
      resolved.totalParkingPathCount = 0
    }

    if (msg.currentPathNumber !== undefined) {
      resolved.currentPathNumber = msg.currentPathNumber;
    }
    else {
      resolved.currentPathNumber = 0
    }

    return resolved;
    }
};

module.exports = ParkingInfo;
