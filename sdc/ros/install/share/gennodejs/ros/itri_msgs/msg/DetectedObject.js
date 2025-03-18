// Auto-generated. Do not edit!

// (in-package itri_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PredictedPath = require('./PredictedPath.js');
let Ars40xClusters = require('./Ars40xClusters.js');
let CameraObjectFrustum = require('./CameraObjectFrustum.js');
let sensor_msgs = _finder('sensor_msgs');
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class DetectedObject {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.id = null;
      this.label = null;
      this.score = null;
      this.color = null;
      this.trackedPeriod = null;
      this.pose = null;
      this.dimensions = null;
      this.variance = null;
      this.velocity = null;
      this.abs_velocity = null;
      this.convex_hull = null;
      this.pose_reliable = null;
      this.velocity_reliable = null;
      this.pointcloud = null;
      this.image_frame = null;
      this.x = null;
      this.y = null;
      this.width = null;
      this.height = null;
      this.angle = null;
      this.space_frame = null;
      this.behavior_state = null;
      this.history_path = null;
      this.predicted_poses = null;
      this.predicted_variance = null;
      this.predicted_paths = null;
      this.acceleration = null;
      this.radarFusionPoints = null;
      this.cameraObjectFrustum = null;
      this.overlapObjectsNumber = null;
      this.visibleSegments = null;
      this.image2Dcube = null;
      this.isMoving = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('label')) {
        this.label = initObj.label
      }
      else {
        this.label = '';
      }
      if (initObj.hasOwnProperty('score')) {
        this.score = initObj.score
      }
      else {
        this.score = 0.0;
      }
      if (initObj.hasOwnProperty('color')) {
        this.color = initObj.color
      }
      else {
        this.color = new std_msgs.msg.ColorRGBA();
      }
      if (initObj.hasOwnProperty('trackedPeriod')) {
        this.trackedPeriod = initObj.trackedPeriod
      }
      else {
        this.trackedPeriod = 0.0;
      }
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('dimensions')) {
        this.dimensions = initObj.dimensions
      }
      else {
        this.dimensions = new geometry_msgs.msg.Vector3();
      }
      if (initObj.hasOwnProperty('variance')) {
        this.variance = initObj.variance
      }
      else {
        this.variance = new geometry_msgs.msg.Vector3();
      }
      if (initObj.hasOwnProperty('velocity')) {
        this.velocity = initObj.velocity
      }
      else {
        this.velocity = new geometry_msgs.msg.Twist();
      }
      if (initObj.hasOwnProperty('abs_velocity')) {
        this.abs_velocity = initObj.abs_velocity
      }
      else {
        this.abs_velocity = new geometry_msgs.msg.Twist();
      }
      if (initObj.hasOwnProperty('convex_hull')) {
        this.convex_hull = initObj.convex_hull
      }
      else {
        this.convex_hull = new geometry_msgs.msg.PolygonStamped();
      }
      if (initObj.hasOwnProperty('pose_reliable')) {
        this.pose_reliable = initObj.pose_reliable
      }
      else {
        this.pose_reliable = false;
      }
      if (initObj.hasOwnProperty('velocity_reliable')) {
        this.velocity_reliable = initObj.velocity_reliable
      }
      else {
        this.velocity_reliable = false;
      }
      if (initObj.hasOwnProperty('pointcloud')) {
        this.pointcloud = initObj.pointcloud
      }
      else {
        this.pointcloud = new sensor_msgs.msg.PointCloud2();
      }
      if (initObj.hasOwnProperty('image_frame')) {
        this.image_frame = initObj.image_frame
      }
      else {
        this.image_frame = '';
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = 0;
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = 0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0;
      }
      if (initObj.hasOwnProperty('height')) {
        this.height = initObj.height
      }
      else {
        this.height = 0;
      }
      if (initObj.hasOwnProperty('angle')) {
        this.angle = initObj.angle
      }
      else {
        this.angle = 0.0;
      }
      if (initObj.hasOwnProperty('space_frame')) {
        this.space_frame = initObj.space_frame
      }
      else {
        this.space_frame = '';
      }
      if (initObj.hasOwnProperty('behavior_state')) {
        this.behavior_state = initObj.behavior_state
      }
      else {
        this.behavior_state = 0;
      }
      if (initObj.hasOwnProperty('history_path')) {
        this.history_path = initObj.history_path
      }
      else {
        this.history_path = [];
      }
      if (initObj.hasOwnProperty('predicted_poses')) {
        this.predicted_poses = initObj.predicted_poses
      }
      else {
        this.predicted_poses = [];
      }
      if (initObj.hasOwnProperty('predicted_variance')) {
        this.predicted_variance = initObj.predicted_variance
      }
      else {
        this.predicted_variance = [];
      }
      if (initObj.hasOwnProperty('predicted_paths')) {
        this.predicted_paths = initObj.predicted_paths
      }
      else {
        this.predicted_paths = [];
      }
      if (initObj.hasOwnProperty('acceleration')) {
        this.acceleration = initObj.acceleration
      }
      else {
        this.acceleration = new geometry_msgs.msg.Twist();
      }
      if (initObj.hasOwnProperty('radarFusionPoints')) {
        this.radarFusionPoints = initObj.radarFusionPoints
      }
      else {
        this.radarFusionPoints = new Ars40xClusters();
      }
      if (initObj.hasOwnProperty('cameraObjectFrustum')) {
        this.cameraObjectFrustum = initObj.cameraObjectFrustum
      }
      else {
        this.cameraObjectFrustum = new CameraObjectFrustum();
      }
      if (initObj.hasOwnProperty('overlapObjectsNumber')) {
        this.overlapObjectsNumber = initObj.overlapObjectsNumber
      }
      else {
        this.overlapObjectsNumber = 0;
      }
      if (initObj.hasOwnProperty('visibleSegments')) {
        this.visibleSegments = initObj.visibleSegments
      }
      else {
        this.visibleSegments = new geometry_msgs.msg.PolygonStamped();
      }
      if (initObj.hasOwnProperty('image2Dcube')) {
        this.image2Dcube = initObj.image2Dcube
      }
      else {
        this.image2Dcube = new geometry_msgs.msg.PolygonStamped();
      }
      if (initObj.hasOwnProperty('isMoving')) {
        this.isMoving = initObj.isMoving
      }
      else {
        this.isMoving = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DetectedObject
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.uint32(obj.id, buffer, bufferOffset);
    // Serialize message field [label]
    bufferOffset = _serializer.string(obj.label, buffer, bufferOffset);
    // Serialize message field [score]
    bufferOffset = _serializer.float32(obj.score, buffer, bufferOffset);
    // Serialize message field [color]
    bufferOffset = std_msgs.msg.ColorRGBA.serialize(obj.color, buffer, bufferOffset);
    // Serialize message field [trackedPeriod]
    bufferOffset = _serializer.float64(obj.trackedPeriod, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [dimensions]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.dimensions, buffer, bufferOffset);
    // Serialize message field [variance]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.variance, buffer, bufferOffset);
    // Serialize message field [velocity]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.velocity, buffer, bufferOffset);
    // Serialize message field [abs_velocity]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.abs_velocity, buffer, bufferOffset);
    // Serialize message field [convex_hull]
    bufferOffset = geometry_msgs.msg.PolygonStamped.serialize(obj.convex_hull, buffer, bufferOffset);
    // Serialize message field [pose_reliable]
    bufferOffset = _serializer.bool(obj.pose_reliable, buffer, bufferOffset);
    // Serialize message field [velocity_reliable]
    bufferOffset = _serializer.bool(obj.velocity_reliable, buffer, bufferOffset);
    // Serialize message field [pointcloud]
    bufferOffset = sensor_msgs.msg.PointCloud2.serialize(obj.pointcloud, buffer, bufferOffset);
    // Serialize message field [image_frame]
    bufferOffset = _serializer.string(obj.image_frame, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.int32(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.int32(obj.y, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.int32(obj.width, buffer, bufferOffset);
    // Serialize message field [height]
    bufferOffset = _serializer.int32(obj.height, buffer, bufferOffset);
    // Serialize message field [angle]
    bufferOffset = _serializer.float32(obj.angle, buffer, bufferOffset);
    // Serialize message field [space_frame]
    bufferOffset = _serializer.string(obj.space_frame, buffer, bufferOffset);
    // Serialize message field [behavior_state]
    bufferOffset = _serializer.uint32(obj.behavior_state, buffer, bufferOffset);
    // Serialize message field [history_path]
    // Serialize the length for message field [history_path]
    bufferOffset = _serializer.uint32(obj.history_path.length, buffer, bufferOffset);
    obj.history_path.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [predicted_poses]
    // Serialize the length for message field [predicted_poses]
    bufferOffset = _serializer.uint32(obj.predicted_poses.length, buffer, bufferOffset);
    obj.predicted_poses.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [predicted_variance]
    // Serialize the length for message field [predicted_variance]
    bufferOffset = _serializer.uint32(obj.predicted_variance.length, buffer, bufferOffset);
    obj.predicted_variance.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [predicted_paths]
    // Serialize the length for message field [predicted_paths]
    bufferOffset = _serializer.uint32(obj.predicted_paths.length, buffer, bufferOffset);
    obj.predicted_paths.forEach((val) => {
      bufferOffset = PredictedPath.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [acceleration]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.acceleration, buffer, bufferOffset);
    // Serialize message field [radarFusionPoints]
    bufferOffset = Ars40xClusters.serialize(obj.radarFusionPoints, buffer, bufferOffset);
    // Serialize message field [cameraObjectFrustum]
    bufferOffset = CameraObjectFrustum.serialize(obj.cameraObjectFrustum, buffer, bufferOffset);
    // Serialize message field [overlapObjectsNumber]
    bufferOffset = _serializer.int32(obj.overlapObjectsNumber, buffer, bufferOffset);
    // Serialize message field [visibleSegments]
    bufferOffset = geometry_msgs.msg.PolygonStamped.serialize(obj.visibleSegments, buffer, bufferOffset);
    // Serialize message field [image2Dcube]
    bufferOffset = geometry_msgs.msg.PolygonStamped.serialize(obj.image2Dcube, buffer, bufferOffset);
    // Serialize message field [isMoving]
    bufferOffset = _serializer.bool(obj.isMoving, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DetectedObject
    let len;
    let data = new DetectedObject(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [label]
    data.label = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [score]
    data.score = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [color]
    data.color = std_msgs.msg.ColorRGBA.deserialize(buffer, bufferOffset);
    // Deserialize message field [trackedPeriod]
    data.trackedPeriod = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [dimensions]
    data.dimensions = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [variance]
    data.variance = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [velocity]
    data.velocity = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [abs_velocity]
    data.abs_velocity = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [convex_hull]
    data.convex_hull = geometry_msgs.msg.PolygonStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [pose_reliable]
    data.pose_reliable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [velocity_reliable]
    data.velocity_reliable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [pointcloud]
    data.pointcloud = sensor_msgs.msg.PointCloud2.deserialize(buffer, bufferOffset);
    // Deserialize message field [image_frame]
    data.image_frame = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [height]
    data.height = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [angle]
    data.angle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [space_frame]
    data.space_frame = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [behavior_state]
    data.behavior_state = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [history_path]
    // Deserialize array length for message field [history_path]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.history_path = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.history_path[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [predicted_poses]
    // Deserialize array length for message field [predicted_poses]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.predicted_poses = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.predicted_poses[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [predicted_variance]
    // Deserialize array length for message field [predicted_variance]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.predicted_variance = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.predicted_variance[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [predicted_paths]
    // Deserialize array length for message field [predicted_paths]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.predicted_paths = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.predicted_paths[i] = PredictedPath.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [acceleration]
    data.acceleration = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [radarFusionPoints]
    data.radarFusionPoints = Ars40xClusters.deserialize(buffer, bufferOffset);
    // Deserialize message field [cameraObjectFrustum]
    data.cameraObjectFrustum = CameraObjectFrustum.deserialize(buffer, bufferOffset);
    // Deserialize message field [overlapObjectsNumber]
    data.overlapObjectsNumber = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [visibleSegments]
    data.visibleSegments = geometry_msgs.msg.PolygonStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [image2Dcube]
    data.image2Dcube = geometry_msgs.msg.PolygonStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [isMoving]
    data.isMoving = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += object.label.length;
    length += geometry_msgs.msg.PolygonStamped.getMessageSize(object.convex_hull);
    length += sensor_msgs.msg.PointCloud2.getMessageSize(object.pointcloud);
    length += object.image_frame.length;
    length += object.space_frame.length;
    length += 24 * object.history_path.length;
    length += 24 * object.predicted_poses.length;
    length += 24 * object.predicted_variance.length;
    object.predicted_paths.forEach((val) => {
      length += PredictedPath.getMessageSize(val);
    });
    length += Ars40xClusters.getMessageSize(object.radarFusionPoints);
    length += CameraObjectFrustum.getMessageSize(object.cameraObjectFrustum);
    length += geometry_msgs.msg.PolygonStamped.getMessageSize(object.visibleSegments);
    length += geometry_msgs.msg.PolygonStamped.getMessageSize(object.image2Dcube);
    return length + 339;
  }

  static datatype() {
    // Returns string type for a message object
    return 'itri_msgs/DetectedObject';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '10228fe6703d131d34e20f1a96859644';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    uint32 id
    string label
    float32 score
    std_msgs/ColorRGBA color
    float64 trackedPeriod
    
    geometry_msgs/Pose pose
    geometry_msgs/Vector3 dimensions
    geometry_msgs/Vector3 variance
    geometry_msgs/Twist velocity
    geometry_msgs/Twist abs_velocity
    
    geometry_msgs/PolygonStamped convex_hull
    
    bool pose_reliable
    bool velocity_reliable
    
    sensor_msgs/PointCloud2 pointcloud
    
    string image_frame
    int32 x
    int32 y
    int32 width
    int32 height
    float32 angle
    
    string space_frame
    
    # Behavior State of the Detected Object
    # FORWARD_STATE			= 0
    # STOPPING_STATE 		= 1
    # BRANCH_LEFT_STATE		= 2
    # BRANCH_RIGHT_STATE	= 3
    # YIELDING_STATE		= 4
    # ACCELERATING_STATE	= 5
    # SLOWDOWN_STATE 		= 6
    
    uint32 behavior_state
    
    geometry_msgs/Point[] history_path
    geometry_msgs/Point[] predicted_poses
    geometry_msgs/Point[] predicted_variance
    
    PredictedPath[] predicted_paths
    geometry_msgs/Twist acceleration
    
    Ars40xClusters radarFusionPoints
    CameraObjectFrustum cameraObjectFrustum
    int32 overlapObjectsNumber
    geometry_msgs/PolygonStamped visibleSegments
    geometry_msgs/PolygonStamped image2Dcube
    bool isMoving
    
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
    MSG: std_msgs/ColorRGBA
    float32 r
    float32 g
    float32 b
    float32 a
    
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
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    ================================================================================
    MSG: geometry_msgs/Twist
    # This expresses velocity in free space broken into its linear and angular parts.
    Vector3  linear
    Vector3  angular
    
    ================================================================================
    MSG: geometry_msgs/PolygonStamped
    # This represents a Polygon with reference coordinate frame and timestamp
    Header header
    Polygon polygon
    
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
    MSG: sensor_msgs/PointCloud2
    # This message holds a collection of N-dimensional points, which may
    # contain additional information such as normals, intensity, etc. The
    # point data is stored as a binary blob, its layout described by the
    # contents of the "fields" array.
    
    # The point cloud data may be organized 2d (image-like) or 1d
    # (unordered). Point clouds organized as 2d images may be produced by
    # camera depth sensors such as stereo or time-of-flight.
    
    # Time of sensor data acquisition, and the coordinate frame ID (for 3d
    # points).
    Header header
    
    # 2D structure of the point cloud. If the cloud is unordered, height is
    # 1 and width is the length of the point cloud.
    uint32 height
    uint32 width
    
    # Describes the channels and their layout in the binary data blob.
    PointField[] fields
    
    bool    is_bigendian # Is this data bigendian?
    uint32  point_step   # Length of a point in bytes
    uint32  row_step     # Length of a row in bytes
    uint8[] data         # Actual point data, size is (row_step*height)
    
    bool is_dense        # True if there are no invalid points
    
    ================================================================================
    MSG: sensor_msgs/PointField
    # This message holds the description of one point entry in the
    # PointCloud2 message format.
    uint8 INT8    = 1
    uint8 UINT8   = 2
    uint8 INT16   = 3
    uint8 UINT16  = 4
    uint8 INT32   = 5
    uint8 UINT32  = 6
    uint8 FLOAT32 = 7
    uint8 FLOAT64 = 8
    
    string name      # Name of field
    uint32 offset    # Offset from start of point struct
    uint8  datatype  # Datatype enumeration, see above
    uint32 count     # How many elements in the field
    
    ================================================================================
    MSG: itri_msgs/PredictedPath
    float32 probability
    geometry_msgs/Point[] predicted_path
    geometry_msgs/Point[] predicted_velocity
    
    ================================================================================
    MSG: itri_msgs/Ars40xClusters
    Header header
    Ars40xCluster[] clusters
    ================================================================================
    MSG: itri_msgs/Ars40xCluster
    uint8 id
    
    geometry_msgs/Pose pose
    geometry_msgs/Twist velocity
    
    # dBm^2
    float32 radar_cross_section
    
    uint8 MOVING = 0
    uint8 STATIONARY = 1
    uint8 ONCOMING = 2
    uint8 STATIONARY_CANDIDATE = 3
    uint8 UNKNOWN = 4
    uint8 CROSSING_STATIONARY = 5
    uint8 CROSSING_MOVING = 6
    uint8 STOPPED = 7
    uint8 dynamic
    
    uint8 INVALID = 0
    uint8 AMBIGUOUS = 1
    uint8 STAGGERED_RAMP = 2
    uint8 UNAMBIGUOUS = 3
    uint8 STATIONARY_CANDIDATES = 4
    uint8 ambiguity
    
    uint8 VALID = 0
    uint8 INVALID_DUE_TO_LOW_RCS = 1
    uint8 INVALID_DUE_TO_NEAR_FIELD_ARTEFACT = 2
    uint8 INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE = 3
    uint8 VALID_WITH_LOW_RCS = 4
    uint8 INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY = 6
    uint8 INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW = 7
    uint8 VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION = 8
    uint8 VALID_WITH_HIGH_CHILD_PROB = 9
    uint8 VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT = 10
    uint8 VALID_BUT_NO_LOCAL_MAXIMUM = 11
    uint8 VALID_WITH_HIGH_ARTEFACT_PROB = 12
    uint8 INVALID_BECAUSE_IT_IS_HARMONIC = 14
    uint8 VALID_ABOVE_95M_IN_NEAR_RANGE = 15
    uint8 VALID_WITH_HIGH_MULTI_TARGET_PROB = 16
    uint8 VALID_WITH_SUSPICIOUS_ANGLE = 17
    uint8 validity
    
    # false alarm probability, percentage
    float32 probability
    
    bool is_near
    ================================================================================
    MSG: itri_msgs/CameraObjectFrustum
    geometry_msgs/Point[] Points
    geometry_msgs/Quaternion[] FaceInsidePlanesNorm
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DetectedObject(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.label !== undefined) {
      resolved.label = msg.label;
    }
    else {
      resolved.label = ''
    }

    if (msg.score !== undefined) {
      resolved.score = msg.score;
    }
    else {
      resolved.score = 0.0
    }

    if (msg.color !== undefined) {
      resolved.color = std_msgs.msg.ColorRGBA.Resolve(msg.color)
    }
    else {
      resolved.color = new std_msgs.msg.ColorRGBA()
    }

    if (msg.trackedPeriod !== undefined) {
      resolved.trackedPeriod = msg.trackedPeriod;
    }
    else {
      resolved.trackedPeriod = 0.0
    }

    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Pose.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Pose()
    }

    if (msg.dimensions !== undefined) {
      resolved.dimensions = geometry_msgs.msg.Vector3.Resolve(msg.dimensions)
    }
    else {
      resolved.dimensions = new geometry_msgs.msg.Vector3()
    }

    if (msg.variance !== undefined) {
      resolved.variance = geometry_msgs.msg.Vector3.Resolve(msg.variance)
    }
    else {
      resolved.variance = new geometry_msgs.msg.Vector3()
    }

    if (msg.velocity !== undefined) {
      resolved.velocity = geometry_msgs.msg.Twist.Resolve(msg.velocity)
    }
    else {
      resolved.velocity = new geometry_msgs.msg.Twist()
    }

    if (msg.abs_velocity !== undefined) {
      resolved.abs_velocity = geometry_msgs.msg.Twist.Resolve(msg.abs_velocity)
    }
    else {
      resolved.abs_velocity = new geometry_msgs.msg.Twist()
    }

    if (msg.convex_hull !== undefined) {
      resolved.convex_hull = geometry_msgs.msg.PolygonStamped.Resolve(msg.convex_hull)
    }
    else {
      resolved.convex_hull = new geometry_msgs.msg.PolygonStamped()
    }

    if (msg.pose_reliable !== undefined) {
      resolved.pose_reliable = msg.pose_reliable;
    }
    else {
      resolved.pose_reliable = false
    }

    if (msg.velocity_reliable !== undefined) {
      resolved.velocity_reliable = msg.velocity_reliable;
    }
    else {
      resolved.velocity_reliable = false
    }

    if (msg.pointcloud !== undefined) {
      resolved.pointcloud = sensor_msgs.msg.PointCloud2.Resolve(msg.pointcloud)
    }
    else {
      resolved.pointcloud = new sensor_msgs.msg.PointCloud2()
    }

    if (msg.image_frame !== undefined) {
      resolved.image_frame = msg.image_frame;
    }
    else {
      resolved.image_frame = ''
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = 0
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = 0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0
    }

    if (msg.height !== undefined) {
      resolved.height = msg.height;
    }
    else {
      resolved.height = 0
    }

    if (msg.angle !== undefined) {
      resolved.angle = msg.angle;
    }
    else {
      resolved.angle = 0.0
    }

    if (msg.space_frame !== undefined) {
      resolved.space_frame = msg.space_frame;
    }
    else {
      resolved.space_frame = ''
    }

    if (msg.behavior_state !== undefined) {
      resolved.behavior_state = msg.behavior_state;
    }
    else {
      resolved.behavior_state = 0
    }

    if (msg.history_path !== undefined) {
      resolved.history_path = new Array(msg.history_path.length);
      for (let i = 0; i < resolved.history_path.length; ++i) {
        resolved.history_path[i] = geometry_msgs.msg.Point.Resolve(msg.history_path[i]);
      }
    }
    else {
      resolved.history_path = []
    }

    if (msg.predicted_poses !== undefined) {
      resolved.predicted_poses = new Array(msg.predicted_poses.length);
      for (let i = 0; i < resolved.predicted_poses.length; ++i) {
        resolved.predicted_poses[i] = geometry_msgs.msg.Point.Resolve(msg.predicted_poses[i]);
      }
    }
    else {
      resolved.predicted_poses = []
    }

    if (msg.predicted_variance !== undefined) {
      resolved.predicted_variance = new Array(msg.predicted_variance.length);
      for (let i = 0; i < resolved.predicted_variance.length; ++i) {
        resolved.predicted_variance[i] = geometry_msgs.msg.Point.Resolve(msg.predicted_variance[i]);
      }
    }
    else {
      resolved.predicted_variance = []
    }

    if (msg.predicted_paths !== undefined) {
      resolved.predicted_paths = new Array(msg.predicted_paths.length);
      for (let i = 0; i < resolved.predicted_paths.length; ++i) {
        resolved.predicted_paths[i] = PredictedPath.Resolve(msg.predicted_paths[i]);
      }
    }
    else {
      resolved.predicted_paths = []
    }

    if (msg.acceleration !== undefined) {
      resolved.acceleration = geometry_msgs.msg.Twist.Resolve(msg.acceleration)
    }
    else {
      resolved.acceleration = new geometry_msgs.msg.Twist()
    }

    if (msg.radarFusionPoints !== undefined) {
      resolved.radarFusionPoints = Ars40xClusters.Resolve(msg.radarFusionPoints)
    }
    else {
      resolved.radarFusionPoints = new Ars40xClusters()
    }

    if (msg.cameraObjectFrustum !== undefined) {
      resolved.cameraObjectFrustum = CameraObjectFrustum.Resolve(msg.cameraObjectFrustum)
    }
    else {
      resolved.cameraObjectFrustum = new CameraObjectFrustum()
    }

    if (msg.overlapObjectsNumber !== undefined) {
      resolved.overlapObjectsNumber = msg.overlapObjectsNumber;
    }
    else {
      resolved.overlapObjectsNumber = 0
    }

    if (msg.visibleSegments !== undefined) {
      resolved.visibleSegments = geometry_msgs.msg.PolygonStamped.Resolve(msg.visibleSegments)
    }
    else {
      resolved.visibleSegments = new geometry_msgs.msg.PolygonStamped()
    }

    if (msg.image2Dcube !== undefined) {
      resolved.image2Dcube = geometry_msgs.msg.PolygonStamped.Resolve(msg.image2Dcube)
    }
    else {
      resolved.image2Dcube = new geometry_msgs.msg.PolygonStamped()
    }

    if (msg.isMoving !== undefined) {
      resolved.isMoving = msg.isMoving;
    }
    else {
      resolved.isMoving = false
    }

    return resolved;
    }
};

module.exports = DetectedObject;
