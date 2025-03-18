// Auto-generated. Do not edit!

// (in-package openpilot_bridge.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class EventName {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EventName
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EventName
    let len;
    let data = new EventName(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a message object
    return 'openpilot_bridge/EventName';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '40bebec5da2442ce998feedfddfdea22';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 pedalPressed=13
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new EventName(null);
    return resolved;
    }
};

// Constants for message
EventName.Constants = {
  PEDALPRESSED: 13,
  DRIVERUNRESPONSIVE: 45,
  COMMUNITYFEATUREDISALLOWED: 62,
  CONTROLSMISMATCH: 22,
  MODELCOMMISSUEDEPRECATED: 27,
  PLANNERERROR: 32,
  CRUISEDISABLED: 14,
  PARKBRAKE: 29,
  CONTROLSFAILED: 51,
  RADARFAULT: 26,
  PROMPTDRIVERUNRESPONSIVE: 44,
  PROMPTDRIVERDISTRACTED: 38,
  ESPDISABLED: 7,
  LANECHANGE: 59,
  PRELANECHANGERIGHT: 58,
  BELOWSTEERSPEED: 46,
  OUTOFSPACE: 18,
  SEATBELTNOTLATCHED: 6,
  DRIVERDISTRACTED: 39,
  STEERTEMPUNAVAILABLE: 9,
  PREDRIVERUNRESPONSIVE: 43,
  DEBUGALERT: 34,
  OVERHEAT: 19,
  WRONGCARMODE: 8,
  DRIVERMONITOROFF: 42,
  INVALIDGIRAFFEHONDA: 49,
  VEHICLEMODELINVALID: 50,
  PCMDISABLE: 24,
  TOODISTRACTED: 54,
  BRAKEUNAVAILABLE: 2,
  DOOROPEN: 5,
  SPEEDTOOLOW: 17,
  RADARCOMMISSUE: 67,
  CANERROR: 0,
  INVALIDGIRAFFETOYOTA: 60,
  POSENETINVALID: 55,
  RADARCANERROR: 15,
  COMMISSUE: 53,
  PREDRIVERDISTRACTED: 37,
  RESUMEREQUIRED: 36,
  STEERTEMPUNAVAILABLEMUTE: 35,
  PCMENABLE: 23,
  BUTTONCANCEL: 11,
  BRAKEHOLD: 28,
  STOCKAEB: 64,
  LOWBATTERY: 48,
  GASUNAVAILABLE: 3,
  IPASOVERRIDE: 33,
  DRIVERMONITORON: 41,
  SOUNDSUNAVAILABLE: 56,
  SENSORDATAINVALID: 52,
  REVERSEGEAR: 10,
  WRONGGEAR: 4,
  INTERNETCONNECTIVITYNEEDED: 61,
  CALIBRATIONPROGRESS: 47,
  MANUALRESTART: 30,
  CARUNRECOGNIZED: 66,
  LOWSPEEDLOCKOUT: 31,
  GEOFENCE: 40,
  NOTARGET: 25,
  CALIBRATIONINVALID: 21,
  DATANEEDED: 16,
  LOWMEMORY: 63,
  LDW: 65,
  CALIBRATIONINCOMPLETE: 20,
  STEERUNAVAILABLE: 1,
  BUTTONENABLE: 12,
  PRELANECHANGELEFT: 57,
}

module.exports = EventName;
