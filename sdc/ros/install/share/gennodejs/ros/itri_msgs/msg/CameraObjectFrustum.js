// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class CameraObjectFrustum {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.Points = null;
      this.FaceInsidePlanesNorm = null;
    }
    else {
      if (initObj.hasOwnProperty('Points')) {
        this.Points = initObj.Points
      }
      else {
        this.Points = [];
      }
      if (initObj.hasOwnProperty('FaceInsidePlanesNorm')) {
        this.FaceInsidePlanesNorm = initObj.FaceInsidePlanesNorm
      }
      else {
        this.FaceInsidePlanesNorm = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CameraObjectFrustum
    // Serialize message field [Points]
    // Serialize the length for message field [Points]
    bufferOffset = _serializer.uint32(obj.Points.length, buffer, bufferOffset);
    obj.Points.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [FaceInsidePlanesNorm]
    // Serialize the length for message field [FaceInsidePlanesNorm]
    bufferOffset = _serializer.uint32(obj.FaceInsidePlanesNorm.length, buffer, bufferOffset);
    obj.FaceInsidePlanesNorm.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Quaternion.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CameraObjectFrustum
    let len;
    let data = new CameraObjectFrustum(null);
    // Deserialize message field [Points]
    // Deserialize array length for message field [Points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.Points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.Points[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [FaceInsidePlanesNorm]
    // Deserialize array length for message field [FaceInsidePlanesNorm]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.FaceInsidePlanesNorm = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.FaceInsidePlanesNorm[i] = geometry_msgs.msg.Quaternion.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 24 * object.Points.length;
    length += 32 * object.FaceInsidePlanesNorm.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/CameraObjectFrustum';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'be09e2784edfc92465e8db4d441a3c5b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/Point[] Points
    geometry_msgs/Quaternion[] FaceInsidePlanesNorm
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CameraObjectFrustum(null);
    if (msg.Points !== undefined) {
      resolved.Points = new Array(msg.Points.length);
      for (let i = 0; i < resolved.Points.length; ++i) {
        resolved.Points[i] = geometry_msgs.msg.Point.Resolve(msg.Points[i]);
      }
    }
    else {
      resolved.Points = []
    }

    if (msg.FaceInsidePlanesNorm !== undefined) {
      resolved.FaceInsidePlanesNorm = new Array(msg.FaceInsidePlanesNorm.length);
      for (let i = 0; i < resolved.FaceInsidePlanesNorm.length; ++i) {
        resolved.FaceInsidePlanesNorm[i] = geometry_msgs.msg.Quaternion.Resolve(msg.FaceInsidePlanesNorm[i]);
      }
    }
    else {
      resolved.FaceInsidePlanesNorm = []
    }

    return resolved;
    }
};

module.exports = CameraObjectFrustum;
