// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class AudibleAlert {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AudibleAlert
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AudibleAlert
    let len;
    let data = new AudibleAlert(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/AudibleAlert';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a3a43922546d4bc971a70d5e2c552051';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 none=0
    uint32 chimeDisengage=2
    uint32 chimeWarning1=4
    uint32 chimeWarning2=5
    uint32 chimeError=3
    uint32 chimePrompt=7
    uint32 chimeEngage=1
    uint32 chimeWarningRepeat=6
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AudibleAlert(null);
    return resolved;
    }
};

// Constants for message
AudibleAlert.Constants = {
  NONE: 0,
  CHIMEDISENGAGE: 2,
  CHIMEWARNING1: 4,
  CHIMEWARNING2: 5,
  CHIMEERROR: 3,
  CHIMEPROMPT: 7,
  CHIMEENGAGE: 1,
  CHIMEWARNINGREPEAT: 6,
}

module.exports = AudibleAlert;
