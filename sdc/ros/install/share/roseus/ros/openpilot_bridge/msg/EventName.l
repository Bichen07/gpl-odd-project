;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::EventName)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'EventName (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::EVENTNAME")
  (make-package "OPENPILOT_BRIDGE::EVENTNAME"))

(in-package "ROS")
;;//! \htmlinclude EventName.msg.html


(intern "*PEDALPRESSED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PEDALPRESSED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PEDALPRESSED* 13)
(intern "*DRIVERUNRESPONSIVE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*DRIVERUNRESPONSIVE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*DRIVERUNRESPONSIVE* 45)
(intern "*COMMUNITYFEATUREDISALLOWED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*COMMUNITYFEATUREDISALLOWED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*COMMUNITYFEATUREDISALLOWED* 62)
(intern "*CONTROLSMISMATCH*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*CONTROLSMISMATCH* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*CONTROLSMISMATCH* 22)
(intern "*MODELCOMMISSUEDEPRECATED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*MODELCOMMISSUEDEPRECATED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*MODELCOMMISSUEDEPRECATED* 27)
(intern "*PLANNERERROR*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PLANNERERROR* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PLANNERERROR* 32)
(intern "*CRUISEDISABLED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*CRUISEDISABLED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*CRUISEDISABLED* 14)
(intern "*PARKBRAKE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PARKBRAKE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PARKBRAKE* 29)
(intern "*CONTROLSFAILED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*CONTROLSFAILED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*CONTROLSFAILED* 51)
(intern "*RADARFAULT*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*RADARFAULT* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*RADARFAULT* 26)
(intern "*PROMPTDRIVERUNRESPONSIVE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PROMPTDRIVERUNRESPONSIVE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PROMPTDRIVERUNRESPONSIVE* 44)
(intern "*PROMPTDRIVERDISTRACTED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PROMPTDRIVERDISTRACTED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PROMPTDRIVERDISTRACTED* 38)
(intern "*ESPDISABLED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*ESPDISABLED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*ESPDISABLED* 7)
(intern "*LANECHANGE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*LANECHANGE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*LANECHANGE* 59)
(intern "*PRELANECHANGERIGHT*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PRELANECHANGERIGHT* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PRELANECHANGERIGHT* 58)
(intern "*BELOWSTEERSPEED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*BELOWSTEERSPEED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*BELOWSTEERSPEED* 46)
(intern "*OUTOFSPACE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*OUTOFSPACE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*OUTOFSPACE* 18)
(intern "*SEATBELTNOTLATCHED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*SEATBELTNOTLATCHED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*SEATBELTNOTLATCHED* 6)
(intern "*DRIVERDISTRACTED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*DRIVERDISTRACTED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*DRIVERDISTRACTED* 39)
(intern "*STEERTEMPUNAVAILABLE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*STEERTEMPUNAVAILABLE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*STEERTEMPUNAVAILABLE* 9)
(intern "*PREDRIVERUNRESPONSIVE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PREDRIVERUNRESPONSIVE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PREDRIVERUNRESPONSIVE* 43)
(intern "*DEBUGALERT*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*DEBUGALERT* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*DEBUGALERT* 34)
(intern "*OVERHEAT*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*OVERHEAT* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*OVERHEAT* 19)
(intern "*WRONGCARMODE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*WRONGCARMODE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*WRONGCARMODE* 8)
(intern "*DRIVERMONITOROFF*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*DRIVERMONITOROFF* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*DRIVERMONITOROFF* 42)
(intern "*INVALIDGIRAFFEHONDA*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*INVALIDGIRAFFEHONDA* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*INVALIDGIRAFFEHONDA* 49)
(intern "*VEHICLEMODELINVALID*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*VEHICLEMODELINVALID* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*VEHICLEMODELINVALID* 50)
(intern "*PCMDISABLE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PCMDISABLE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PCMDISABLE* 24)
(intern "*TOODISTRACTED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*TOODISTRACTED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*TOODISTRACTED* 54)
(intern "*BRAKEUNAVAILABLE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*BRAKEUNAVAILABLE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*BRAKEUNAVAILABLE* 2)
(intern "*DOOROPEN*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*DOOROPEN* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*DOOROPEN* 5)
(intern "*SPEEDTOOLOW*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*SPEEDTOOLOW* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*SPEEDTOOLOW* 17)
(intern "*RADARCOMMISSUE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*RADARCOMMISSUE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*RADARCOMMISSUE* 67)
(intern "*CANERROR*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*CANERROR* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*CANERROR* 0)
(intern "*INVALIDGIRAFFETOYOTA*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*INVALIDGIRAFFETOYOTA* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*INVALIDGIRAFFETOYOTA* 60)
(intern "*POSENETINVALID*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*POSENETINVALID* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*POSENETINVALID* 55)
(intern "*RADARCANERROR*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*RADARCANERROR* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*RADARCANERROR* 15)
(intern "*COMMISSUE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*COMMISSUE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*COMMISSUE* 53)
(intern "*PREDRIVERDISTRACTED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PREDRIVERDISTRACTED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PREDRIVERDISTRACTED* 37)
(intern "*RESUMEREQUIRED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*RESUMEREQUIRED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*RESUMEREQUIRED* 36)
(intern "*STEERTEMPUNAVAILABLEMUTE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*STEERTEMPUNAVAILABLEMUTE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*STEERTEMPUNAVAILABLEMUTE* 35)
(intern "*PCMENABLE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PCMENABLE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PCMENABLE* 23)
(intern "*BUTTONCANCEL*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*BUTTONCANCEL* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*BUTTONCANCEL* 11)
(intern "*BRAKEHOLD*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*BRAKEHOLD* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*BRAKEHOLD* 28)
(intern "*STOCKAEB*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*STOCKAEB* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*STOCKAEB* 64)
(intern "*LOWBATTERY*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*LOWBATTERY* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*LOWBATTERY* 48)
(intern "*GASUNAVAILABLE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*GASUNAVAILABLE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*GASUNAVAILABLE* 3)
(intern "*IPASOVERRIDE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*IPASOVERRIDE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*IPASOVERRIDE* 33)
(intern "*DRIVERMONITORON*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*DRIVERMONITORON* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*DRIVERMONITORON* 41)
(intern "*SOUNDSUNAVAILABLE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*SOUNDSUNAVAILABLE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*SOUNDSUNAVAILABLE* 56)
(intern "*SENSORDATAINVALID*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*SENSORDATAINVALID* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*SENSORDATAINVALID* 52)
(intern "*REVERSEGEAR*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*REVERSEGEAR* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*REVERSEGEAR* 10)
(intern "*WRONGGEAR*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*WRONGGEAR* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*WRONGGEAR* 4)
(intern "*INTERNETCONNECTIVITYNEEDED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*INTERNETCONNECTIVITYNEEDED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*INTERNETCONNECTIVITYNEEDED* 61)
(intern "*CALIBRATIONPROGRESS*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*CALIBRATIONPROGRESS* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*CALIBRATIONPROGRESS* 47)
(intern "*MANUALRESTART*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*MANUALRESTART* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*MANUALRESTART* 30)
(intern "*CARUNRECOGNIZED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*CARUNRECOGNIZED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*CARUNRECOGNIZED* 66)
(intern "*LOWSPEEDLOCKOUT*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*LOWSPEEDLOCKOUT* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*LOWSPEEDLOCKOUT* 31)
(intern "*GEOFENCE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*GEOFENCE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*GEOFENCE* 40)
(intern "*NOTARGET*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*NOTARGET* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*NOTARGET* 25)
(intern "*CALIBRATIONINVALID*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*CALIBRATIONINVALID* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*CALIBRATIONINVALID* 21)
(intern "*DATANEEDED*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*DATANEEDED* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*DATANEEDED* 16)
(intern "*LOWMEMORY*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*LOWMEMORY* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*LOWMEMORY* 63)
(intern "*LDW*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*LDW* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*LDW* 65)
(intern "*CALIBRATIONINCOMPLETE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*CALIBRATIONINCOMPLETE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*CALIBRATIONINCOMPLETE* 20)
(intern "*STEERUNAVAILABLE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*STEERUNAVAILABLE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*STEERUNAVAILABLE* 1)
(intern "*BUTTONENABLE*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*BUTTONENABLE* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*BUTTONENABLE* 12)
(intern "*PRELANECHANGELEFT*" (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(shadow '*PRELANECHANGELEFT* (find-package "OPENPILOT_BRIDGE::EVENTNAME"))
(defconstant openpilot_bridge::EventName::*PRELANECHANGELEFT* 57)
(defclass openpilot_bridge::EventName
  :super ros::object
  :slots ())

(defmethod openpilot_bridge::EventName
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(setf (get openpilot_bridge::EventName :md5sum-) "40bebec5da2442ce998feedfddfdea22")
(setf (get openpilot_bridge::EventName :datatype-) "openpilot_bridge/EventName")
(setf (get openpilot_bridge::EventName :definition-)
      "uint32 pedalPressed=13
uint32 driverUnresponsive=45
uint32 communityFeatureDisallowed=62
uint32 controlsMismatch=22
uint32 modelCommIssueDEPRECATED=27
uint32 plannerError=32
uint32 cruiseDisabled=14
uint32 parkBrake=29
uint32 controlsFailed=51
uint32 radarFault=26
uint32 promptDriverUnresponsive=44
uint32 promptDriverDistracted=38
uint32 espDisabled=7
uint32 laneChange=59
uint32 preLaneChangeRight=58
uint32 belowSteerSpeed=46
uint32 outOfSpace=18
uint32 seatbeltNotLatched=6
uint32 driverDistracted=39
uint32 steerTempUnavailable=9
uint32 preDriverUnresponsive=43
uint32 debugAlert=34
uint32 overheat=19
uint32 wrongCarMode=8
uint32 driverMonitorOff=42
uint32 invalidGiraffeHonda=49
uint32 vehicleModelInvalid=50
uint32 pcmDisable=24
uint32 tooDistracted=54
uint32 brakeUnavailable=2
uint32 doorOpen=5
uint32 speedTooLow=17
uint32 radarCommIssue=67
uint32 canError=0
uint32 invalidGiraffeToyota=60
uint32 posenetInvalid=55
uint32 radarCanError=15
uint32 commIssue=53
uint32 preDriverDistracted=37
uint32 resumeRequired=36
uint32 steerTempUnavailableMute=35
uint32 pcmEnable=23
uint32 buttonCancel=11
uint32 brakeHold=28
uint32 stockAeb=64
uint32 lowBattery=48
uint32 gasUnavailable=3
uint32 ipasOverride=33
uint32 driverMonitorOn=41
uint32 soundsUnavailable=56
uint32 sensorDataInvalid=52
uint32 reverseGear=10
uint32 wrongGear=4
uint32 internetConnectivityNeeded=61
uint32 calibrationProgress=47
uint32 manualRestart=30
uint32 carUnrecognized=66
uint32 lowSpeedLockout=31
uint32 geofence=40
uint32 noTarget=25
uint32 calibrationInvalid=21
uint32 dataNeeded=16
uint32 lowMemory=63
uint32 ldw=65
uint32 calibrationIncomplete=20
uint32 steerUnavailable=1
uint32 buttonEnable=12
uint32 preLaneChangeLeft=57

")



(provide :openpilot_bridge/EventName "40bebec5da2442ce998feedfddfdea22")


