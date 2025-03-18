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

class Instruction {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Instruction
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Instruction
    let len;
    let data = new Instruction(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Instruction';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0ae55be583a3a2e13a4008c6f0412834';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 uturn=19
    uint32 roundaboutUturn=13
    uint32 arrive=15
    uint32 roundaboutStraight=9
    uint32 turnLeft=0
    uint32 unkn12=12
    uint32 roundaboutExitNumber=5
    uint32 exitLeft=16
    uint32 unkn8=8
    uint32 turnRight=1
    uint32 roundaboutExit=6
    uint32 roundaboutTurnRight=11
    uint32 roundaboutTurnLeft=7
    uint32 unkn18=18
    uint32 exitRight=17
    uint32 keepRight=3
    uint32 unkn14=14
    uint32 keepLeft=2
    uint32 straight=4
    uint32 unkn10=10
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Instruction(null);
    return resolved;
    }
};

// Constants for message
Instruction.Constants = {
  UTURN: 19,
  ROUNDABOUTUTURN: 13,
  ARRIVE: 15,
  ROUNDABOUTSTRAIGHT: 9,
  TURNLEFT: 0,
  UNKN12: 12,
  ROUNDABOUTEXITNUMBER: 5,
  EXITLEFT: 16,
  UNKN8: 8,
  TURNRIGHT: 1,
  ROUNDABOUTEXIT: 6,
  ROUNDABOUTTURNRIGHT: 11,
  ROUNDABOUTTURNLEFT: 7,
  UNKN18: 18,
  EXITRIGHT: 17,
  KEEPRIGHT: 3,
  UNKN14: 14,
  KEEPLEFT: 2,
  STRAIGHT: 4,
  UNKN10: 10,
}

module.exports = Instruction;
