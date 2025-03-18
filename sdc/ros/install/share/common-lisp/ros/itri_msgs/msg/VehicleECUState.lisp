; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude VehicleECUState.msg.html

(cl:defclass <VehicleECUState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (accel_pedal_pos1
    :reader accel_pedal_pos1
    :initarg :accel_pedal_pos1
    :type cl:float
    :initform 0.0)
   (accel_pedal_pos2
    :reader accel_pedal_pos2
    :initarg :accel_pedal_pos2
    :type cl:float
    :initform 0.0)
   (engine_speed
    :reader engine_speed
    :initarg :engine_speed
    :type cl:float
    :initform 0.0)
   (engine_average_fuel_economy
    :reader engine_average_fuel_economy
    :initarg :engine_average_fuel_economy
    :type cl:float
    :initform 0.0)
   (engine_instantaneous_fuel_economy
    :reader engine_instantaneous_fuel_economy
    :initarg :engine_instantaneous_fuel_economy
    :type cl:float
    :initform 0.0)
   (engine_fuel_rate
    :reader engine_fuel_rate
    :initarg :engine_fuel_rate
    :type cl:float
    :initform 0.0)
   (remote_accel_pedal_pos
    :reader remote_accel_pedal_pos
    :initarg :remote_accel_pedal_pos
    :type cl:float
    :initform 0.0)
   (est_engine_power_kw
    :reader est_engine_power_kw
    :initarg :est_engine_power_kw
    :type cl:float
    :initform 0.0)
   (total_vehicle_distance
    :reader total_vehicle_distance
    :initarg :total_vehicle_distance
    :type cl:float
    :initform 0.0)
   (trip_distance
    :reader trip_distance
    :initarg :trip_distance
    :type cl:float
    :initform 0.0)
   (actual_engine_percentage_torque
    :reader actual_engine_percentage_torque
    :initarg :actual_engine_percentage_torque
    :type cl:fixnum
    :initform 0)
   (act_max_available_eng_percent_torque
    :reader act_max_available_eng_percent_torque
    :initarg :act_max_available_eng_percent_torque
    :type cl:fixnum
    :initform 0)
   (drivers_demand_eng_percent_torque
    :reader drivers_demand_eng_percent_torque
    :initarg :drivers_demand_eng_percent_torque
    :type cl:fixnum
    :initform 0)
   (engine_demand_percent_torque
    :reader engine_demand_percent_torque
    :initarg :engine_demand_percent_torque
    :type cl:fixnum
    :initform 0)
   (est_pumping_percent_torque
    :reader est_pumping_percent_torque
    :initarg :est_pumping_percent_torque
    :type cl:fixnum
    :initform 0)
   (est_eng_prsitic_losses_percent_torque
    :reader est_eng_prsitic_losses_percent_torque
    :initarg :est_eng_prsitic_losses_percent_torque
    :type cl:fixnum
    :initform 0)
   (nominal_friction_percent_torque
    :reader nominal_friction_percent_torque
    :initarg :nominal_friction_percent_torque
    :type cl:fixnum
    :initform 0)
   (DPF_thermal_management_active
    :reader DPF_thermal_management_active
    :initarg :DPF_thermal_management_active
    :type cl:fixnum
    :initform 0)
   (engine_percent_load_at_current_speed
    :reader engine_percent_load_at_current_speed
    :initarg :engine_percent_load_at_current_speed
    :type cl:fixnum
    :initform 0)
   (engine_reference_torque
    :reader engine_reference_torque
    :initarg :engine_reference_torque
    :type cl:fixnum
    :initform 0)
   (momntary_eng_max_power_enable_feedback
    :reader momntary_eng_max_power_enable_feedback
    :initarg :momntary_eng_max_power_enable_feedback
    :type cl:fixnum
    :initform 0)
   (SCR_thermal_management_active
    :reader SCR_thermal_management_active
    :initarg :SCR_thermal_management_active
    :type cl:fixnum
    :initform 0)
   (vehicle_acceleration_rate_limit_status
    :reader vehicle_acceleration_rate_limit_status
    :initarg :vehicle_acceleration_rate_limit_status
    :type cl:fixnum
    :initform 0)
   (fuel_level1_percentage
    :reader fuel_level1_percentage
    :initarg :fuel_level1_percentage
    :type cl:fixnum
    :initform 0)
   (fuel_level2_percentage
    :reader fuel_level2_percentage
    :initarg :fuel_level2_percentage
    :type cl:fixnum
    :initform 0))
)

