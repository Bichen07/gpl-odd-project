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

class Address {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.city = null;
      this.title = null;
      this.house = null;
      this.state = null;
      this.street = null;
      this.address = null;
      this.lat = null;
      this.lng = null;
      this.country = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('city')) {
        this.city = initObj.city
      }
      else {
        this.city = [];
      }
      if (initObj.hasOwnProperty('title')) {
        this.title = initObj.title
      }
      else {
        this.title = [];
      }
      if (initObj.hasOwnProperty('house')) {
        this.house = initObj.house
      }
      else {
        this.house = [];
      }
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = [];
      }
      if (initObj.hasOwnProperty('street')) {
        this.street = initObj.street
      }
      else {
        this.street = [];
      }
      if (initObj.hasOwnProperty('address')) {
        this.address = initObj.address
      }
      else {
        this.address = [];
      }
      if (initObj.hasOwnProperty('lat')) {
        this.lat = initObj.lat
      }
      else {
        this.lat = 0.0;
      }
      if (initObj.hasOwnProperty('lng')) {
        this.lng = initObj.lng
      }
      else {
        this.lng = 0.0;
      }
      if (initObj.hasOwnProperty('country')) {
        this.country = initObj.country
      }
      else {
        this.country = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Address
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [city]
    bufferOffset = _arraySerializer.string(obj.city, buffer, bufferOffset, null);
    // Serialize message field [title]
    bufferOffset = _arraySerializer.string(obj.title, buffer, bufferOffset, null);
    // Serialize message field [house]
    bufferOffset = _arraySerializer.string(obj.house, buffer, bufferOffset, null);
    // Serialize message field [state]
    bufferOffset = _arraySerializer.string(obj.state, buffer, bufferOffset, null);
    // Serialize message field [street]
    bufferOffset = _arraySerializer.string(obj.street, buffer, bufferOffset, null);
    // Serialize message field [address]
    bufferOffset = _arraySerializer.string(obj.address, buffer, bufferOffset, null);
    // Serialize message field [lat]
    bufferOffset = _serializer.float32(obj.lat, buffer, bufferOffset);
    // Serialize message field [lng]
    bufferOffset = _serializer.float32(obj.lng, buffer, bufferOffset);
    // Serialize message field [country]
    bufferOffset = _arraySerializer.string(obj.country, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Address
    let len;
    let data = new Address(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [city]
    data.city = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [title]
    data.title = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [house]
    data.house = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [state]
    data.state = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [street]
    data.street = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [address]
    data.address = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [lat]
    data.lat = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [lng]
    data.lng = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [country]
    data.country = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.city.forEach((val) => {
      length += 4 + val.length;
    });
    object.title.forEach((val) => {
      length += 4 + val.length;
    });
    object.house.forEach((val) => {
      length += 4 + val.length;
    });
    object.state.forEach((val) => {
      length += 4 + val.length;
    });
    object.street.forEach((val) => {
      length += 4 + val.length;
    });
    object.address.forEach((val) => {
      length += 4 + val.length;
    });
    object.country.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/Address';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e8f8610485d199d8ba159f7b07e0e495';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    string[] city
    string[] title
    string[] house
    string[] state
    string[] street
    string[] address
    float32 lat
    float32 lng
    string[] country
    
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
    const resolved = new Address(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.city !== undefined) {
      resolved.city = msg.city;
    }
    else {
      resolved.city = []
    }

    if (msg.title !== undefined) {
      resolved.title = msg.title;
    }
    else {
      resolved.title = []
    }

    if (msg.house !== undefined) {
      resolved.house = msg.house;
    }
    else {
      resolved.house = []
    }

    if (msg.state !== undefined) {
      resolved.state = msg.state;
    }
    else {
      resolved.state = []
    }

    if (msg.street !== undefined) {
      resolved.street = msg.street;
    }
    else {
      resolved.street = []
    }

    if (msg.address !== undefined) {
      resolved.address = msg.address;
    }
    else {
      resolved.address = []
    }

    if (msg.lat !== undefined) {
      resolved.lat = msg.lat;
    }
    else {
      resolved.lat = 0.0
    }

    if (msg.lng !== undefined) {
      resolved.lng = msg.lng;
    }
    else {
      resolved.lng = 0.0
    }

    if (msg.country !== undefined) {
      resolved.country = msg.country;
    }
    else {
      resolved.country = []
    }

    return resolved;
    }
};

module.exports = Address;
