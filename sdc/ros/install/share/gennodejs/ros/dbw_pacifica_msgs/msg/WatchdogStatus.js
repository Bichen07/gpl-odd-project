// Auto-generated. Do not edit!

// (in-package dbw_pacifica_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class WatchdogStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.source = null;
    }
    else {
      if (initObj.hasOwnProperty('source')) {
        this.source = initObj.source
      }
      else {
        this.source = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WatchdogStatus
    // Serialize message field [source]
    bufferOffset = _serializer.uint8(obj.source, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WatchdogStatus
    let len;
    let data = new WatchdogStatus(null);
    // Deserialize message field [source]
    data.source = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a message object
    return 'dbw_pacifica_msgs/WatchdogStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3e7ee28e0afc591098518c8b9bf36b8a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 source
    
    uint8 NONE=0                        # No source for watchdog counter fault
    uint8 OTHER_BRAKE=1                 # Fault determined by brake controller
    uint8 OTHER_ACCELERATOR_PEDAL=2     # Fault determined by accelerator pedal controller
    uint8 OTHER_STEERING=3              # Fault determined by steering controller
    uint8 BRAKE_COUNTER=4               # Brake command counter failed to increment
    uint8 BRAKE_DISABLED=5              # Brake transition to disabled while in gear or moving
    uint8 BRAKE_COMMAND=6               # Brake command timeout after 100ms
    uint8 BRAKE_REPORT=7                # Brake report timeout after 100ms
    uint8 ACCELERATOR_PEDAL_COUNTER=8   # Accelerator pedal command counter failed to increment
    uint8 ACCELERATOR_PEDAL_DISABLED=9  # Accelerator pedal transition to disabled while in gear or moving
    uint8 ACCELERATOR_PEDAL_COMMAND=10  # Accelerator pedal command timeout after 100ms
    uint8 ACCELERATOR_PEDAL_REPORT=11   # Accelerator pedal report timeout after 100ms
    uint8 STEERING_COUNTER=12           # Steering command counter failed to increment
    uint8 STEERING_DISABLED=13          # Steering transition to disabled while in gear or moving
    uint8 STEERING_COMMAND=14           # Steering command timeout after 100ms
    uint8 STEERING_REPORT=15            # Steering report timeout after 100ms
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new WatchdogStatus(null);
    if (msg.source !== undefined) {
      resolved.source = msg.source;
    }
    else {
      resolved.source = 0
    }

    return resolved;
    }
};

// Constants for message
WatchdogStatus.Constants = {
  NONE: 0,
  OTHER_BRAKE: 1,
  OTHER_ACCELERATOR_PEDAL: 2,
  OTHER_STEERING: 3,
  BRAKE_COUNTER: 4,
  BRAKE_DISABLED: 5,
  BRAKE_COMMAND: 6,
  BRAKE_REPORT: 7,
  ACCELERATOR_PEDAL_COUNTER: 8,
  ACCELERATOR_PEDAL_DISABLED: 9,
  ACCELERATOR_PEDAL_COMMAND: 10,
  ACCELERATOR_PEDAL_REPORT: 11,
  STEERING_COUNTER: 12,
  STEERING_DISABLED: 13,
  STEERING_COMMAND: 14,
  STEERING_REPORT: 15,
}

module.exports = WatchdogStatus;
