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

class SafetyModel {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SafetyModel
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SafetyModel
    let len;
    let data = new SafetyModel(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/SafetyModel';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '535e7f80c93c8bb9ee4cf2f9bad94533';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 hondaBoschGiraffe=5
    uint32 hondaNidec=1
    uint32 tesla=10
    uint32 subaru=11
    uint32 gm=4
    uint32 volkswagenPq=21
    uint32 silent=0
    uint32 noOutput=19
    uint32 allOutput=17
    uint32 elm327=3
    uint32 gmPassive=12
    uint32 cadillac=7
    uint32 hyundai=8
    uint32 ford=6
    uint32 mazda=13
    uint32 hondaBoschHarness=20
    uint32 volkswagen=15
    uint32 toyotaIpas=16
    uint32 nissan=14
    uint32 toyota=2
    uint32 chrysler=9
    uint32 gmAscm=18
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SafetyModel(null);
    return resolved;
    }
};

// Constants for message
SafetyModel.Constants = {
  HONDABOSCHGIRAFFE: 5,
  HONDANIDEC: 1,
  TESLA: 10,
  SUBARU: 11,
  GM: 4,
  VOLKSWAGENPQ: 21,
  SILENT: 0,
  NOOUTPUT: 19,
  ALLOUTPUT: 17,
  ELM327: 3,
  GMPASSIVE: 12,
  CADILLAC: 7,
  HYUNDAI: 8,
  FORD: 6,
  MAZDA: 13,
  HONDABOSCHHARNESS: 20,
  VOLKSWAGEN: 15,
  TOYOTAIPAS: 16,
  NISSAN: 14,
  TOYOTA: 2,
  CHRYSLER: 9,
  GMASCM: 18,
}

module.exports = SafetyModel;
