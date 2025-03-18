; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude ControlsState.msg.html

(cl:defclass <ControlsState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (ufSteerDEPRECATED
    :reader ufSteerDEPRECATED
    :initarg :ufSteerDEPRECATED
    :type cl:float
    :initform 0.0)
   (angleSteersDes
    :reader angleSteersDes
    :initarg :angleSteersDes
    :type cl:float
    :initform 0.0)
   (decelForTurn
    :reader decelForTurn
    :initarg :decelForTurn
    :type cl:boolean
    :initform cl:nil)
   (steerOverride
    :reader steerOverride
    :initarg :steerOverride
    :type cl:boolean
    :initform cl:nil)
   (rearViewCam
    :reader rearViewCam
    :initarg :rearViewCam
    :type cl:boolean
    :initform cl:nil)
   (canErrorCounter
    :reader canErrorCounter
    :initarg :canErrorCounter
    :type cl:integer
    :initform 0)
   (lateralControlState
    :reader lateralControlState
    :initarg :lateralControlState
    :type openpilot_bridge-msg:Lateralcontrolstate
    :initform (cl:make-instance 'openpilot_bridge-msg:Lateralcontrolstate))
   (vEgoRaw
    :reader vEgoRaw
    :initarg :vEgoRaw
    :type cl:float
    :initform 0.0)
   (forceDecel
    :reader forceDecel
    :initarg :forceDecel
    :type cl:boolean
    :initform cl:nil)
   (alertSound
    :reader alertSound
    :initarg :alertSound
    :type cl:integer
    :initform 0)
   (upSteerDEPRECATED
    :reader upSteerDEPRECATED
    :initarg :upSteerDEPRECATED
    :type cl:float
    :initform 0.0)
   (vEgo
    :reader vEgo
    :initarg :vEgo
    :type cl:float
    :initform 0.0)
   (angleSteers
    :reader angleSteers
    :initarg :angleSteers
    :type cl:float
    :initform 0.0)
   (jerkFactor
    :reader jerkFactor
    :initarg :jerkFactor
    :type cl:float
    :initform 0.0)
   (alertType
    :reader alertType
    :initarg :alertType
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (aTarget
    :reader aTarget
    :initarg :aTarget
    :type cl:float
    :initform 0.0)
   (alertStatus
    :reader alertStatus
    :initarg :alertStatus
    :type cl:integer
    :initform 0)
   (alertSize
    :reader alertSize
    :initarg :alertSize
    :type cl:integer
    :initform 0)
   (planMonoTime
    :reader planMonoTime
    :initarg :planMonoTime
    :type cl:integer
    :initform 0)
   (aTargetMaxDEPRECATED
    :reader aTargetMaxDEPRECATED
    :initarg :aTargetMaxDEPRECATED
    :type cl:float
    :initform 0.0)
   (uiAccelCmd
    :reader uiAccelCmd
    :initarg :uiAccelCmd
    :type cl:float
    :initform 0.0)
   (state
    :reader state
    :initarg :state
    :type cl:integer
    :initform 0)
   (alertBlinkingRate
    :reader alertBlinkingRate
    :initarg :alertBlinkingRate
    :type cl:float
    :initform 0.0)
   (angleModelBiasDEPRECATED
    :reader angleModelBiasDEPRECATED
    :initarg :angleModelBiasDEPRECATED
    :type cl:float
    :initform 0.0)
   (alertText2
    :reader alertText2
    :initarg :alertText2
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (alertText1
    :reader alertText1
    :initarg :alertText1
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (yDesDEPRECATED
    :reader yDesDEPRECATED
    :initarg :yDesDEPRECATED
    :type cl:float
    :initform 0.0)
   (vPid
    :reader vPid
    :initarg :vPid
    :type cl:float
    :initform 0.0)
   (vTargetLead
    :reader vTargetLead
    :initarg :vTargetLead
    :type cl:float
    :initform 0.0)
   (decelForModel
    :reader decelForModel
    :initarg :decelForModel
    :type cl:boolean
    :initform cl:nil)
   (gpsPlannerActive
    :reader gpsPlannerActive
    :initarg :gpsPlannerActive
    :type cl:boolean
    :initform cl:nil)
   (startMonoTime
    :reader startMonoTime
    :initarg :startMonoTime
    :type cl:integer
    :initform 0)
   (canMonoTimeDEPRECATED
    :reader canMonoTimeDEPRECATED
    :initarg :canMonoTimeDEPRECATED
    :type cl:integer
    :initform 0)
   (curvature
    :reader curvature
    :initarg :curvature
    :type cl:float
    :initform 0.0)
   (upAccelCmd
    :reader upAccelCmd
    :initarg :upAccelCmd
    :type cl:float
    :initform 0.0)
   (vCurvature
    :reader vCurvature
    :initarg :vCurvature
    :type cl:float
    :initform 0.0)
   (hudLeadDEPRECATED
    :reader hudLeadDEPRECATED
    :initarg :hudLeadDEPRECATED
    :type cl:integer
    :initform 0)
   (active
    :reader active
    :initarg :active
    :type cl:boolean
    :initform cl:nil)
   (awarenessStatus
    :reader awarenessStatus
    :initarg :awarenessStatus
    :type cl:float
    :initform 0.0)
   (uiSteerDEPRECATED
    :reader uiSteerDEPRECATED
    :initarg :uiSteerDEPRECATED
    :type cl:float
    :initform 0.0)
   (aEgoDEPRECATED
    :reader aEgoDEPRECATED
    :initarg :aEgoDEPRECATED
    :type cl:float
    :initform 0.0)
   (alertSoundDEPRECATED
    :reader alertSoundDEPRECATED
    :initarg :alertSoundDEPRECATED
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (ufAccelCmd
    :reader ufAccelCmd
    :initarg :ufAccelCmd
    :type cl:float
    :initform 0.0)
   (vCruise
    :reader vCruise
    :initarg :vCruise
    :type cl:float
    :initform 0.0)
   (yActualDEPRECATED
    :reader yActualDEPRECATED
    :initarg :yActualDEPRECATED
    :type cl:float
    :initform 0.0)
   (enabled
    :reader enabled
    :initarg :enabled
    :type cl:boolean
    :initform cl:nil)
   (aTargetMinDEPRECATED
    :reader aTargetMinDEPRECATED
    :initarg :aTargetMinDEPRECATED
    :type cl:float
    :initform 0.0)
   (cumLagMs
    :reader cumLagMs
    :initarg :cumLagMs
    :type cl:float
    :initform 0.0)
   (mapValid
    :reader mapValid
    :initarg :mapValid
    :type cl:boolean
    :initform cl:nil)
   (pathPlanMonoTime
    :reader pathPlanMonoTime
    :initarg :pathPlanMonoTime
    :type cl:integer
    :initform 0)
   (engageable
    :reader engageable
    :initarg :engageable
    :type cl:boolean
    :initform cl:nil)
   (mdMonoTimeDEPRECATED
    :reader mdMonoTimeDEPRECATED
    :initarg :mdMonoTimeDEPRECATED
    :type cl:integer
    :initform 0)
   (driverMonitoringOn
    :reader driverMonitoringOn
    :initarg :driverMonitoringOn
    :type cl:boolean
    :initform cl:nil)
   (canMonoTimes
    :reader canMonoTimes
    :initarg :canMonoTimes
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (radarStateMonoTimeDEPRECATED
    :reader radarStateMonoTimeDEPRECATED
    :initarg :radarStateMonoTimeDEPRECATED
    :type cl:integer
    :initform 0)
   (longControlState
    :reader longControlState
    :initarg :longControlState
    :type cl:integer
    :initform 0))
)

(cl:defclass ControlsState (<ControlsState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ControlsState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ControlsState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<ControlsState> is deprecated: use openpilot_bridge-msg:ControlsState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'ufSteerDEPRECATED-val :lambda-list '(m))
(cl:defmethod ufSteerDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ufSteerDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:ufSteerDEPRECATED instead.")
  (ufSteerDEPRECATED m))

(cl:ensure-generic-function 'angleSteersDes-val :lambda-list '(m))
(cl:defmethod angleSteersDes-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:angleSteersDes-val is deprecated.  Use openpilot_bridge-msg:angleSteersDes instead.")
  (angleSteersDes m))

(cl:ensure-generic-function 'decelForTurn-val :lambda-list '(m))
(cl:defmethod decelForTurn-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:decelForTurn-val is deprecated.  Use openpilot_bridge-msg:decelForTurn instead.")
  (decelForTurn m))

(cl:ensure-generic-function 'steerOverride-val :lambda-list '(m))
(cl:defmethod steerOverride-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerOverride-val is deprecated.  Use openpilot_bridge-msg:steerOverride instead.")
  (steerOverride m))

(cl:ensure-generic-function 'rearViewCam-val :lambda-list '(m))
(cl:defmethod rearViewCam-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rearViewCam-val is deprecated.  Use openpilot_bridge-msg:rearViewCam instead.")
  (rearViewCam m))

(cl:ensure-generic-function 'canErrorCounter-val :lambda-list '(m))
(cl:defmethod canErrorCounter-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:canErrorCounter-val is deprecated.  Use openpilot_bridge-msg:canErrorCounter instead.")
  (canErrorCounter m))

(cl:ensure-generic-function 'lateralControlState-val :lambda-list '(m))
(cl:defmethod lateralControlState-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lateralControlState-val is deprecated.  Use openpilot_bridge-msg:lateralControlState instead.")
  (lateralControlState m))

(cl:ensure-generic-function 'vEgoRaw-val :lambda-list '(m))
(cl:defmethod vEgoRaw-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vEgoRaw-val is deprecated.  Use openpilot_bridge-msg:vEgoRaw instead.")
  (vEgoRaw m))

(cl:ensure-generic-function 'forceDecel-val :lambda-list '(m))
(cl:defmethod forceDecel-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:forceDecel-val is deprecated.  Use openpilot_bridge-msg:forceDecel instead.")
  (forceDecel m))

(cl:ensure-generic-function 'alertSound-val :lambda-list '(m))
(cl:defmethod alertSound-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:alertSound-val is deprecated.  Use openpilot_bridge-msg:alertSound instead.")
  (alertSound m))

(cl:ensure-generic-function 'upSteerDEPRECATED-val :lambda-list '(m))
(cl:defmethod upSteerDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:upSteerDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:upSteerDEPRECATED instead.")
  (upSteerDEPRECATED m))

(cl:ensure-generic-function 'vEgo-val :lambda-list '(m))
(cl:defmethod vEgo-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vEgo-val is deprecated.  Use openpilot_bridge-msg:vEgo instead.")
  (vEgo m))

(cl:ensure-generic-function 'angleSteers-val :lambda-list '(m))
(cl:defmethod angleSteers-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:angleSteers-val is deprecated.  Use openpilot_bridge-msg:angleSteers instead.")
  (angleSteers m))

(cl:ensure-generic-function 'jerkFactor-val :lambda-list '(m))
(cl:defmethod jerkFactor-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:jerkFactor-val is deprecated.  Use openpilot_bridge-msg:jerkFactor instead.")
  (jerkFactor m))

(cl:ensure-generic-function 'alertType-val :lambda-list '(m))
(cl:defmethod alertType-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:alertType-val is deprecated.  Use openpilot_bridge-msg:alertType instead.")
  (alertType m))

(cl:ensure-generic-function 'aTarget-val :lambda-list '(m))
(cl:defmethod aTarget-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aTarget-val is deprecated.  Use openpilot_bridge-msg:aTarget instead.")
  (aTarget m))

(cl:ensure-generic-function 'alertStatus-val :lambda-list '(m))
(cl:defmethod alertStatus-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:alertStatus-val is deprecated.  Use openpilot_bridge-msg:alertStatus instead.")
  (alertStatus m))

(cl:ensure-generic-function 'alertSize-val :lambda-list '(m))
(cl:defmethod alertSize-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:alertSize-val is deprecated.  Use openpilot_bridge-msg:alertSize instead.")
  (alertSize m))

(cl:ensure-generic-function 'planMonoTime-val :lambda-list '(m))
(cl:defmethod planMonoTime-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:planMonoTime-val is deprecated.  Use openpilot_bridge-msg:planMonoTime instead.")
  (planMonoTime m))

(cl:ensure-generic-function 'aTargetMaxDEPRECATED-val :lambda-list '(m))
(cl:defmethod aTargetMaxDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aTargetMaxDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:aTargetMaxDEPRECATED instead.")
  (aTargetMaxDEPRECATED m))

(cl:ensure-generic-function 'uiAccelCmd-val :lambda-list '(m))
(cl:defmethod uiAccelCmd-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:uiAccelCmd-val is deprecated.  Use openpilot_bridge-msg:uiAccelCmd instead.")
  (uiAccelCmd m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:state-val is deprecated.  Use openpilot_bridge-msg:state instead.")
  (state m))

(cl:ensure-generic-function 'alertBlinkingRate-val :lambda-list '(m))
(cl:defmethod alertBlinkingRate-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:alertBlinkingRate-val is deprecated.  Use openpilot_bridge-msg:alertBlinkingRate instead.")
  (alertBlinkingRate m))

(cl:ensure-generic-function 'angleModelBiasDEPRECATED-val :lambda-list '(m))
(cl:defmethod angleModelBiasDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:angleModelBiasDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:angleModelBiasDEPRECATED instead.")
  (angleModelBiasDEPRECATED m))

(cl:ensure-generic-function 'alertText2-val :lambda-list '(m))
(cl:defmethod alertText2-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:alertText2-val is deprecated.  Use openpilot_bridge-msg:alertText2 instead.")
  (alertText2 m))

(cl:ensure-generic-function 'alertText1-val :lambda-list '(m))
(cl:defmethod alertText1-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:alertText1-val is deprecated.  Use openpilot_bridge-msg:alertText1 instead.")
  (alertText1 m))

(cl:ensure-generic-function 'yDesDEPRECATED-val :lambda-list '(m))
(cl:defmethod yDesDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:yDesDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:yDesDEPRECATED instead.")
  (yDesDEPRECATED m))

(cl:ensure-generic-function 'vPid-val :lambda-list '(m))
(cl:defmethod vPid-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vPid-val is deprecated.  Use openpilot_bridge-msg:vPid instead.")
  (vPid m))

(cl:ensure-generic-function 'vTargetLead-val :lambda-list '(m))
(cl:defmethod vTargetLead-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vTargetLead-val is deprecated.  Use openpilot_bridge-msg:vTargetLead instead.")
  (vTargetLead m))

(cl:ensure-generic-function 'decelForModel-val :lambda-list '(m))
(cl:defmethod decelForModel-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:decelForModel-val is deprecated.  Use openpilot_bridge-msg:decelForModel instead.")
  (decelForModel m))

(cl:ensure-generic-function 'gpsPlannerActive-val :lambda-list '(m))
(cl:defmethod gpsPlannerActive-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsPlannerActive-val is deprecated.  Use openpilot_bridge-msg:gpsPlannerActive instead.")
  (gpsPlannerActive m))

(cl:ensure-generic-function 'startMonoTime-val :lambda-list '(m))
(cl:defmethod startMonoTime-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:startMonoTime-val is deprecated.  Use openpilot_bridge-msg:startMonoTime instead.")
  (startMonoTime m))

(cl:ensure-generic-function 'canMonoTimeDEPRECATED-val :lambda-list '(m))
(cl:defmethod canMonoTimeDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:canMonoTimeDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:canMonoTimeDEPRECATED instead.")
  (canMonoTimeDEPRECATED m))

(cl:ensure-generic-function 'curvature-val :lambda-list '(m))
(cl:defmethod curvature-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:curvature-val is deprecated.  Use openpilot_bridge-msg:curvature instead.")
  (curvature m))

(cl:ensure-generic-function 'upAccelCmd-val :lambda-list '(m))
(cl:defmethod upAccelCmd-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:upAccelCmd-val is deprecated.  Use openpilot_bridge-msg:upAccelCmd instead.")
  (upAccelCmd m))

(cl:ensure-generic-function 'vCurvature-val :lambda-list '(m))
(cl:defmethod vCurvature-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vCurvature-val is deprecated.  Use openpilot_bridge-msg:vCurvature instead.")
  (vCurvature m))

(cl:ensure-generic-function 'hudLeadDEPRECATED-val :lambda-list '(m))
(cl:defmethod hudLeadDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hudLeadDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:hudLeadDEPRECATED instead.")
  (hudLeadDEPRECATED m))

(cl:ensure-generic-function 'active-val :lambda-list '(m))
(cl:defmethod active-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:active-val is deprecated.  Use openpilot_bridge-msg:active instead.")
  (active m))

(cl:ensure-generic-function 'awarenessStatus-val :lambda-list '(m))
(cl:defmethod awarenessStatus-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:awarenessStatus-val is deprecated.  Use openpilot_bridge-msg:awarenessStatus instead.")
  (awarenessStatus m))

(cl:ensure-generic-function 'uiSteerDEPRECATED-val :lambda-list '(m))
(cl:defmethod uiSteerDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:uiSteerDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:uiSteerDEPRECATED instead.")
  (uiSteerDEPRECATED m))

(cl:ensure-generic-function 'aEgoDEPRECATED-val :lambda-list '(m))
(cl:defmethod aEgoDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aEgoDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:aEgoDEPRECATED instead.")
  (aEgoDEPRECATED m))

(cl:ensure-generic-function 'alertSoundDEPRECATED-val :lambda-list '(m))
(cl:defmethod alertSoundDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:alertSoundDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:alertSoundDEPRECATED instead.")
  (alertSoundDEPRECATED m))

(cl:ensure-generic-function 'ufAccelCmd-val :lambda-list '(m))
(cl:defmethod ufAccelCmd-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ufAccelCmd-val is deprecated.  Use openpilot_bridge-msg:ufAccelCmd instead.")
  (ufAccelCmd m))

(cl:ensure-generic-function 'vCruise-val :lambda-list '(m))
(cl:defmethod vCruise-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vCruise-val is deprecated.  Use openpilot_bridge-msg:vCruise instead.")
  (vCruise m))

(cl:ensure-generic-function 'yActualDEPRECATED-val :lambda-list '(m))
(cl:defmethod yActualDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:yActualDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:yActualDEPRECATED instead.")
  (yActualDEPRECATED m))

(cl:ensure-generic-function 'enabled-val :lambda-list '(m))
(cl:defmethod enabled-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:enabled-val is deprecated.  Use openpilot_bridge-msg:enabled instead.")
  (enabled m))

(cl:ensure-generic-function 'aTargetMinDEPRECATED-val :lambda-list '(m))
(cl:defmethod aTargetMinDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aTargetMinDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:aTargetMinDEPRECATED instead.")
  (aTargetMinDEPRECATED m))

(cl:ensure-generic-function 'cumLagMs-val :lambda-list '(m))
(cl:defmethod cumLagMs-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cumLagMs-val is deprecated.  Use openpilot_bridge-msg:cumLagMs instead.")
  (cumLagMs m))

(cl:ensure-generic-function 'mapValid-val :lambda-list '(m))
(cl:defmethod mapValid-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mapValid-val is deprecated.  Use openpilot_bridge-msg:mapValid instead.")
  (mapValid m))

(cl:ensure-generic-function 'pathPlanMonoTime-val :lambda-list '(m))
(cl:defmethod pathPlanMonoTime-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pathPlanMonoTime-val is deprecated.  Use openpilot_bridge-msg:pathPlanMonoTime instead.")
  (pathPlanMonoTime m))

(cl:ensure-generic-function 'engageable-val :lambda-list '(m))
(cl:defmethod engageable-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:engageable-val is deprecated.  Use openpilot_bridge-msg:engageable instead.")
  (engageable m))

(cl:ensure-generic-function 'mdMonoTimeDEPRECATED-val :lambda-list '(m))
(cl:defmethod mdMonoTimeDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:mdMonoTimeDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:mdMonoTimeDEPRECATED instead.")
  (mdMonoTimeDEPRECATED m))

(cl:ensure-generic-function 'driverMonitoringOn-val :lambda-list '(m))
(cl:defmethod driverMonitoringOn-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:driverMonitoringOn-val is deprecated.  Use openpilot_bridge-msg:driverMonitoringOn instead.")
  (driverMonitoringOn m))

(cl:ensure-generic-function 'canMonoTimes-val :lambda-list '(m))
(cl:defmethod canMonoTimes-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:canMonoTimes-val is deprecated.  Use openpilot_bridge-msg:canMonoTimes instead.")
  (canMonoTimes m))

(cl:ensure-generic-function 'radarStateMonoTimeDEPRECATED-val :lambda-list '(m))
(cl:defmethod radarStateMonoTimeDEPRECATED-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:radarStateMonoTimeDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:radarStateMonoTimeDEPRECATED instead.")
  (radarStateMonoTimeDEPRECATED m))

(cl:ensure-generic-function 'longControlState-val :lambda-list '(m))
(cl:defmethod longControlState-val ((m <ControlsState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:longControlState-val is deprecated.  Use openpilot_bridge-msg:longControlState instead.")
  (longControlState m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ControlsState>) ostream)
  "Serializes a message object of type '<ControlsState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ufSteerDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angleSteersDes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'decelForTurn) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'steerOverride) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rearViewCam) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'canErrorCounter)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lateralControlState) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vEgoRaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'forceDecel) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'alertSound)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'alertSound)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'alertSound)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'alertSound)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'upSteerDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vEgo))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angleSteers))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'jerkFactor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'alertType))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'alertType))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aTarget))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'alertStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'alertStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'alertStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'alertStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'alertSize)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'alertSize)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'alertSize)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'alertSize)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'planMonoTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aTargetMaxDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'uiAccelCmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'state)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'alertBlinkingRate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angleModelBiasDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'alertText2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'alertText2))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'alertText1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'alertText1))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yDesDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vPid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vTargetLead))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'decelForModel) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gpsPlannerActive) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'startMonoTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'canMonoTimeDEPRECATED)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'curvature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'upAccelCmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vCurvature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'hudLeadDEPRECATED)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'active) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'awarenessStatus))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'uiSteerDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aEgoDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'alertSoundDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'alertSoundDEPRECATED))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ufAccelCmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vCruise))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yActualDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enabled) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aTargetMinDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'cumLagMs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'mapValid) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'pathPlanMonoTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'engageable) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'mdMonoTimeDEPRECATED)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'driverMonitoringOn) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'canMonoTimes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    ))
   (cl:slot-value msg 'canMonoTimes))
  (cl:let* ((signed (cl:slot-value msg 'radarStateMonoTimeDEPRECATED)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'longControlState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'longControlState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'longControlState)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'longControlState)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ControlsState>) istream)
  "Deserializes a message object of type '<ControlsState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ufSteerDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angleSteersDes) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'decelForTurn) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'steerOverride) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rearViewCam) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'canErrorCounter) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lateralControlState) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vEgoRaw) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'forceDecel) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'alertSound)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'alertSound)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'alertSound)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'alertSound)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'upSteerDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vEgo) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angleSteers) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'jerkFactor) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'alertType) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'alertType)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aTarget) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'alertStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'alertStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'alertStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'alertStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'alertSize)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'alertSize)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'alertSize)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'alertSize)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'planMonoTime) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aTargetMaxDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'uiAccelCmd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'state)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'alertBlinkingRate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angleModelBiasDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'alertText2) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'alertText2)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'alertText1) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'alertText1)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yDesDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vPid) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vTargetLead) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'decelForModel) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gpsPlannerActive) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'startMonoTime) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'canMonoTimeDEPRECATED) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'curvature) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'upAccelCmd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vCurvature) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'hudLeadDEPRECATED) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'active) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'awarenessStatus) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'uiSteerDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aEgoDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'alertSoundDEPRECATED) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'alertSoundDEPRECATED)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ufAccelCmd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vCruise) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yActualDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enabled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aTargetMinDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'cumLagMs) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'mapValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pathPlanMonoTime) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'engageable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mdMonoTimeDEPRECATED) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'driverMonitoringOn) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'canMonoTimes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'canMonoTimes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616)))))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'radarStateMonoTimeDEPRECATED) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'longControlState)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'longControlState)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'longControlState)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'longControlState)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ControlsState>)))
  "Returns string type for a message object of type '<ControlsState>"
  "openpilot_bridge/ControlsState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ControlsState)))
  "Returns string type for a message object of type 'ControlsState"
  "openpilot_bridge/ControlsState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ControlsState>)))
  "Returns md5sum for a message object of type '<ControlsState>"
  "0a15b01853a70f5b28cd348ddb6112ec")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ControlsState)))
  "Returns md5sum for a message object of type 'ControlsState"
  "0a15b01853a70f5b28cd348ddb6112ec")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ControlsState>)))
  "Returns full string definition for message of type '<ControlsState>"
  (cl:format cl:nil "Header header~%~%float32 ufSteerDEPRECATED~%float32 angleSteersDes~%bool decelForTurn~%bool steerOverride~%bool rearViewCam~%int64 canErrorCounter~%Lateralcontrolstate lateralControlState~%float32 vEgoRaw~%bool forceDecel~%uint32 alertSound # enum const: AudibleAlert~%float32 upSteerDEPRECATED~%float32 vEgo~%float32 angleSteers~%float32 jerkFactor~%string[] alertType~%float32 aTarget~%uint32 alertStatus # enum const: AlertStatus~%uint32 alertSize # enum const: AlertSize~%int64 planMonoTime~%float32 aTargetMaxDEPRECATED~%float32 uiAccelCmd~%uint32 state # enum const: OpenpilotState~%float32 alertBlinkingRate~%float32 angleModelBiasDEPRECATED~%string[] alertText2~%string[] alertText1~%float32 yDesDEPRECATED~%float32 vPid~%float32 vTargetLead~%bool decelForModel~%bool gpsPlannerActive~%int64 startMonoTime~%int64 canMonoTimeDEPRECATED~%float32 curvature~%float32 upAccelCmd~%float32 vCurvature~%int32 hudLeadDEPRECATED~%bool active~%float32 awarenessStatus~%float32 uiSteerDEPRECATED~%float32 aEgoDEPRECATED~%string[] alertSoundDEPRECATED~%float32 ufAccelCmd~%float32 vCruise~%float32 yActualDEPRECATED~%bool enabled~%float32 aTargetMinDEPRECATED~%float32 cumLagMs~%bool mapValid~%int64 pathPlanMonoTime~%bool engageable~%int64 mdMonoTimeDEPRECATED~%bool driverMonitoringOn~%int64[] canMonoTimes~%int64 radarStateMonoTimeDEPRECATED~%uint32 longControlState # enum const: LongControlState~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Lateralcontrolstate~%Header header~%~%LateralLQRState lqrState~%LateralPIDState pidState~%LateralINDIState indiState~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRState~%Header header~%~%bool saturated~%float32 i~%float32 lqrOutput~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDState~%Header header~%~%bool saturated~%float32 p~%float32 steerRate~%float32 f~%float32 i~%float32 angleError~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralINDIState~%Header header~%~%float32 rateSetPoint~%float32 delayedOutput~%bool saturated~%float32 steerAccel~%float32 steerRate~%float32 delta~%float32 accelError~%float32 accelSetPoint~%bool active~%float32 output~%float32 steerAngle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ControlsState)))
  "Returns full string definition for message of type 'ControlsState"
  (cl:format cl:nil "Header header~%~%float32 ufSteerDEPRECATED~%float32 angleSteersDes~%bool decelForTurn~%bool steerOverride~%bool rearViewCam~%int64 canErrorCounter~%Lateralcontrolstate lateralControlState~%float32 vEgoRaw~%bool forceDecel~%uint32 alertSound # enum const: AudibleAlert~%float32 upSteerDEPRECATED~%float32 vEgo~%float32 angleSteers~%float32 jerkFactor~%string[] alertType~%float32 aTarget~%uint32 alertStatus # enum const: AlertStatus~%uint32 alertSize # enum const: AlertSize~%int64 planMonoTime~%float32 aTargetMaxDEPRECATED~%float32 uiAccelCmd~%uint32 state # enum const: OpenpilotState~%float32 alertBlinkingRate~%float32 angleModelBiasDEPRECATED~%string[] alertText2~%string[] alertText1~%float32 yDesDEPRECATED~%float32 vPid~%float32 vTargetLead~%bool decelForModel~%bool gpsPlannerActive~%int64 startMonoTime~%int64 canMonoTimeDEPRECATED~%float32 curvature~%float32 upAccelCmd~%float32 vCurvature~%int32 hudLeadDEPRECATED~%bool active~%float32 awarenessStatus~%float32 uiSteerDEPRECATED~%float32 aEgoDEPRECATED~%string[] alertSoundDEPRECATED~%float32 ufAccelCmd~%float32 vCruise~%float32 yActualDEPRECATED~%bool enabled~%float32 aTargetMinDEPRECATED~%float32 cumLagMs~%bool mapValid~%int64 pathPlanMonoTime~%bool engageable~%int64 mdMonoTimeDEPRECATED~%bool driverMonitoringOn~%int64[] canMonoTimes~%int64 radarStateMonoTimeDEPRECATED~%uint32 longControlState # enum const: LongControlState~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Lateralcontrolstate~%Header header~%~%LateralLQRState lqrState~%LateralPIDState pidState~%LateralINDIState indiState~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRState~%Header header~%~%bool saturated~%float32 i~%float32 lqrOutput~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDState~%Header header~%~%bool saturated~%float32 p~%float32 steerRate~%float32 f~%float32 i~%float32 angleError~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralINDIState~%Header header~%~%float32 rateSetPoint~%float32 delayedOutput~%bool saturated~%float32 steerAccel~%float32 steerRate~%float32 delta~%float32 accelError~%float32 accelSetPoint~%bool active~%float32 output~%float32 steerAngle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ControlsState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     1
     1
     1
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lateralControlState))
     4
     1
     4
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'alertType) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4
     4
     4
     8
     4
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'alertText2) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'alertText1) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4
     4
     4
     1
     1
     8
     8
     4
     4
     4
     4
     1
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'alertSoundDEPRECATED) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4
     4
     4
     1
     4
     4
     1
     8
     1
     8
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'canMonoTimes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     8
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ControlsState>))
  "Converts a ROS message object to a list"
  (cl:list 'ControlsState
    (cl:cons ':header (header msg))
    (cl:cons ':ufSteerDEPRECATED (ufSteerDEPRECATED msg))
    (cl:cons ':angleSteersDes (angleSteersDes msg))
    (cl:cons ':decelForTurn (decelForTurn msg))
    (cl:cons ':steerOverride (steerOverride msg))
    (cl:cons ':rearViewCam (rearViewCam msg))
    (cl:cons ':canErrorCounter (canErrorCounter msg))
    (cl:cons ':lateralControlState (lateralControlState msg))
    (cl:cons ':vEgoRaw (vEgoRaw msg))
    (cl:cons ':forceDecel (forceDecel msg))
    (cl:cons ':alertSound (alertSound msg))
    (cl:cons ':upSteerDEPRECATED (upSteerDEPRECATED msg))
    (cl:cons ':vEgo (vEgo msg))
    (cl:cons ':angleSteers (angleSteers msg))
    (cl:cons ':jerkFactor (jerkFactor msg))
    (cl:cons ':alertType (alertType msg))
    (cl:cons ':aTarget (aTarget msg))
    (cl:cons ':alertStatus (alertStatus msg))
    (cl:cons ':alertSize (alertSize msg))
    (cl:cons ':planMonoTime (planMonoTime msg))
    (cl:cons ':aTargetMaxDEPRECATED (aTargetMaxDEPRECATED msg))
    (cl:cons ':uiAccelCmd (uiAccelCmd msg))
    (cl:cons ':state (state msg))
    (cl:cons ':alertBlinkingRate (alertBlinkingRate msg))
    (cl:cons ':angleModelBiasDEPRECATED (angleModelBiasDEPRECATED msg))
    (cl:cons ':alertText2 (alertText2 msg))
    (cl:cons ':alertText1 (alertText1 msg))
    (cl:cons ':yDesDEPRECATED (yDesDEPRECATED msg))
    (cl:cons ':vPid (vPid msg))
    (cl:cons ':vTargetLead (vTargetLead msg))
    (cl:cons ':decelForModel (decelForModel msg))
    (cl:cons ':gpsPlannerActive (gpsPlannerActive msg))
    (cl:cons ':startMonoTime (startMonoTime msg))
    (cl:cons ':canMonoTimeDEPRECATED (canMonoTimeDEPRECATED msg))
    (cl:cons ':curvature (curvature msg))
    (cl:cons ':upAccelCmd (upAccelCmd msg))
    (cl:cons ':vCurvature (vCurvature msg))
    (cl:cons ':hudLeadDEPRECATED (hudLeadDEPRECATED msg))
    (cl:cons ':active (active msg))
    (cl:cons ':awarenessStatus (awarenessStatus msg))
    (cl:cons ':uiSteerDEPRECATED (uiSteerDEPRECATED msg))
    (cl:cons ':aEgoDEPRECATED (aEgoDEPRECATED msg))
    (cl:cons ':alertSoundDEPRECATED (alertSoundDEPRECATED msg))
    (cl:cons ':ufAccelCmd (ufAccelCmd msg))
    (cl:cons ':vCruise (vCruise msg))
    (cl:cons ':yActualDEPRECATED (yActualDEPRECATED msg))
    (cl:cons ':enabled (enabled msg))
    (cl:cons ':aTargetMinDEPRECATED (aTargetMinDEPRECATED msg))
    (cl:cons ':cumLagMs (cumLagMs msg))
    (cl:cons ':mapValid (mapValid msg))
    (cl:cons ':pathPlanMonoTime (pathPlanMonoTime msg))
    (cl:cons ':engageable (engageable msg))
    (cl:cons ':mdMonoTimeDEPRECATED (mdMonoTimeDEPRECATED msg))
    (cl:cons ':driverMonitoringOn (driverMonitoringOn msg))
    (cl:cons ':canMonoTimes (canMonoTimes msg))
    (cl:cons ':radarStateMonoTimeDEPRECATED (radarStateMonoTimeDEPRECATED msg))
    (cl:cons ':longControlState (longControlState msg))
))
