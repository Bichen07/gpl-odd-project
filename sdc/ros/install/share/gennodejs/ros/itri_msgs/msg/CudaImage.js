// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class CudaImage {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.height = null;
      this.width = null;
      this.encoding = null;
      this.ptr0 = null;
      this.ptr1 = null;
      this.ptr2 = null;
      this.step0 = null;
      this.step1 = null;
      this.step2 = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('height')) {
        this.height = initObj.height
      }
      else {
        this.height = 0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0;
      }
      if (initObj.hasOwnProperty('encoding')) {
        this.encoding = initObj.encoding
      }
      else {
        this.encoding = '';
      }
      if (initObj.hasOwnProperty('ptr0')) {
        this.ptr0 = initObj.ptr0
      }
      else {
        this.ptr0 = 0;
      }
      if (initObj.hasOwnProperty('ptr1')) {
        this.ptr1 = initObj.ptr1
      }
      else {
        this.ptr1 = 0;
      }
      if (initObj.hasOwnProperty('ptr2')) {
        this.ptr2 = initObj.ptr2
      }
      else {
        this.ptr2 = 0;
      }
      if (initObj.hasOwnProperty('step0')) {
        this.step0 = initObj.step0
      }
      else {
        this.step0 = 0;
      }
      if (initObj.hasOwnProperty('step1')) {
        this.step1 = initObj.step1
      }
      else {
        this.step1 = 0;
      }
      if (initObj.hasOwnProperty('step2')) {
        this.step2 = initObj.step2
      }
      else {
        this.step2 = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CudaImage
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [height]
    bufferOffset = _serializer.uint32(obj.height, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.uint32(obj.width, buffer, bufferOffset);
    // Serialize message field [encoding]
    bufferOffset = _serializer.string(obj.encoding, buffer, bufferOffset);
    // Serialize message field [ptr0]
    bufferOffset = _serializer.uint64(obj.ptr0, buffer, bufferOffset);
    // Serialize message field [ptr1]
    bufferOffset = _serializer.uint64(obj.ptr1, buffer, bufferOffset);
    // Serialize message field [ptr2]
    bufferOffset = _serializer.uint64(obj.ptr2, buffer, bufferOffset);
    // Serialize message field [step0]
    bufferOffset = _serializer.uint32(obj.step0, buffer, bufferOffset);
    // Serialize message field [step1]
    bufferOffset = _serializer.uint32(obj.step1, buffer, bufferOffset);
    // Serialize message field [step2]
    bufferOffset = _serializer.uint32(obj.step2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CudaImage
    let len;
    let data = new CudaImage(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [height]
    data.height = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [encoding]
    data.encoding = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [ptr0]
    data.ptr0 = _deserializer.uint64(buffer, bufferOffset);
    // Deserialize message field [ptr1]
    data.ptr1 = _deserializer.uint64(buffer, bufferOffset);
    // Deserialize message field [ptr2]
    data.ptr2 = _deserializer.uint64(buffer, bufferOffset);
    // Deserialize message field [step0]
    data.step0 = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [step1]
    data.step1 = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [step2]
    data.step2 = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += object.encoding.length;
    return length + 48;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/CudaImage';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fc947c96e9a65ec0628de254966abb43';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    uint32 height
    uint32 width
    
    string encoding
    
    uint64 ptr0
    uint64 ptr1
    uint64 ptr2
    uint32 step0
    uint32 step1
    uint32 step2
    
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
    const resolved = new CudaImage(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.height !== undefined) {
      resolved.height = msg.height;
    }
    else {
      resolved.height = 0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0
    }

    if (msg.encoding !== undefined) {
      resolved.encoding = msg.encoding;
    }
    else {
      resolved.encoding = ''
    }

    if (msg.ptr0 !== undefined) {
      resolved.ptr0 = msg.ptr0;
    }
    else {
      resolved.ptr0 = 0
    }

    if (msg.ptr1 !== undefined) {
      resolved.ptr1 = msg.ptr1;
    }
    else {
      resolved.ptr1 = 0
    }

    if (msg.ptr2 !== undefined) {
      resolved.ptr2 = msg.ptr2;
    }
    else {
      resolved.ptr2 = 0
    }

    if (msg.step0 !== undefined) {
      resolved.step0 = msg.step0;
    }
    else {
      resolved.step0 = 0
    }

    if (msg.step1 !== undefined) {
      resolved.step1 = msg.step1;
    }
    else {
      resolved.step1 = 0
    }

    if (msg.step2 !== undefined) {
      resolved.step2 = msg.step2;
    }
    else {
      resolved.step2 = 0
    }

    return resolved;
    }
};

module.exports = CudaImage;
