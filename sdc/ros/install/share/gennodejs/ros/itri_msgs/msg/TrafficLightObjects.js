// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let TrafficLightObject = require('./TrafficLightObject.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class TrafficLightObjects {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.lights = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('lights')) {
        this.lights = initObj.lights
      }
      else {
        this.lights = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrafficLightObjects
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [lights]
    // Serialize the length for message field [lights]
    bufferOffset = _serializer.uint32(obj.lights.length, buffer, bufferOffset);
    obj.lights.forEach((val) => {
      bufferOffset = TrafficLightObject.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrafficLightObjects
    let len;
    let data = new TrafficLightObjects(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [lights]
    // Deserialize array length for message field [lights]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.lights = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.lights[i] = TrafficLightObject.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.lights.forEach((val) => {
      length += TrafficLightObject.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/TrafficLightObjects';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fe2c5dabf2fe93f365342371c20e525d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    TrafficLightObject[] lights
    
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
    
    ================================================================================
    MSG: itri_msgs/TrafficLightObject
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
    const resolved = new TrafficLightObjects(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.lights !== undefined) {
      resolved.lights = new Array(msg.lights.length);
      for (let i = 0; i < resolved.lights.length; ++i) {
        resolved.lights[i] = TrafficLightObject.Resolve(msg.lights[i]);
      }
    }
    else {
      resolved.lights = []
    }

    return resolved;
    }
};

module.exports = TrafficLightObjects;
