// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let sensor_msgs = _finder('sensor_msgs');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class TrafficLightObject {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.dontCare = null;
      this.green = null;
      this.left = null;
      this.red = null;
      this.right = null;
      this.straight = null;
      this.yellow = null;
      this.flashyellow = null;
      this.flashred = null;
      this.blocked = null;
      this.traffic_light_map_points = null;
      this.roi = null;
      this.score = null;
      this.id = null;
      this.distance = null;
      this.remain_sec = null;
      this.lights = null;
      this.lightsroi = null;
      this.source = null;
    }
    else {
      if (initObj.hasOwnProperty('dontCare')) {
        this.dontCare = initObj.dontCare
      }
      else {
        this.dontCare = false;
      }
      if (initObj.hasOwnProperty('green')) {
        this.green = initObj.green
      }
      else {
        this.green = false;
      }
      if (initObj.hasOwnProperty('left')) {
        this.left = initObj.left
      }
      else {
        this.left = false;
      }
      if (initObj.hasOwnProperty('red')) {
        this.red = initObj.red
      }
      else {
        this.red = false;
      }
      if (initObj.hasOwnProperty('right')) {
        this.right = initObj.right
      }
      else {
        this.right = false;
      }
      if (initObj.hasOwnProperty('straight')) {
        this.straight = initObj.straight
      }
      else {
        this.straight = false;
      }
      if (initObj.hasOwnProperty('yellow')) {
        this.yellow = initObj.yellow
      }
      else {
        this.yellow = false;
      }
      if (initObj.hasOwnProperty('flashyellow')) {
        this.flashyellow = initObj.flashyellow
      }
      else {
        this.flashyellow = false;
      }
      if (initObj.hasOwnProperty('flashred')) {
        this.flashred = initObj.flashred
      }
      else {
        this.flashred = false;
      }
      if (initObj.hasOwnProperty('blocked')) {
        this.blocked = initObj.blocked
      }
      else {
        this.blocked = false;
      }
      if (initObj.hasOwnProperty('traffic_light_map_points')) {
        this.traffic_light_map_points = initObj.traffic_light_map_points
      }
      else {
        this.traffic_light_map_points = new geometry_msgs.msg.Polygon();
      }
      if (initObj.hasOwnProperty('roi')) {
        this.roi = initObj.roi
      }
      else {
        this.roi = new sensor_msgs.msg.RegionOfInterest();
      }
      if (initObj.hasOwnProperty('score')) {
        this.score = initObj.score
      }
      else {
        this.score = 0.0;
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('distance')) {
        this.distance = initObj.distance
      }
      else {
        this.distance = 0.0;
      }
      if (initObj.hasOwnProperty('remain_sec')) {
        this.remain_sec = initObj.remain_sec
      }
      else {
        this.remain_sec = 0.0;
      }
      if (initObj.hasOwnProperty('lights')) {
        this.lights = initObj.lights
      }
      else {
        this.lights = [];
      }
      if (initObj.hasOwnProperty('lightsroi')) {
        this.lightsroi = initObj.lightsroi
      }
      else {
        this.lightsroi = [];
      }
      if (initObj.hasOwnProperty('source')) {
        this.source = initObj.source
      }
      else {
        this.source = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrafficLightObject
    // Serialize message field [dontCare]
    bufferOffset = _serializer.bool(obj.dontCare, buffer, bufferOffset);
    // Serialize message field [green]
    bufferOffset = _serializer.bool(obj.green, buffer, bufferOffset);
    // Serialize message field [left]
    bufferOffset = _serializer.bool(obj.left, buffer, bufferOffset);
    // Serialize message field [red]
    bufferOffset = _serializer.bool(obj.red, buffer, bufferOffset);
    // Serialize message field [right]
    bufferOffset = _serializer.bool(obj.right, buffer, bufferOffset);
    // Serialize message field [straight]
    bufferOffset = _serializer.bool(obj.straight, buffer, bufferOffset);
    // Serialize message field [yellow]
    bufferOffset = _serializer.bool(obj.yellow, buffer, bufferOffset);
    // Serialize message field [flashyellow]
    bufferOffset = _serializer.bool(obj.flashyellow, buffer, bufferOffset);
    // Serialize message field [flashred]
    bufferOffset = _serializer.bool(obj.flashred, buffer, bufferOffset);
    // Serialize message field [blocked]
    bufferOffset = _serializer.bool(obj.blocked, buffer, bufferOffset);
    // Serialize message field [traffic_light_map_points]
    bufferOffset = geometry_msgs.msg.Polygon.serialize(obj.traffic_light_map_points, buffer, bufferOffset);
    // Serialize message field [roi]
    bufferOffset = sensor_msgs.msg.RegionOfInterest.serialize(obj.roi, buffer, bufferOffset);
    // Serialize message field [score]
    bufferOffset = _serializer.float32(obj.score, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [distance]
    bufferOffset = _serializer.float32(obj.distance, buffer, bufferOffset);
    // Serialize message field [remain_sec]
    bufferOffset = _serializer.float32(obj.remain_sec, buffer, bufferOffset);
    // Serialize message field [lights]
    bufferOffset = _arraySerializer.string(obj.lights, buffer, bufferOffset, null);
    // Serialize message field [lightsroi]
    // Serialize the length for message field [lightsroi]
    bufferOffset = _serializer.uint32(obj.lightsroi.length, buffer, bufferOffset);
    obj.lightsroi.forEach((val) => {
      bufferOffset = sensor_msgs.msg.RegionOfInterest.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [source]
    bufferOffset = _serializer.uint8(obj.source, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrafficLightObject
    let len;
    let data = new TrafficLightObject(null);
    // Deserialize message field [dontCare]
    data.dontCare = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [green]
    data.green = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [left]
    data.left = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [red]
    data.red = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [right]
    data.right = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [straight]
    data.straight = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [yellow]
    data.yellow = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [flashyellow]
    data.flashyellow = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [flashred]
    data.flashred = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [blocked]
    data.blocked = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [traffic_light_map_points]
    data.traffic_light_map_points = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset);
    // Deserialize message field [roi]
    data.roi = sensor_msgs.msg.RegionOfInterest.deserialize(buffer, bufferOffset);
    // Deserialize message field [score]
    data.score = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [distance]
    data.distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [remain_sec]
    data.remain_sec = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [lights]
    data.lights = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [lightsroi]
    // Deserialize array length for message field [lightsroi]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.lightsroi = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.lightsroi[i] = sensor_msgs.msg.RegionOfInterest.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [source]
    data.source = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.Polygon.getMessageSize(object.traffic_light_map_points);
    object.lights.forEach((val) => {
      length += 4 + val.length;
    });
    length += 17 * object.lightsroi.length;
    return length + 52;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/TrafficLightObject';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f24c9677aaa490b50d0084132ed5fd5e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool dontCare
    bool green
    bool left
    bool red
    bool right
    bool straight
    bool yellow
    bool flashyellow
    bool flashred
    
    bool blocked
    geometry_msgs/Polygon traffic_light_map_points
    sensor_msgs/RegionOfInterest roi
    float32 score
    
    int32 id
    float32 distance
    float32 remain_sec
    string[] lights
    sensor_msgs/RegionOfInterest[] lightsroi
    
    uint8 DETECTOR=0
    uint8 RSU=1
    uint8 source
    
    ================================================================================
    MSG: geometry_msgs/Polygon
    #A specification of a polygon where the first and last points are assumed to be connected
    Point32[] points
    
    ================================================================================
    MSG: geometry_msgs/Point32
    # This contains the position of a point in free space(with 32 bits of precision).
    # It is recommeded to use Point wherever possible instead of Point32.  
    # 
    # This recommendation is to promote interoperability.  
    #
    # This message is designed to take up less space when sending
    # lots of points at once, as in the case of a PointCloud.  
    
    float32 x
    float32 y
    float32 z
    ================================================================================
    MSG: sensor_msgs/RegionOfInterest
    # This message is used to specify a region of interest within an image.
    #
    # When used to specify the ROI setting of the camera when the image was
    # taken, the height and width fields should either match the height and
    # width fields for the associated image; or height = width = 0
    # indicates that the full resolution image was captured.
    
    uint32 x_offset  # Leftmost pixel of the ROI
                     # (0 if the ROI includes the left edge of the image)
    uint32 y_offset  # Topmost pixel of the ROI
                     # (0 if the ROI includes the top edge of the image)
    uint32 height    # Height of ROI
    uint32 width     # Width of ROI
    
    # True if a distinct rectified ROI should be calculated from the "raw"
    # ROI in this message. Typically this should be False if the full image
    # is captured (ROI not used), and True if a subwindow is captured (ROI
    # used).
    bool do_rectify
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TrafficLightObject(null);
    if (msg.dontCare !== undefined) {
      resolved.dontCare = msg.dontCare;
    }
    else {
      resolved.dontCare = false
    }

    if (msg.green !== undefined) {
      resolved.green = msg.green;
    }
    else {
      resolved.green = false
    }

    if (msg.left !== undefined) {
      resolved.left = msg.left;
    }
    else {
      resolved.left = false
    }

    if (msg.red !== undefined) {
      resolved.red = msg.red;
    }
    else {
      resolved.red = false
    }

    if (msg.right !== undefined) {
      resolved.right = msg.right;
    }
    else {
      resolved.right = false
    }

    if (msg.straight !== undefined) {
      resolved.straight = msg.straight;
    }
    else {
      resolved.straight = false
    }

    if (msg.yellow !== undefined) {
      resolved.yellow = msg.yellow;
    }
    else {
      resolved.yellow = false
    }

    if (msg.flashyellow !== undefined) {
      resolved.flashyellow = msg.flashyellow;
    }
    else {
      resolved.flashyellow = false
    }

    if (msg.flashred !== undefined) {
      resolved.flashred = msg.flashred;
    }
    else {
      resolved.flashred = false
    }

    if (msg.blocked !== undefined) {
      resolved.blocked = msg.blocked;
    }
    else {
      resolved.blocked = false
    }

    if (msg.traffic_light_map_points !== undefined) {
      resolved.traffic_light_map_points = geometry_msgs.msg.Polygon.Resolve(msg.traffic_light_map_points)
    }
    else {
      resolved.traffic_light_map_points = new geometry_msgs.msg.Polygon()
    }

    if (msg.roi !== undefined) {
      resolved.roi = sensor_msgs.msg.RegionOfInterest.Resolve(msg.roi)
    }
    else {
      resolved.roi = new sensor_msgs.msg.RegionOfInterest()
    }

    if (msg.score !== undefined) {
      resolved.score = msg.score;
    }
    else {
      resolved.score = 0.0
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.distance !== undefined) {
      resolved.distance = msg.distance;
    }
    else {
      resolved.distance = 0.0
    }

    if (msg.remain_sec !== undefined) {
      resolved.remain_sec = msg.remain_sec;
    }
    else {
      resolved.remain_sec = 0.0
    }

    if (msg.lights !== undefined) {
      resolved.lights = msg.lights;
    }
    else {
      resolved.lights = []
    }

    if (msg.lightsroi !== undefined) {
      resolved.lightsroi = new Array(msg.lightsroi.length);
      for (let i = 0; i < resolved.lightsroi.length; ++i) {
        resolved.lightsroi[i] = sensor_msgs.msg.RegionOfInterest.Resolve(msg.lightsroi[i]);
      }
    }
    else {
      resolved.lightsroi = []
    }

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
TrafficLightObject.Constants = {
  DETECTOR: 0,
  RSU: 1,
}

module.exports = TrafficLightObject;
