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

class TrafficLightPipeline {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.image_topic = null;
      this.tone_map_full_image = null;
      this.lights_full_image = null;
      this.id = null;
      this.light_status = null;
      this.light_rules = null;
      this.x_enlarge_factor = null;
      this.y_enlarge_factor = null;
      this.x_offset_factor = null;
      this.y_offset_factor = null;
      this.distance = null;
      this.tone_map_roi_image = null;
      this.lights_roi_image = null;
      this.traffic_light_map_points = null;
      this.traffic_light_points = null;
      this.traffic_light_roi = null;
      this.all_traffic_light_points = null;
      this.all_traffic_light_roi = null;
      this.tone_map_detect_light_box = null;
      this.tone_map_detect_light_status = null;
      this.lights_detect_light_status = null;
      this.merged_result_light_box = null;
      this.merged_result_red = null;
      this.merged_result_yellow = null;
      this.merged_result_green = null;
      this.merged_result_left = null;
      this.merged_result_straight = null;
      this.merged_result_right = null;
      this.red = null;
      this.yellow = null;
      this.green = null;
      this.left = null;
      this.straight = null;
      this.right = null;
      this.flashred = null;
      this.flashyellow = null;
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
      if (initObj.hasOwnProperty('tone_map_full_image')) {
        this.tone_map_full_image = initObj.tone_map_full_image
      }
      else {
        this.tone_map_full_image = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('lights_full_image')) {
        this.lights_full_image = initObj.lights_full_image
      }
      else {
        this.lights_full_image = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('light_status')) {
        this.light_status = initObj.light_status
      }
      else {
        this.light_status = [];
      }
      if (initObj.hasOwnProperty('light_rules')) {
        this.light_rules = initObj.light_rules
      }
      else {
        this.light_rules = [];
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
      if (initObj.hasOwnProperty('tone_map_roi_image')) {
        this.tone_map_roi_image = initObj.tone_map_roi_image
      }
      else {
        this.tone_map_roi_image = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('lights_roi_image')) {
        this.lights_roi_image = initObj.lights_roi_image
      }
      else {
        this.lights_roi_image = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('traffic_light_map_points')) {
        this.traffic_light_map_points = initObj.traffic_light_map_points
      }
      else {
        this.traffic_light_map_points = new geometry_msgs.msg.Polygon();
      }
      if (initObj.hasOwnProperty('traffic_light_points')) {
        this.traffic_light_points = initObj.traffic_light_points
      }
      else {
        this.traffic_light_points = new geometry_msgs.msg.Polygon();
      }
      if (initObj.hasOwnProperty('traffic_light_roi')) {
        this.traffic_light_roi = initObj.traffic_light_roi
      }
      else {
        this.traffic_light_roi = new sensor_msgs.msg.RegionOfInterest();
      }
      if (initObj.hasOwnProperty('all_traffic_light_points')) {
        this.all_traffic_light_points = initObj.all_traffic_light_points
      }
      else {
        this.all_traffic_light_points = new geometry_msgs.msg.Polygon();
      }
      if (initObj.hasOwnProperty('all_traffic_light_roi')) {
        this.all_traffic_light_roi = initObj.all_traffic_light_roi
      }
      else {
        this.all_traffic_light_roi = [];
      }
      if (initObj.hasOwnProperty('tone_map_detect_light_box')) {
        this.tone_map_detect_light_box = initObj.tone_map_detect_light_box
      }
      else {
        this.tone_map_detect_light_box = new ImageObj();
      }
      if (initObj.hasOwnProperty('tone_map_detect_light_status')) {
        this.tone_map_detect_light_status = initObj.tone_map_detect_light_status
      }
      else {
        this.tone_map_detect_light_status = new ImageObj();
      }
      if (initObj.hasOwnProperty('lights_detect_light_status')) {
        this.lights_detect_light_status = initObj.lights_detect_light_status
      }
      else {
        this.lights_detect_light_status = new ImageObj();
      }
      if (initObj.hasOwnProperty('merged_result_light_box')) {
        this.merged_result_light_box = initObj.merged_result_light_box
      }
      else {
        this.merged_result_light_box = false;
      }
      if (initObj.hasOwnProperty('merged_result_red')) {
        this.merged_result_red = initObj.merged_result_red
      }
      else {
        this.merged_result_red = false;
      }
      if (initObj.hasOwnProperty('merged_result_yellow')) {
        this.merged_result_yellow = initObj.merged_result_yellow
      }
      else {
        this.merged_result_yellow = false;
      }
      if (initObj.hasOwnProperty('merged_result_green')) {
        this.merged_result_green = initObj.merged_result_green
      }
      else {
        this.merged_result_green = false;
      }
      if (initObj.hasOwnProperty('merged_result_left')) {
        this.merged_result_left = initObj.merged_result_left
      }
      else {
        this.merged_result_left = false;
      }
      if (initObj.hasOwnProperty('merged_result_straight')) {
        this.merged_result_straight = initObj.merged_result_straight
      }
      else {
        this.merged_result_straight = false;
      }
      if (initObj.hasOwnProperty('merged_result_right')) {
        this.merged_result_right = initObj.merged_result_right
      }
      else {
        this.merged_result_right = false;
      }
      if (initObj.hasOwnProperty('red')) {
        this.red = initObj.red
      }
      else {
        this.red = false;
      }
      if (initObj.hasOwnProperty('yellow')) {
        this.yellow = initObj.yellow
      }
      else {
        this.yellow = false;
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
      if (initObj.hasOwnProperty('straight')) {
        this.straight = initObj.straight
      }
      else {
        this.straight = false;
      }
      if (initObj.hasOwnProperty('right')) {
        this.right = initObj.right
      }
      else {
        this.right = false;
      }
      if (initObj.hasOwnProperty('flashred')) {
        this.flashred = initObj.flashred
      }
      else {
        this.flashred = false;
      }
      if (initObj.hasOwnProperty('flashyellow')) {
        this.flashyellow = initObj.flashyellow
      }
      else {
        this.flashyellow = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TrafficLightPipeline
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [image_topic]
    bufferOffset = _serializer.string(obj.image_topic, buffer, bufferOffset);
    // Serialize message field [tone_map_full_image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.tone_map_full_image, buffer, bufferOffset);
    // Serialize message field [lights_full_image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.lights_full_image, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [light_status]
    bufferOffset = _arraySerializer.string(obj.light_status, buffer, bufferOffset, null);
    // Serialize message field [light_rules]
    bufferOffset = _arraySerializer.string(obj.light_rules, buffer, bufferOffset, null);
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
    // Serialize message field [tone_map_roi_image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.tone_map_roi_image, buffer, bufferOffset);
    // Serialize message field [lights_roi_image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.lights_roi_image, buffer, bufferOffset);
    // Serialize message field [traffic_light_map_points]
    bufferOffset = geometry_msgs.msg.Polygon.serialize(obj.traffic_light_map_points, buffer, bufferOffset);
    // Serialize message field [traffic_light_points]
    bufferOffset = geometry_msgs.msg.Polygon.serialize(obj.traffic_light_points, buffer, bufferOffset);
    // Serialize message field [traffic_light_roi]
    bufferOffset = sensor_msgs.msg.RegionOfInterest.serialize(obj.traffic_light_roi, buffer, bufferOffset);
    // Serialize message field [all_traffic_light_points]
    bufferOffset = geometry_msgs.msg.Polygon.serialize(obj.all_traffic_light_points, buffer, bufferOffset);
    // Serialize message field [all_traffic_light_roi]
    // Serialize the length for message field [all_traffic_light_roi]
    bufferOffset = _serializer.uint32(obj.all_traffic_light_roi.length, buffer, bufferOffset);
    obj.all_traffic_light_roi.forEach((val) => {
      bufferOffset = sensor_msgs.msg.RegionOfInterest.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [tone_map_detect_light_box]
    bufferOffset = ImageObj.serialize(obj.tone_map_detect_light_box, buffer, bufferOffset);
    // Serialize message field [tone_map_detect_light_status]
    bufferOffset = ImageObj.serialize(obj.tone_map_detect_light_status, buffer, bufferOffset);
    // Serialize message field [lights_detect_light_status]
    bufferOffset = ImageObj.serialize(obj.lights_detect_light_status, buffer, bufferOffset);
    // Serialize message field [merged_result_light_box]
    bufferOffset = _serializer.bool(obj.merged_result_light_box, buffer, bufferOffset);
    // Serialize message field [merged_result_red]
    bufferOffset = _serializer.bool(obj.merged_result_red, buffer, bufferOffset);
    // Serialize message field [merged_result_yellow]
    bufferOffset = _serializer.bool(obj.merged_result_yellow, buffer, bufferOffset);
    // Serialize message field [merged_result_green]
    bufferOffset = _serializer.bool(obj.merged_result_green, buffer, bufferOffset);
    // Serialize message field [merged_result_left]
    bufferOffset = _serializer.bool(obj.merged_result_left, buffer, bufferOffset);
    // Serialize message field [merged_result_straight]
    bufferOffset = _serializer.bool(obj.merged_result_straight, buffer, bufferOffset);
    // Serialize message field [merged_result_right]
    bufferOffset = _serializer.bool(obj.merged_result_right, buffer, bufferOffset);
    // Serialize message field [red]
    bufferOffset = _serializer.bool(obj.red, buffer, bufferOffset);
    // Serialize message field [yellow]
    bufferOffset = _serializer.bool(obj.yellow, buffer, bufferOffset);
    // Serialize message field [green]
    bufferOffset = _serializer.bool(obj.green, buffer, bufferOffset);
    // Serialize message field [left]
    bufferOffset = _serializer.bool(obj.left, buffer, bufferOffset);
    // Serialize message field [straight]
    bufferOffset = _serializer.bool(obj.straight, buffer, bufferOffset);
    // Serialize message field [right]
    bufferOffset = _serializer.bool(obj.right, buffer, bufferOffset);
    // Serialize message field [flashred]
    bufferOffset = _serializer.bool(obj.flashred, buffer, bufferOffset);
    // Serialize message field [flashyellow]
    bufferOffset = _serializer.bool(obj.flashyellow, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TrafficLightPipeline
    let len;
    let data = new TrafficLightPipeline(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [image_topic]
    data.image_topic = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [tone_map_full_image]
    data.tone_map_full_image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [lights_full_image]
    data.lights_full_image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [light_status]
    data.light_status = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [light_rules]
    data.light_rules = _arrayDeserializer.string(buffer, bufferOffset, null)
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
    // Deserialize message field [tone_map_roi_image]
    data.tone_map_roi_image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [lights_roi_image]
    data.lights_roi_image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [traffic_light_map_points]
    data.traffic_light_map_points = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset);
    // Deserialize message field [traffic_light_points]
    data.traffic_light_points = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset);
    // Deserialize message field [traffic_light_roi]
    data.traffic_light_roi = sensor_msgs.msg.RegionOfInterest.deserialize(buffer, bufferOffset);
    // Deserialize message field [all_traffic_light_points]
    data.all_traffic_light_points = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset);
    // Deserialize message field [all_traffic_light_roi]
    // Deserialize array length for message field [all_traffic_light_roi]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.all_traffic_light_roi = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.all_traffic_light_roi[i] = sensor_msgs.msg.RegionOfInterest.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [tone_map_detect_light_box]
    data.tone_map_detect_light_box = ImageObj.deserialize(buffer, bufferOffset);
    // Deserialize message field [tone_map_detect_light_status]
    data.tone_map_detect_light_status = ImageObj.deserialize(buffer, bufferOffset);
    // Deserialize message field [lights_detect_light_status]
    data.lights_detect_light_status = ImageObj.deserialize(buffer, bufferOffset);
    // Deserialize message field [merged_result_light_box]
    data.merged_result_light_box = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [merged_result_red]
    data.merged_result_red = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [merged_result_yellow]
    data.merged_result_yellow = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [merged_result_green]
    data.merged_result_green = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [merged_result_left]
    data.merged_result_left = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [merged_result_straight]
    data.merged_result_straight = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [merged_result_right]
    data.merged_result_right = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [red]
    data.red = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [yellow]
    data.yellow = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [green]
    data.green = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [left]
    data.left = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [straight]
    data.straight = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [right]
    data.right = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [flashred]
    data.flashred = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [flashyellow]
    data.flashyellow = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += object.image_topic.length;
    length += sensor_msgs.msg.Image.getMessageSize(object.tone_map_full_image);
    length += sensor_msgs.msg.Image.getMessageSize(object.lights_full_image);
    object.light_status.forEach((val) => {
      length += 4 + val.length;
    });
    object.light_rules.forEach((val) => {
      length += 4 + val.length;
    });
    length += sensor_msgs.msg.Image.getMessageSize(object.tone_map_roi_image);
    length += sensor_msgs.msg.Image.getMessageSize(object.lights_roi_image);
    length += geometry_msgs.msg.Polygon.getMessageSize(object.traffic_light_map_points);
    length += geometry_msgs.msg.Polygon.getMessageSize(object.traffic_light_points);
    length += geometry_msgs.msg.Polygon.getMessageSize(object.all_traffic_light_points);
    length += 17 * object.all_traffic_light_roi.length;
    length += ImageObj.getMessageSize(object.tone_map_detect_light_box);
    length += ImageObj.getMessageSize(object.tone_map_detect_light_status);
    length += ImageObj.getMessageSize(object.lights_detect_light_status);
    return length + 72;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/TrafficLightPipeline';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9f2248593a306be31f383e3661e2dc25';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # image info
    string image_topic
    sensor_msgs/Image tone_map_full_image
    sensor_msgs/Image lights_full_image
    
    # semantic map info
    int32 id
    string[] light_status
    string[] light_rules
    
    float32 x_enlarge_factor
    float32 y_enlarge_factor
    float32 x_offset_factor
    float32 y_offset_factor
    
    # traffic_light_projection info
    int32 distance
    sensor_msgs/Image tone_map_roi_image
    sensor_msgs/Image lights_roi_image
    geometry_msgs/Polygon traffic_light_map_points
    
    geometry_msgs/Polygon traffic_light_points
    sensor_msgs/RegionOfInterest traffic_light_roi
    geometry_msgs/Polygon all_traffic_light_points
    sensor_msgs/RegionOfInterest[] all_traffic_light_roi
    
    # traffic_light_detection info
    itri_msgs/ImageObj tone_map_detect_light_box
    itri_msgs/ImageObj tone_map_detect_light_status
    itri_msgs/ImageObj lights_detect_light_status
    
    # traffic_light_merge info
    bool merged_result_light_box
    bool merged_result_red
    bool merged_result_yellow
    bool merged_result_green
    bool merged_result_left
    bool merged_result_straight
    bool merged_result_right
    
    # traffic_light_queue info
    bool red
    bool yellow
    bool green
    bool left
    bool straight
    bool right
    bool flashred
    bool flashyellow
    
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
    const resolved = new TrafficLightPipeline(null);
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

    if (msg.tone_map_full_image !== undefined) {
      resolved.tone_map_full_image = sensor_msgs.msg.Image.Resolve(msg.tone_map_full_image)
    }
    else {
      resolved.tone_map_full_image = new sensor_msgs.msg.Image()
    }

    if (msg.lights_full_image !== undefined) {
      resolved.lights_full_image = sensor_msgs.msg.Image.Resolve(msg.lights_full_image)
    }
    else {
      resolved.lights_full_image = new sensor_msgs.msg.Image()
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.light_status !== undefined) {
      resolved.light_status = msg.light_status;
    }
    else {
      resolved.light_status = []
    }

    if (msg.light_rules !== undefined) {
      resolved.light_rules = msg.light_rules;
    }
    else {
      resolved.light_rules = []
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

    if (msg.tone_map_roi_image !== undefined) {
      resolved.tone_map_roi_image = sensor_msgs.msg.Image.Resolve(msg.tone_map_roi_image)
    }
    else {
      resolved.tone_map_roi_image = new sensor_msgs.msg.Image()
    }

    if (msg.lights_roi_image !== undefined) {
      resolved.lights_roi_image = sensor_msgs.msg.Image.Resolve(msg.lights_roi_image)
    }
    else {
      resolved.lights_roi_image = new sensor_msgs.msg.Image()
    }

    if (msg.traffic_light_map_points !== undefined) {
      resolved.traffic_light_map_points = geometry_msgs.msg.Polygon.Resolve(msg.traffic_light_map_points)
    }
    else {
      resolved.traffic_light_map_points = new geometry_msgs.msg.Polygon()
    }

    if (msg.traffic_light_points !== undefined) {
      resolved.traffic_light_points = geometry_msgs.msg.Polygon.Resolve(msg.traffic_light_points)
    }
    else {
      resolved.traffic_light_points = new geometry_msgs.msg.Polygon()
    }

    if (msg.traffic_light_roi !== undefined) {
      resolved.traffic_light_roi = sensor_msgs.msg.RegionOfInterest.Resolve(msg.traffic_light_roi)
    }
    else {
      resolved.traffic_light_roi = new sensor_msgs.msg.RegionOfInterest()
    }

    if (msg.all_traffic_light_points !== undefined) {
      resolved.all_traffic_light_points = geometry_msgs.msg.Polygon.Resolve(msg.all_traffic_light_points)
    }
    else {
      resolved.all_traffic_light_points = new geometry_msgs.msg.Polygon()
    }

    if (msg.all_traffic_light_roi !== undefined) {
      resolved.all_traffic_light_roi = new Array(msg.all_traffic_light_roi.length);
      for (let i = 0; i < resolved.all_traffic_light_roi.length; ++i) {
        resolved.all_traffic_light_roi[i] = sensor_msgs.msg.RegionOfInterest.Resolve(msg.all_traffic_light_roi[i]);
      }
    }
    else {
      resolved.all_traffic_light_roi = []
    }

    if (msg.tone_map_detect_light_box !== undefined) {
      resolved.tone_map_detect_light_box = ImageObj.Resolve(msg.tone_map_detect_light_box)
    }
    else {
      resolved.tone_map_detect_light_box = new ImageObj()
    }

    if (msg.tone_map_detect_light_status !== undefined) {
      resolved.tone_map_detect_light_status = ImageObj.Resolve(msg.tone_map_detect_light_status)
    }
    else {
      resolved.tone_map_detect_light_status = new ImageObj()
    }

    if (msg.lights_detect_light_status !== undefined) {
      resolved.lights_detect_light_status = ImageObj.Resolve(msg.lights_detect_light_status)
    }
    else {
      resolved.lights_detect_light_status = new ImageObj()
    }

    if (msg.merged_result_light_box !== undefined) {
      resolved.merged_result_light_box = msg.merged_result_light_box;
    }
    else {
      resolved.merged_result_light_box = false
    }

    if (msg.merged_result_red !== undefined) {
      resolved.merged_result_red = msg.merged_result_red;
    }
    else {
      resolved.merged_result_red = false
    }

    if (msg.merged_result_yellow !== undefined) {
      resolved.merged_result_yellow = msg.merged_result_yellow;
    }
    else {
      resolved.merged_result_yellow = false
    }

    if (msg.merged_result_green !== undefined) {
      resolved.merged_result_green = msg.merged_result_green;
    }
    else {
      resolved.merged_result_green = false
    }

    if (msg.merged_result_left !== undefined) {
      resolved.merged_result_left = msg.merged_result_left;
    }
    else {
      resolved.merged_result_left = false
    }

    if (msg.merged_result_straight !== undefined) {
      resolved.merged_result_straight = msg.merged_result_straight;
    }
    else {
      resolved.merged_result_straight = false
    }

    if (msg.merged_result_right !== undefined) {
      resolved.merged_result_right = msg.merged_result_right;
    }
    else {
      resolved.merged_result_right = false
    }

    if (msg.red !== undefined) {
      resolved.red = msg.red;
    }
    else {
      resolved.red = false
    }

    if (msg.yellow !== undefined) {
      resolved.yellow = msg.yellow;
    }
    else {
      resolved.yellow = false
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

    if (msg.straight !== undefined) {
      resolved.straight = msg.straight;
    }
    else {
      resolved.straight = false
    }

    if (msg.right !== undefined) {
      resolved.right = msg.right;
    }
    else {
      resolved.right = false
    }

    if (msg.flashred !== undefined) {
      resolved.flashred = msg.flashred;
    }
    else {
      resolved.flashred = false
    }

    if (msg.flashyellow !== undefined) {
      resolved.flashyellow = msg.flashyellow;
    }
    else {
      resolved.flashyellow = false
    }

    return resolved;
    }
};

module.exports = TrafficLightPipeline;
