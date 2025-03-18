; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LeadData.msg.html

(cl:defclass <LeadData> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (dRel
    :reader dRel
    :initarg :dRel
    :type cl:float
    :initform 0.0)
   (yRel
    :reader yRel
    :initarg :yRel
    :type cl:float
    :initform 0.0)
   (vRel
    :reader vRel
    :initarg :vRel
    :type cl:float
    :initform 0.0)
   (aRel
    :reader aRel
    :initarg :aRel
    :type cl:float
    :initform 0.0)
   (vLead
    :reader vLead
    :initarg :vLead
    :type cl:float
    :initform 0.0)
   (aLeadDEPRECATED
    :reader aLeadDEPRECATED
    :initarg :aLeadDEPRECATED
    :type cl:float
    :initform 0.0)
   (dPath
    :reader dPath
    :initarg :dPath
    :type cl:float
    :initform 0.0)
   (vLat
    :reader vLat
    :initarg :vLat
    :type cl:float
    :initform 0.0)
   (vLeadK
    :reader vLeadK
    :initarg :vLeadK
    :type cl:float
    :initform 0.0)
   (aLeadK
    :reader aLeadK
    :initarg :aLeadK
    :type cl:float
    :initform 0.0)
   (fcw
    :reader fcw
    :initarg :fcw
    :type cl:boolean
    :initform cl:nil)
   (status
    :reader status
    :initarg :status
    :type cl:boolean
    :initform cl:nil)
   (aLeadTau
    :reader aLeadTau
    :initarg :aLeadTau
    :type cl:float
    :initform 0.0)
   (modelProb
    :reader modelProb
    :initarg :modelProb
    :type cl:float
    :initform 0.0)
   (radar
    :reader radar
    :initarg :radar
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass LeadData (<LeadData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LeadData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LeadData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LeadData> is deprecated: use openpilot_bridge-msg:LeadData instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'dRel-val :lambda-list '(m))
(cl:defmethod dRel-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dRel-val is deprecated.  Use openpilot_bridge-msg:dRel instead.")
  (dRel m))

(cl:ensure-generic-function 'yRel-val :lambda-list '(m))
(cl:defmethod yRel-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:yRel-val is deprecated.  Use openpilot_bridge-msg:yRel instead.")
  (yRel m))

(cl:ensure-generic-function 'vRel-val :lambda-list '(m))
(cl:defmethod vRel-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vRel-val is deprecated.  Use openpilot_bridge-msg:vRel instead.")
  (vRel m))

(cl:ensure-generic-function 'aRel-val :lambda-list '(m))
(cl:defmethod aRel-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aRel-val is deprecated.  Use openpilot_bridge-msg:aRel instead.")
  (aRel m))

(cl:ensure-generic-function 'vLead-val :lambda-list '(m))
(cl:defmethod vLead-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vLead-val is deprecated.  Use openpilot_bridge-msg:vLead instead.")
  (vLead m))

(cl:ensure-generic-function 'aLeadDEPRECATED-val :lambda-list '(m))
(cl:defmethod aLeadDEPRECATED-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aLeadDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:aLeadDEPRECATED instead.")
  (aLeadDEPRECATED m))

(cl:ensure-generic-function 'dPath-val :lambda-list '(m))
(cl:defmethod dPath-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dPath-val is deprecated.  Use openpilot_bridge-msg:dPath instead.")
  (dPath m))

(cl:ensure-generic-function 'vLat-val :lambda-list '(m))
(cl:defmethod vLat-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vLat-val is deprecated.  Use openpilot_bridge-msg:vLat instead.")
  (vLat m))

(cl:ensure-generic-function 'vLeadK-val :lambda-list '(m))
(cl:defmethod vLeadK-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vLeadK-val is deprecated.  Use openpilot_bridge-msg:vLeadK instead.")
  (vLeadK m))

(cl:ensure-generic-function 'aLeadK-val :lambda-list '(m))
(cl:defmethod aLeadK-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aLeadK-val is deprecated.  Use openpilot_bridge-msg:aLeadK instead.")
  (aLeadK m))

(cl:ensure-generic-function 'fcw-val :lambda-list '(m))
(cl:defmethod fcw-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fcw-val is deprecated.  Use openpilot_bridge-msg:fcw instead.")
  (fcw m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:status-val is deprecated.  Use openpilot_bridge-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'aLeadTau-val :lambda-list '(m))
(cl:defmethod aLeadTau-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aLeadTau-val is deprecated.  Use openpilot_bridge-msg:aLeadTau instead.")
  (aLeadTau m))

(cl:ensure-generic-function 'modelProb-val :lambda-list '(m))
(cl:defmethod modelProb-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:modelProb-val is deprecated.  Use openpilot_bridge-msg:modelProb instead.")
  (modelProb m))

(cl:ensure-generic-function 'radar-val :lambda-list '(m))
(cl:defmethod radar-val ((m <LeadData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radar-val is deprecated.  Use openpilot_bridge-msg:radar instead.")
  (radar m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LeadData>) ostream)
  "Serializes a message object of type '<LeadData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vLead))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aLeadDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dPath))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vLat))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vLeadK))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aLeadK))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fcw) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'status) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aLeadTau))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'modelProb))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'radar) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LeadData>) istream)
  "Deserializes a message object of type '<LeadData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vLead) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aLeadDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dPath) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vLat) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vLeadK) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aLeadK) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'fcw) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'status) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aLeadTau) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'modelProb) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'radar) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LeadData>)))
  "Returns string type for a message object of type '<LeadData>"
  "openpilot_bridge/LeadData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LeadData)))
  "Returns string type for a message object of type 'LeadData"
  "openpilot_bridge/LeadData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LeadData>)))
  "Returns md5sum for a message object of type '<LeadData>"
  "2267c1a294f8eb3e2cb2f5c2e4aba833")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LeadData)))
  "Returns md5sum for a message object of type 'LeadData"
  "2267c1a294f8eb3e2cb2f5c2e4aba833")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LeadData>)))
  "Returns full string definition for message of type '<LeadData>"
  (cl:format cl:nil "Header header~%~%float32 dRel~%float32 yRel~%float32 vRel~%float32 aRel~%float32 vLead~%float32 aLeadDEPRECATED~%float32 dPath~%float32 vLat~%float32 vLeadK~%float32 aLeadK~%bool fcw~%bool status~%float32 aLeadTau~%float32 modelProb~%bool radar~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LeadData)))
  "Returns full string definition for message of type 'LeadData"
  (cl:format cl:nil "Header header~%~%float32 dRel~%float32 yRel~%float32 vRel~%float32 aRel~%float32 vLead~%float32 aLeadDEPRECATED~%float32 dPath~%float32 vLat~%float32 vLeadK~%float32 aLeadK~%bool fcw~%bool status~%float32 aLeadTau~%float32 modelProb~%bool radar~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LeadData>))
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
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LeadData>))
  "Converts a ROS message object to a list"
  (cl:list 'LeadData
    (cl:cons ':header (header msg))
    (cl:cons ':dRel (dRel msg))
    (cl:cons ':yRel (yRel msg))
    (cl:cons ':vRel (vRel msg))
    (cl:cons ':aRel (aRel msg))
    (cl:cons ':vLead (vLead msg))
    (cl:cons ':aLeadDEPRECATED (aLeadDEPRECATED msg))
    (cl:cons ':dPath (dPath msg))
    (cl:cons ':vLat (vLat msg))
    (cl:cons ':vLeadK (vLeadK msg))
    (cl:cons ':aLeadK (aLeadK msg))
    (cl:cons ':fcw (fcw msg))
    (cl:cons ':status (status msg))
    (cl:cons ':aLeadTau (aLeadTau msg))
    (cl:cons ':modelProb (modelProb msg))
    (cl:cons ':radar (radar msg))
))
