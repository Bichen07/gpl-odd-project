// Auto-generated. Do not edit!

// (in-package route_mission_handler.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class LoadRouteByFileNameSrvRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.selectedRouteFileName = null;
    }
    else {
      if (initObj.hasOwnProperty('selectedRouteFileName')) {
        this.selectedRouteFileName = initObj.selectedRouteFileName
      }
      else {
        this.selectedRouteFileName = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LoadRouteByFileNameSrvRequest
    // Serialize message field [selectedRouteFileName]
    bufferOffset = _serializer.string(obj.selectedRouteFileName, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LoadRouteByFileNameSrvRequest
    let len;
    let data = new LoadRouteByFileNameSrvRequest(null);
    // Deserialize message field [selectedRouteFileName]
    data.selectedRouteFileName = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.selectedRouteFileName.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'route_mission_handler/LoadRouteByFileNameSrvRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '68217d558fc6fb063653bf22c8dd0a04';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string selectedRouteFileName
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LoadRouteByFileNameSrvRequest(null);
    if (msg.selectedRouteFileName !== undefined) {
      resolved.selectedRouteFileName = msg.selectedRouteFileName;
    }
    else {
      resolved.selectedRouteFileName = ''
    }

    return resolved;
    }
};

class LoadRouteByFileNameSrvResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LoadRouteByFileNameSrvResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LoadRouteByFileNameSrvResponse
    let len;
    let data = new LoadRouteByFileNameSrvResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'route_mission_handler/LoadRouteByFileNameSrvResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LoadRouteByFileNameSrvResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: LoadRouteByFileNameSrvRequest,
  Response: LoadRouteByFileNameSrvResponse,
  md5sum() { return '68217d558fc6fb063653bf22c8dd0a04'; },
  datatype() { return 'route_mission_handler/LoadRouteByFileNameSrv'; }
};
