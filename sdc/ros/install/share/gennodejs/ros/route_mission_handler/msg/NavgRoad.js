// Auto-generated. Do not edit!

// (in-package route_mission_handler.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ItriPoint = require('./ItriPoint.js');
let ConnectedNavgRoad = require('./ConnectedNavgRoad.js');

//-----------------------------------------------------------

class NavgRoad {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.positiveLaneNum = null;
      this.negativeLaneNum = null;
      this.twoWay = null;
      this.positiveLaneIds = null;
      this.negativeLaneIds = null;
      this.mode = null;
      this.r_class = null;
      this.routing = null;
      this.n_as = null;
      this.n_kph = null;
      this.p_as = null;
      this.p_kph = null;
      this.length = null;
      this.points = null;
      this.heads = null;
      this.tails = null;
      this.type = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('positiveLaneNum')) {
        this.positiveLaneNum = initObj.positiveLaneNum
      }
      else {
        this.positiveLaneNum = 0;
      }
      if (initObj.hasOwnProperty('negativeLaneNum')) {
        this.negativeLaneNum = initObj.negativeLaneNum
      }
      else {
        this.negativeLaneNum = 0;
      }
      if (initObj.hasOwnProperty('twoWay')) {
        this.twoWay = initObj.twoWay
      }
      else {
        this.twoWay = false;
      }
      if (initObj.hasOwnProperty('positiveLaneIds')) {
        this.positiveLaneIds = initObj.positiveLaneIds
      }
      else {
        this.positiveLaneIds = [];
      }
      if (initObj.hasOwnProperty('negativeLaneIds')) {
        this.negativeLaneIds = initObj.negativeLaneIds
      }
      else {
        this.negativeLaneIds = [];
      }
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = 0;
      }
      if (initObj.hasOwnProperty('r_class')) {
        this.r_class = initObj.r_class
      }
      else {
        this.r_class = 0;
      }
      if (initObj.hasOwnProperty('routing')) {
        this.routing = initObj.routing
      }
      else {
        this.routing = 0;
      }
      if (initObj.hasOwnProperty('n_as')) {
        this.n_as = initObj.n_as
      }
      else {
        this.n_as = 0.0;
      }
      if (initObj.hasOwnProperty('n_kph')) {
        this.n_kph = initObj.n_kph
      }
      else {
        this.n_kph = 0.0;
      }
      if (initObj.hasOwnProperty('p_as')) {
        this.p_as = initObj.p_as
      }
      else {
        this.p_as = 0.0;
      }
      if (initObj.hasOwnProperty('p_kph')) {
        this.p_kph = initObj.p_kph
      }
      else {
        this.p_kph = 0.0;
      }
      if (initObj.hasOwnProperty('length')) {
        this.length = initObj.length
      }
      else {
        this.length = 0.0;
      }
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
      if (initObj.hasOwnProperty('heads')) {
        this.heads = initObj.heads
      }
      else {
        this.heads = [];
      }
      if (initObj.hasOwnProperty('tails')) {
        this.tails = initObj.tails
      }
      else {
        this.tails = [];
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NavgRoad
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [positiveLaneNum]
    bufferOffset = _serializer.int32(obj.positiveLaneNum, buffer, bufferOffset);
    // Serialize message field [negativeLaneNum]
    bufferOffset = _serializer.int32(obj.negativeLaneNum, buffer, bufferOffset);
    // Serialize message field [twoWay]
    bufferOffset = _serializer.bool(obj.twoWay, buffer, bufferOffset);
    // Serialize message field [positiveLaneIds]
    bufferOffset = _arraySerializer.int32(obj.positiveLaneIds, buffer, bufferOffset, null);
    // Serialize message field [negativeLaneIds]
    bufferOffset = _arraySerializer.int32(obj.negativeLaneIds, buffer, bufferOffset, null);
    // Serialize message field [mode]
    bufferOffset = _serializer.int32(obj.mode, buffer, bufferOffset);
    // Serialize message field [r_class]
    bufferOffset = _serializer.int32(obj.r_class, buffer, bufferOffset);
    // Serialize message field [routing]
    bufferOffset = _serializer.int32(obj.routing, buffer, bufferOffset);
    // Serialize message field [n_as]
    bufferOffset = _serializer.float32(obj.n_as, buffer, bufferOffset);
    // Serialize message field [n_kph]
    bufferOffset = _serializer.float32(obj.n_kph, buffer, bufferOffset);
    // Serialize message field [p_as]
    bufferOffset = _serializer.float32(obj.p_as, buffer, bufferOffset);
    // Serialize message field [p_kph]
    bufferOffset = _serializer.float32(obj.p_kph, buffer, bufferOffset);
    // Serialize message field [length]
    bufferOffset = _serializer.float32(obj.length, buffer, bufferOffset);
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = ItriPoint.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [heads]
    // Serialize the length for message field [heads]
    bufferOffset = _serializer.uint32(obj.heads.length, buffer, bufferOffset);
    obj.heads.forEach((val) => {
      bufferOffset = ConnectedNavgRoad.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [tails]
    // Serialize the length for message field [tails]
    bufferOffset = _serializer.uint32(obj.tails.length, buffer, bufferOffset);
    obj.tails.forEach((val) => {
      bufferOffset = ConnectedNavgRoad.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [type]
    bufferOffset = _serializer.int32(obj.type, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NavgRoad
    let len;
    let data = new NavgRoad(null);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [positiveLaneNum]
    data.positiveLaneNum = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [negativeLaneNum]
    data.negativeLaneNum = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [twoWay]
    data.twoWay = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [positiveLaneIds]
    data.positiveLaneIds = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [negativeLaneIds]
    data.negativeLaneIds = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [mode]
    data.mode = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [r_class]
    data.r_class = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [routing]
    data.routing = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [n_as]
    data.n_as = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [n_kph]
    data.n_kph = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [p_as]
    data.p_as = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [p_kph]
    data.p_kph = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [length]
    data.length = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [points]
    // Deserialize array length for message field [points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points[i] = ItriPoint.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [heads]
    // Deserialize array length for message field [heads]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.heads = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.heads[i] = ConnectedNavgRoad.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [tails]
    // Deserialize array length for message field [tails]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.tails = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.tails[i] = ConnectedNavgRoad.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [type]
    data.type = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.positiveLaneIds.length;
    length += 4 * object.negativeLaneIds.length;
    length += 68 * object.points.length;
    length += 12 * object.heads.length;
    length += 12 * object.tails.length;
    return length + 69;
  }

  static datatype() {
    // Returns string type for a message object
    return 'route_mission_handler/NavgRoad';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '73b8e8bb29e86ce8898fc956cfd316b4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 ITRI_AREA=5
    int32 EXPRESS_WAY=8
    int32 EXIT_GATEWAY=20
    int32 ENTRY_GATEWAY=21
    
    int32 id
    int32 positiveLaneNum
    int32 negativeLaneNum
    bool twoWay
    int32[] positiveLaneIds
    int32[] negativeLaneIds
    int32 mode
    int32 r_class
    int32 routing
    float32 n_as
    float32 n_kph
    float32 p_as
    float32 p_kph
    float32 length
    ItriPoint[] points
    ConnectedNavgRoad[] heads
    ConnectedNavgRoad[] tails
    int32 type
    
    ================================================================================
    MSG: route_mission_handler/ItriPoint
    int32 id
    int32 belongId
    int32 pointId
    geometry_msgs/Pose pose
    
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
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
    
    ================================================================================
    MSG: route_mission_handler/ConnectedNavgRoad
    int32 id
    int32 pointId
    float32 length
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new NavgRoad(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.positiveLaneNum !== undefined) {
      resolved.positiveLaneNum = msg.positiveLaneNum;
    }
    else {
      resolved.positiveLaneNum = 0
    }

    if (msg.negativeLaneNum !== undefined) {
      resolved.negativeLaneNum = msg.negativeLaneNum;
    }
    else {
      resolved.negativeLaneNum = 0
    }

    if (msg.twoWay !== undefined) {
      resolved.twoWay = msg.twoWay;
    }
    else {
      resolved.twoWay = false
    }

    if (msg.positiveLaneIds !== undefined) {
      resolved.positiveLaneIds = msg.positiveLaneIds;
    }
    else {
      resolved.positiveLaneIds = []
    }

    if (msg.negativeLaneIds !== undefined) {
      resolved.negativeLaneIds = msg.negativeLaneIds;
    }
    else {
      resolved.negativeLaneIds = []
    }

    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = 0
    }

    if (msg.r_class !== undefined) {
      resolved.r_class = msg.r_class;
    }
    else {
      resolved.r_class = 0
    }

    if (msg.routing !== undefined) {
      resolved.routing = msg.routing;
    }
    else {
      resolved.routing = 0
    }

    if (msg.n_as !== undefined) {
      resolved.n_as = msg.n_as;
    }
    else {
      resolved.n_as = 0.0
    }

    if (msg.n_kph !== undefined) {
      resolved.n_kph = msg.n_kph;
    }
    else {
      resolved.n_kph = 0.0
    }

    if (msg.p_as !== undefined) {
      resolved.p_as = msg.p_as;
    }
    else {
      resolved.p_as = 0.0
    }

    if (msg.p_kph !== undefined) {
      resolved.p_kph = msg.p_kph;
    }
    else {
      resolved.p_kph = 0.0
    }

    if (msg.length !== undefined) {
      resolved.length = msg.length;
    }
    else {
      resolved.length = 0.0
    }

    if (msg.points !== undefined) {
      resolved.points = new Array(msg.points.length);
      for (let i = 0; i < resolved.points.length; ++i) {
        resolved.points[i] = ItriPoint.Resolve(msg.points[i]);
      }
    }
    else {
      resolved.points = []
    }

    if (msg.heads !== undefined) {
      resolved.heads = new Array(msg.heads.length);
      for (let i = 0; i < resolved.heads.length; ++i) {
        resolved.heads[i] = ConnectedNavgRoad.Resolve(msg.heads[i]);
      }
    }
    else {
      resolved.heads = []
    }

    if (msg.tails !== undefined) {
      resolved.tails = new Array(msg.tails.length);
      for (let i = 0; i < resolved.tails.length; ++i) {
        resolved.tails[i] = ConnectedNavgRoad.Resolve(msg.tails[i]);
      }
    }
    else {
      resolved.tails = []
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    return resolved;
    }
};

// Constants for message
NavgRoad.Constants = {
  ITRI_AREA: 5,
  EXPRESS_WAY: 8,
  EXIT_GATEWAY: 20,
  ENTRY_GATEWAY: 21,
}

module.exports = NavgRoad;
