// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ImageObj = require('./ImageObj.js');
let sensor_msgs = _finder('sensor_msgs');
let std_msgs = _finder('std_msgs');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class TrafficSignPipeline {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.image_topic = null;
      this.full_image = null;
      this.id = null;
      this.sign = null;
      this.x_enlarge_factor = null;
      this.y_enlarge_factor = null;
      this.x_offset_factor = null;
      this.y_offset_factor = null;
      this.distance = null;
      this.roi_image = null;
      this.tone_map_roi_image = null;
      this.traffic_sign_map_points = null;
      this.traffic_sign_points = null;
      this.traffic_sign_roi = null;
      this.all_traffic_sign_points = null;
      this.all_traffic_sign_roi = null;
      this.sign_box = null;
      this.has_sign = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('image_topic')) {
        this.image_topic = initObj.image_topic
      }
      else {
        this.image_topic = '';
      }
      if (initObj.hasOwnProperty('full_image')) {
        this.full_image = initObj.full_image
      }
      else {
        this.full_image = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('sign')) {
        this.sign = initObj.sign
      }
      else {
        this.sign = [];
      }
      if (initObj.hasOwnProperty('x_enlarge_factor')) {
        this.x_enlarge_factor = initObj.x_enlarge_factor
      }
      else {
        this.x_enlarge_factor = 0.0;
      }
      if (initObj.hasOwnProperty('y_enlarge_factor')) {
        this.y_enlarge_factor = initObj.y_enlarge_factor
      }
      else {
        this.y_enlarge_factor = 0.0;
      }
      if (initObj.hasOwnProperty('x_offset_factor')) {
        this.x_offset_factor = initObj.x_offset_factor
      }
      else {
        this.x_offset_factor = 0.0;
      }
      if (initObj.hasOwnProperty('y_offset_factor')) {
        this.y_offset_factor = initObj.y_offset_factor
      }
      else {
        this.y_offset_factor = 0.0;
      }
      if (initObj.hasOwnProperty('distance')) {
        this.distance = initObj.distance
      }
      else {
        this.distance = 0;
      }
      if (initObj.hasOwnProperty('roi_image')) {
        this.roi_image = initObj.roi_image
      }
      else {
        this.roi_image = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('tone_map_roi_image')) {
        this.tone_map_roi_image = initObj.tone_map_roi_image
      }
      else {
        this.tone_map_roi_image = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('traffic_sign_map_points')) {
        this.traffic_sign_map_points = initObj.traffic_sign_map_points
      }
      else {
        this.traffic_sign_map_points = new geometry_msgs.msg.Polygon();
      }
      if (initObj.hasOwnProperty('traffic_sign_points')) {
        this.traffic_sign_points = initObj.traffic_sign_points
      }
      else {
        this.traffic_sign_points = new geometry_msgs.msg.Polygon();
      }
      if (initObj.hasOwnProperty('traffic_sign_roi')) {
        this.traffic_sign_roi = initObj.traffic_sign_roi
      }
      else {
        this.traffic_sign_roi = new sensor_msgs.msg.RegionOfInterest();
      }
      if (initObj.hasOwnProperty('all_traffic_sign_points')) {
        this.all_traffic_sign_points = initObj.all_traffic_sign_points
      }
      else {
        this.all_traffic_sign_points = new geometry_msgs.msg.Polygon();
      }
      if (initObj.hasOwnProperty('all_traffic_sign_roi')) {
        this.all_traffic_sign_roi = initObj.all_traffic_sign_roi
      }
      else {
        this.all_traffic_sign_roi = [];
      }
      if (initObj.hasOwnProperty('sign_box')) {
        this.sign_box = initObj.sign_box
      }
      else {
        this.sign_box = new ImageObj();
      }
      if (initObj.hasOwnProperty('has_sign')) {
        this.has_sign = initObj.has_sign
      }
      else {
        this.has_sign = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrafficSignPipeline
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [image_topic]
    bufferOffset = _serializer.string(obj.image_topic, buffer, bufferOffset);
    // Serialize message field [full_image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.full_image, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [sign]
    bufferOffset = _arraySerializer.string(obj.sign, buffer, bufferOffset, null);
    // Serialize message field [x_enlarge_factor]
    bufferOffset = _serializer.float32(obj.x_enlarge_factor, buffer, bufferOffset);
    // Serialize message field [y_enlarge_factor]
    bufferOffset = _serializer.float32(obj.y_enlarge_factor, buffer, bufferOffset);
    // Serialize message field [x_offset_factor]
    bufferOffset = _serializer.float32(obj.x_offset_factor, buffer, bufferOffset);
    // Serialize message field [y_offset_factor]
    bufferOffset = _serializer.float32(obj.y_offset_factor, buffer, bufferOffset);
    // Serialize message field [distance]
    bufferOffset = _serializer.int32(obj.distance, buffer, bufferOffset);
    // Serialize message field [roi_image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.roi_image, buffer, bufferOffset);
    // Serialize message field [tone_map_roi_image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.tone_map_roi_image, buffer, bufferOffset);
    // Serialize message field [traffic_sign_map_points]
    bufferOffset = geometry_msgs.msg.Polygon.serialize(obj.traffic_sign_map_points, buffer, bufferOffset);
    // Serialize message field [traffic_sign_points]
    bufferOffset = geometry_msgs.msg.Polygon.serialize(obj.traffic_sign_points, buffer, bufferOffset);
    // Serialize message field [traffic_sign_roi]
    bufferOffset = sensor_msgs.msg.RegionOfInterest.serialize(obj.traffic_sign_roi, buffer, bufferOffset);
    // Serialize message field [all_traffic_sign_points]
    bufferOffset = geometry_msgs.msg.Polygon.serialize(obj.all_traffic_sign_points, buffer, bufferOffset);
    // Serialize message field [all_traffic_sign_roi]
    // Serialize the length for message field [all_traffic_sign_roi]
    bufferOffset = _serializer.uint32(obj.all_traffic_sign_roi.length, buffer, bufferOffset);
    obj.all_traffic_sign_roi.forEach((val) => {
      bufferOffset = sensor_msgs.msg.RegionOfInterest.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [sign_box]
    bufferOffset = ImageObj.serialize(obj.sign_box, buffer, bufferOffset);
    // Serialize message field [has_sign]
    bufferOffset = _serializer.bool(obj.has_sign, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrafficSignPipeline
    let len;
    let data = new TrafficSignPipeline(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [image_topic]
    data.image_topic = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [full_image]
    data.full_image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [sign]
    data.sign = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [x_enlarge_factor]
    data.x_enlarge_factor = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y_enlarge_factor]
    data.y_enlarge_factor = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [x_offset_factor]
    data.x_offset_factor = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [y_offset_factor]
    data.y_offset_factor = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [distance]
    data.distance = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [roi_image]
    data.roi_image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [tone_map_roi_image]
    data.tone_map_roi_image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [traffic_sign_map_points]
    data.traffic_sign_map_points = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset);
    // Deserialize message field [traffic_sign_points]
    data.traffic_sign_points = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset);
    // Deserialize message field [traffic_sign_roi]
    data.traffic_sign_roi = sensor_msgs.msg.RegionOfInterest.deserialize(buffer, bufferOffset);
    // Deserialize message field [all_traffic_sign_points]
    data.all_traffic_sign_points = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset);
    // Deserialize message field [all_traffic_sign_roi]
    // Deserialize array length for message field [all_traffic_sign_roi]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.all_traffic_sign_roi = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.all_traffic_sign_roi[i] = sensor_msgs.msg.RegionOfInterest.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [sign_box]
    data.sign_box = ImageObj.deserialize(buffer, bufferOffset);
    // Deserialize message field [has_sign]
    data.has_sign = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += object.image_topic.length;
    length += sensor_msgs.msg.Image.getMessageSize(object.full_image);
    object.sign.forEach((val) => {
      length += 4 + val.length;
    });
    length += sensor_msgs.msg.Image.getMessageSize(object.roi_image);
    length += sensor_msgs.msg.Image.getMessageSize(object.tone_map_roi_image);
    length += geometry_msgs.msg.Polygon.getMessageSize(object.traffic_sign_map_points);
    length += geometry_msgs.msg.Polygon.getMessageSize(object.traffic_sign_points);
    length += geometry_msgs.msg.Polygon.getMessageSize(object.all_traffic_sign_points);
    length += 17 * object.all_traffic_sign_roi.length;
    length += ImageObj.getMessageSize(object.sign_box);
    return length + 54;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/TrafficSignPipeline';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9d96c21a93fc96e16cde29646db6f0b8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # image info
    string image_topic
    sensor_msgs/Image full_image
    
    # semantic map info
    int32 id
    string[] sign
    
    float32 x_enlarge_factor
    float32 y_enlarge_factor
    float32 x_offset_factor
    float32 y_offset_factor
    
    # traffic_sign_projection info
    int32 distance
    sensor_msgs/Image roi_image
    sensor_msgs/Image tone_map_roi_image
    
    geometry_msgs/Polygon traffic_sign_map_points
    geometry_msgs/Polygon traffic_sign_points
    sensor_msgs/RegionOfInterest traffic_sign_roi
    
    geometry_msgs/Polygon all_traffic_sign_points
    sensor_msgs/RegionOfInterest[] all_traffic_sign_roi
    
    # traffic_sign_detection info
    itri_msgs/ImageObj sign_box
    
    # traffic_sign_status info
    bool has_sign
    
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
    MSG: sensor_msgs/Image
    # This message contains an uncompressed image
    # (0, 0) is at top-left corner of image
    #
    
    Header header        # Header timestamp should be acquisition time of image
                         # Header frame_id should be optical frame of camera
                         # origin of frame should be optical center of camera
                         # +x should point to the right in the image
                         # +y should point down in the image
                         # +z should point into to plane of the image
                         # If the frame_id here and the frame_id of the CameraInfo
                         # message associated with the image conflict
                         # the behavior is undefined
    
    uint32 height         # image height, that is, number of rows
    uint32 width          # image width, that is, number of columns
    
    # The legal values for encoding are in file src/image_encodings.cpp
    # If you want to standardize a new string format, join
    # ros-users@lists.sourceforge.net and send an email proposing a new encoding.
    
    string encoding       # Encoding of pixels -- channel meaning, ordering, size
                          # taken from the list of strings in include/sensor_msgs/image_encodings.h
    
    uint8 is_bigendian    # is this data bigendian?
    uint32 step           # Full row length in bytes
    uint8[] data          # actual matrix data, size is (step * rows)
    
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
    
    ================================================================================
    MSG: itri_msgs/ImageObj
    Header header
    string type
    ImageRect[] obj
    # XXX Should this message have 'score' ?
    
    ================================================================================
    MSG: itri_msgs/ImageRect
    int32 id
    int32 x
    int32 y
    int32 height
    int32 width
    float32 score
    string cls
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TrafficSignPipeline(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.image_topic !== undefined) {
      resolved.image_topic = msg.image_topic;
    }
    else {
      resolved.image_topic = ''
    }

    if (msg.full_image !== undefined) {
      resolved.full_image = sensor_msgs.msg.Image.Resolve(msg.full_image)
    }
    else {
      resolved.full_image = new sensor_msgs.msg.Image()
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.sign !== undefined) {
      resolved.sign = msg.sign;
    }
    else {
      resolved.sign = []
    }

    if (msg.x_enlarge_factor !== undefined) {
      resolved.x_enlarge_factor = msg.x_enlarge_factor;
    }
    else {
      resolved.x_enlarge_factor = 0.0
    }

    if (msg.y_enlarge_factor !== undefined) {
      resolved.y_enlarge_factor = msg.y_enlarge_factor;
    }
    else {
      resolved.y_enlarge_factor = 0.0
    }

    if (msg.x_offset_factor !== undefined) {
      resolved.x_offset_factor = msg.x_offset_factor;
    }
    else {
      resolved.x_offset_factor = 0.0
    }

    if (msg.y_offset_factor !== undefined) {
      resolved.y_offset_factor = msg.y_offset_factor;
    }
    else {
      resolved.y_offset_factor = 0.0
    }

    if (msg.distance !== undefined) {
      resolved.distance = msg.distance;
    }
    else {
      resolved.distance = 0
    }

    if (msg.roi_image !== undefined) {
      resolved.roi_image = sensor_msgs.msg.Image.Resolve(msg.roi_image)
    }
    else {
      resolved.roi_image = new sensor_msgs.msg.Image()
    }

    if (msg.tone_map_roi_image !== undefined) {
      resolved.tone_map_roi_image = sensor_msgs.msg.Image.Resolve(msg.tone_map_roi_image)
    }
    else {
      resolved.tone_map_roi_image = new sensor_msgs.msg.Image()
    }

    if (msg.traffic_sign_map_points !== undefined) {
      resolved.traffic_sign_map_points = geometry_msgs.msg.Polygon.Resolve(msg.traffic_sign_map_points)
    }
    else {
      resolved.traffic_sign_map_points = new geometry_msgs.msg.Polygon()
    }

    if (msg.traffic_sign_points !== undefined) {
      resolved.traffic_sign_points = geometry_msgs.msg.Polygon.Resolve(msg.traffic_sign_points)
    }
    else {
      resolved.traffic_sign_points = new geometry_msgs.msg.Polygon()
    }

    if (msg.traffic_sign_roi !== undefined) {
      resolved.traffic_sign_roi = sensor_msgs.msg.RegionOfInterest.Resolve(msg.traffic_sign_roi)
    }
    else {
      resolved.traffic_sign_roi = new sensor_msgs.msg.RegionOfInterest()
    }

    if (msg.all_traffic_sign_points !== undefined) {
      resolved.all_traffic_sign_points = geometry_msgs.msg.Polygon.Resolve(msg.all_traffic_sign_points)
    }
    else {
      resolved.all_traffic_sign_points = new geometry_msgs.msg.Polygon()
    }

    if (msg.all_traffic_sign_roi !== undefined) {
      resolved.all_traffic_sign_roi = new Array(msg.all_traffic_sign_roi.length);
      for (let i = 0; i < resolved.all_traffic_sign_roi.length; ++i) {
        resolved.all_traffic_sign_roi[i] = sensor_msgs.msg.RegionOfInterest.Resolve(msg.all_traffic_sign_roi[i]);
      }
    }
    else {
      resolved.all_traffic_sign_roi = []
    }

    if (msg.sign_box !== undefined) {
      resolved.sign_box = ImageObj.Resolve(msg.sign_box)
    }
    else {
      resolved.sign_box = new ImageObj()
    }

    if (msg.has_sign !== undefined) {
      resolved.has_sign = msg.has_sign;
    }
    else {
      resolved.has_sign = false
    }

    return resolved;
    }
};

module.exports = TrafficSignPipeline;