(cl:defclass VehicleECUState (<VehicleECUState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VehicleECUState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VehicleECUState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<VehicleECUState> is deprecated: use itri_msgs-msg:VehicleECUState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'accel_pedal_pos1-val :lambda-list '(m))
(cl:defmethod accel_pedal_pos1-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:accel_pedal_pos1-val is deprecated.  Use itri_msgs-msg:accel_pedal_pos1 instead.")
  (accel_pedal_pos1 m))

(cl:ensure-generic-function 'accel_pedal_pos2-val :lambda-list '(m))
(cl:defmethod accel_pedal_pos2-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:accel_pedal_pos2-val is deprecated.  Use itri_msgs-msg:accel_pedal_pos2 instead.")
  (accel_pedal_pos2 m))

(cl:ensure-generic-function 'engine_speed-val :lambda-list '(m))
(cl:defmethod engine_speed-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:engine_speed-val is deprecated.  Use itri_msgs-msg:engine_speed instead.")
  (engine_speed m))

(cl:ensure-generic-function 'engine_average_fuel_economy-val :lambda-list '(m))
(cl:defmethod engine_average_fuel_economy-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:engine_average_fuel_economy-val is deprecated.  Use itri_msgs-msg:engine_average_fuel_economy instead.")
  (engine_average_fuel_economy m))

(cl:ensure-generic-function 'engine_instantaneous_fuel_economy-val :lambda-list '(m))
(cl:defmethod engine_instantaneous_fuel_economy-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:engine_instantaneous_fuel_economy-val is deprecated.  Use itri_msgs-msg:engine_instantaneous_fuel_economy instead.")
  (engine_instantaneous_fuel_economy m))

(cl:ensure-generic-function 'engine_fuel_rate-val :lambda-list '(m))
(cl:defmethod engine_fuel_rate-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:engine_fuel_rate-val is deprecated.  Use itri_msgs-msg:engine_fuel_rate instead.")
  (engine_fuel_rate m))

(cl:ensure-generic-function 'remote_accel_pedal_pos-val :lambda-list '(m))
(cl:defmethod remote_accel_pedal_pos-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:remote_accel_pedal_pos-val is deprecated.  Use itri_msgs-msg:remote_accel_pedal_pos instead.")
  (remote_accel_pedal_pos m))

(cl:ensure-generic-function 'est_engine_power_kw-val :lambda-list '(m))
(cl:defmethod est_engine_power_kw-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:est_engine_power_kw-val is deprecated.  Use itri_msgs-msg:est_engine_power_kw instead.")
  (est_engine_power_kw m))

(cl:ensure-generic-function 'total_vehicle_distance-val :lambda-list '(m))
(cl:defmethod total_vehicle_distance-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:total_vehicle_distance-val is deprecated.  Use itri_msgs-msg:total_vehicle_distance instead.")
  (total_vehicle_distance m))

(cl:ensure-generic-function 'trip_distance-val :lambda-list '(m))
(cl:defmethod trip_distance-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:trip_distance-val is deprecated.  Use itri_msgs-msg:trip_distance instead.")
  (trip_distance m))

(cl:ensure-generic-function 'actual_engine_percentage_torque-val :lambda-list '(m))
(cl:defmethod actual_engine_percentage_torque-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:actual_engine_percentage_torque-val is deprecated.  Use itri_msgs-msg:actual_engine_percentage_torque instead.")
  (actual_engine_percentage_torque m))

(cl:ensure-generic-function 'act_max_available_eng_percent_torque-val :lambda-list '(m))
(cl:defmethod act_max_available_eng_percent_torque-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:act_max_available_eng_percent_torque-val is deprecated.  Use itri_msgs-msg:act_max_available_eng_percent_torque instead.")
  (act_max_available_eng_percent_torque m))

(cl:ensure-generic-function 'drivers_demand_eng_percent_torque-val :lambda-list '(m))
(cl:defmethod drivers_demand_eng_percent_torque-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:drivers_demand_eng_percent_torque-val is deprecated.  Use itri_msgs-msg:drivers_demand_eng_percent_torque instead.")
  (drivers_demand_eng_percent_torque m))

(cl:ensure-generic-function 'engine_demand_percent_torque-val :lambda-list '(m))
(cl:defmethod engine_demand_percent_torque-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:engine_demand_percent_torque-val is deprecated.  Use itri_msgs-msg:engine_demand_percent_torque instead.")
  (engine_demand_percent_torque m))

(cl:ensure-generic-function 'est_pumping_percent_torque-val :lambda-list '(m))
(cl:defmethod est_pumping_percent_torque-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:est_pumping_percent_torque-val is deprecated.  Use itri_msgs-msg:est_pumping_percent_torque instead.")
  (est_pumping_percent_torque m))

(cl:ensure-generic-function 'est_eng_prsitic_losses_percent_torque-val :lambda-list '(m))
(cl:defmethod est_eng_prsitic_losses_percent_torque-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:est_eng_prsitic_losses_percent_torque-val is deprecated.  Use itri_msgs-msg:est_eng_prsitic_losses_percent_torque instead.")
  (est_eng_prsitic_losses_percent_torque m))

(cl:ensure-generic-function 'nominal_friction_percent_torque-val :lambda-list '(m))
(cl:defmethod nominal_friction_percent_torque-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:nominal_friction_percent_torque-val is deprecated.  Use itri_msgs-msg:nominal_friction_percent_torque instead.")
  (nominal_friction_percent_torque m))

(cl:ensure-generic-function 'DPF_thermal_management_active-val :lambda-list '(m))
(cl:defmethod DPF_thermal_management_active-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:DPF_thermal_management_active-val is deprecated.  Use itri_msgs-msg:DPF_thermal_management_active instead.")
  (DPF_thermal_management_active m))

(cl:ensure-generic-function 'engine_percent_load_at_current_speed-val :lambda-list '(m))
(cl:defmethod engine_percent_load_at_current_speed-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:engine_percent_load_at_current_speed-val is deprecated.  Use itri_msgs-msg:engine_percent_load_at_current_speed instead.")
  (engine_percent_load_at_current_speed m))

(cl:ensure-generic-function 'engine_reference_torque-val :lambda-list '(m))
(cl:defmethod engine_reference_torque-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:engine_reference_torque-val is deprecated.  Use itri_msgs-msg:engine_reference_torque instead.")
  (engine_reference_torque m))

(cl:ensure-generic-function 'momntary_eng_max_power_enable_feedback-val :lambda-list '(m))
(cl:defmethod momntary_eng_max_power_enable_feedback-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:momntary_eng_max_power_enable_feedback-val is deprecated.  Use itri_msgs-msg:momntary_eng_max_power_enable_feedback instead.")
  (momntary_eng_max_power_enable_feedback m))

(cl:ensure-generic-function 'SCR_thermal_management_active-val :lambda-list '(m))
(cl:defmethod SCR_thermal_management_active-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:SCR_thermal_management_active-val is deprecated.  Use itri_msgs-msg:SCR_thermal_management_active instead.")
  (SCR_thermal_management_active m))

(cl:ensure-generic-function 'vehicle_acceleration_rate_limit_status-val :lambda-list '(m))
(cl:defmethod vehicle_acceleration_rate_limit_status-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:vehicle_acceleration_rate_limit_status-val is deprecated.  Use itri_msgs-msg:vehicle_acceleration_rate_limit_status instead.")
  (vehicle_acceleration_rate_limit_status m))

(cl:ensure-generic-function 'fuel_level1_percentage-val :lambda-list '(m))
(cl:defmethod fuel_level1_percentage-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:fuel_level1_percentage-val is deprecated.  Use itri_msgs-msg:fuel_level1_percentage instead.")
  (fuel_level1_percentage m))

(cl:ensure-generic-function 'fuel_level2_percentage-val :lambda-list '(m))
(cl:defmethod fuel_level2_percentage-val ((m <VehicleECUState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:fuel_level2_percentage-val is deprecated.  Use itri_msgs-msg:fuel_level2_percentage instead.")
  (fuel_level2_percentage m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VehicleECUState>) ostream)
  "Serializes a message object of type '<VehicleECUState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'accel_pedal_pos1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'accel_pedal_pos2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'engine_speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'engine_average_fuel_economy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'engine_instantaneous_fuel_economy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'engine_fuel_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'remote_accel_pedal_pos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'est_engine_power_kw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'total_vehicle_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'trip_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'actual_engine_percentage_torque)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'act_max_available_eng_percent_torque)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'drivers_demand_eng_percent_torque)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'engine_demand_percent_torque)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'est_pumping_percent_torque)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'est_eng_prsitic_losses_percent_torque)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'nominal_friction_percent_torque)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'DPF_thermal_management_active)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'engine_percent_load_at_current_speed)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'engine_reference_torque)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'momntary_eng_max_power_enable_feedback)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'SCR_thermal_management_active)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'vehicle_acceleration_rate_limit_status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fuel_level1_percentage)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fuel_level2_percentage)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VehicleECUState>) istream)
  "Deserializes a message object of type '<VehicleECUState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'accel_pedal_pos1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'accel_pedal_pos2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'engine_speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'engine_average_fuel_economy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'engine_instantaneous_fuel_economy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'engine_fuel_rate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'remote_accel_pedal_pos) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'est_engine_power_kw) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'total_vehicle_distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'trip_distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'actual_engine_percentage_torque) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'act_max_available_eng_percent_torque) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'drivers_demand_eng_percent_torque) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'engine_demand_percent_torque) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'est_pumping_percent_torque) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'est_eng_prsitic_losses_percent_torque) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nominal_friction_percent_torque) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'DPF_thermal_management_active)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'engine_percent_load_at_current_speed)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'engine_reference_torque)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'momntary_eng_max_power_enable_feedback)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'SCR_thermal_management_active)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'vehicle_acceleration_rate_limit_status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fuel_level1_percentage)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fuel_level2_percentage)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VehicleECUState>)))
  "Returns string type for a message object of type '<VehicleECUState>"
  "itri_msgs/VehicleECUState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VehicleECUState)))
  "Returns string type for a message object of type 'VehicleECUState"
  "itri_msgs/VehicleECUState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VehicleECUState>)))
  "Returns md5sum for a message object of type '<VehicleECUState>"
  "283d54a284611771e67b738b33b81ee0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VehicleECUState)))
  "Returns md5sum for a message object of type 'VehicleECUState"
  "283d54a284611771e67b738b33b81ee0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VehicleECUState>)))
  "Returns full string definition for message of type '<VehicleECUState>"
  (cl:format cl:nil "Header header~%float32 accel_pedal_pos1~%float32 accel_pedal_pos2~%float32 engine_speed~%float32 engine_average_fuel_economy~%float32 engine_instantaneous_fuel_economy~%float32 engine_fuel_rate~%float32 remote_accel_pedal_pos~%float32 est_engine_power_kw~%float32 total_vehicle_distance~%float32 trip_distance~%int8 actual_engine_percentage_torque~%int8 act_max_available_eng_percent_torque~%int8 drivers_demand_eng_percent_torque~%int8 engine_demand_percent_torque~%int8 est_pumping_percent_torque~%int8 est_eng_prsitic_losses_percent_torque~%int8 nominal_friction_percent_torque~%uint8 DPF_thermal_management_active~%uint8 engine_percent_load_at_current_speed~%uint8 engine_reference_torque~%uint8 momntary_eng_max_power_enable_feedback~%uint8 SCR_thermal_management_active~%uint8 vehicle_acceleration_rate_limit_status~%uint8 fuel_level1_percentage~%uint8 fuel_level2_percentage~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VehicleECUState)))
  "Returns full string definition for message of type 'VehicleECUState"
  (cl:format cl:nil "Header header~%float32 accel_pedal_pos1~%float32 accel_pedal_pos2~%float32 engine_speed~%float32 engine_average_fuel_economy~%float32 engine_instantaneous_fuel_economy~%float32 engine_fuel_rate~%float32 remote_accel_pedal_pos~%float32 est_engine_power_kw~%float32 total_vehicle_distance~%float32 trip_distance~%int8 actual_engine_percentage_torque~%int8 act_max_available_eng_percent_torque~%int8 drivers_demand_eng_percent_torque~%int8 engine_demand_percent_torque~%int8 est_pumping_percent_torque~%int8 est_eng_prsitic_losses_percent_torque~%int8 nominal_friction_percent_torque~%uint8 DPF_thermal_management_active~%uint8 engine_percent_load_at_current_speed~%uint8 engine_reference_torque~%uint8 momntary_eng_max_power_enable_feedback~%uint8 SCR_thermal_management_active~%uint8 vehicle_acceleration_rate_limit_status~%uint8 fuel_level1_percentage~%uint8 fuel_level2_percentage~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VehicleECUState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VehicleECUState>))
  "Converts a ROS message object to a list"
  (cl:list 'VehicleECUState
    (cl:cons ':header (header msg))
    (cl:cons ':accel_pedal_pos1 (accel_pedal_pos1 msg))
    (cl:cons ':accel_pedal_pos2 (accel_pedal_pos2 msg))
    (cl:cons ':engine_speed (engine_speed msg))
    (cl:cons ':engine_average_fuel_economy (engine_average_fuel_economy msg))
    (cl:cons ':engine_instantaneous_fuel_economy (engine_instantaneous_fuel_economy msg))
    (cl:cons ':engine_fuel_rate (engine_fuel_rate msg))
    (cl:cons ':remote_accel_pedal_pos (remote_accel_pedal_pos msg))
    (cl:cons ':est_engine_power_kw (est_engine_power_kw msg))
    (cl:cons ':total_vehicle_distance (total_vehicle_distance msg))
    (cl:cons ':trip_distance (trip_distance msg))
    (cl:cons ':actual_engine_percentage_torque (actual_engine_percentage_torque msg))
    (cl:cons ':act_max_available_eng_percent_torque (act_max_available_eng_percent_torque msg))
    (cl:cons ':drivers_demand_eng_percent_torque (drivers_demand_eng_percent_torque msg))
    (cl:cons ':engine_demand_percent_torque (engine_demand_percent_torque msg))
    (cl:cons ':est_pumping_percent_torque (est_pumping_percent_torque msg))
    (cl:cons ':est_eng_prsitic_losses_percent_torque (est_eng_prsitic_losses_percent_torque msg))
    (cl:cons ':nominal_friction_percent_torque (nominal_friction_percent_torque msg))
    (cl:cons ':DPF_thermal_management_active (DPF_thermal_management_active msg))
    (cl:cons ':engine_percent_load_at_current_speed (engine_percent_load_at_current_speed msg))
    (cl:cons ':engine_reference_torque (engine_reference_torque msg))
    (cl:cons ':momntary_eng_max_power_enable_feedback (momntary_eng_max_power_enable_feedback msg))
    (cl:cons ':SCR_thermal_management_active (SCR_thermal_management_active msg))
    (cl:cons ':vehicle_acceleration_rate_limit_status (vehicle_acceleration_rate_limit_status msg))
    (cl:cons ':fuel_level1_percentage (fuel_level1_percentage msg))
    (cl:cons ':fuel_level2_percentage (fuel_level2_percentage msg))
))
