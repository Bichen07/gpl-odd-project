
"use strict";

let LowBeam = require('./LowBeam.js');
let DoorLock = require('./DoorLock.js');
let ParkingBrake = require('./ParkingBrake.js');
let WatchdogStatus = require('./WatchdogStatus.js');
let TwistCmd = require('./TwistCmd.js');
let WheelPositionReport = require('./WheelPositionReport.js');
let Steering2Report = require('./Steering2Report.js');
let WiperRear = require('./WiperRear.js');
let WheelSpeedReport = require('./WheelSpeedReport.js');
let ParkingBrkReq = require('./ParkingBrkReq.js');
let WheelSpeedType = require('./WheelSpeedType.js');
let WiperFront = require('./WiperFront.js');
let SonarArcNum = require('./SonarArcNum.js');
let Door = require('./Door.js');
let BrakeReport = require('./BrakeReport.js');
let LowVoltageSystemReport = require('./LowVoltageSystemReport.js');
let Gear = require('./Gear.js');
let GlobalEnableCmd = require('./GlobalEnableCmd.js');
let TirePressureReport = require('./TirePressureReport.js');
let FaultActionsReport = require('./FaultActionsReport.js');
let BrakeCmd = require('./BrakeCmd.js');
let Brake2Report = require('./Brake2Report.js');
let Ignition = require('./Ignition.js');
let HighBeam = require('./HighBeam.js');
let AcceleratorPedalCmd = require('./AcceleratorPedalCmd.js');
let ActuatorsReport = require('./ActuatorsReport.js');
let SurroundReport = require('./SurroundReport.js');
let MiscReport = require('./MiscReport.js');
let AcceleratorPedalReport = require('./AcceleratorPedalReport.js');
let GearReport = require('./GearReport.js');
let ActuatorControlMode = require('./ActuatorControlMode.js');
let SteeringReport = require('./SteeringReport.js');
let DoorRequest = require('./DoorRequest.js');
let TurnSignal = require('./TurnSignal.js');
let GearCmd = require('./GearCmd.js');
let DriverInputReport = require('./DriverInputReport.js');
let MiscCmd = require('./MiscCmd.js');
let SteeringCmd = require('./SteeringCmd.js');

module.exports = {
  LowBeam: LowBeam,
  DoorLock: DoorLock,
  ParkingBrake: ParkingBrake,
  WatchdogStatus: WatchdogStatus,
  TwistCmd: TwistCmd,
  WheelPositionReport: WheelPositionReport,
  Steering2Report: Steering2Report,
  WiperRear: WiperRear,
  WheelSpeedReport: WheelSpeedReport,
  ParkingBrkReq: ParkingBrkReq,
  WheelSpeedType: WheelSpeedType,
  WiperFront: WiperFront,
  SonarArcNum: SonarArcNum,
  Door: Door,
  BrakeReport: BrakeReport,
  LowVoltageSystemReport: LowVoltageSystemReport,
  Gear: Gear,
  GlobalEnableCmd: GlobalEnableCmd,
  TirePressureReport: TirePressureReport,
  FaultActionsReport: FaultActionsReport,
  BrakeCmd: BrakeCmd,
  Brake2Report: Brake2Report,
  Ignition: Ignition,
  HighBeam: HighBeam,
  AcceleratorPedalCmd: AcceleratorPedalCmd,
  ActuatorsReport: ActuatorsReport,
  SurroundReport: SurroundReport,
  MiscReport: MiscReport,
  AcceleratorPedalReport: AcceleratorPedalReport,
  GearReport: GearReport,
  ActuatorControlMode: ActuatorControlMode,
  SteeringReport: SteeringReport,
  DoorRequest: DoorRequest,
  TurnSignal: TurnSignal,
  GearCmd: GearCmd,
  DriverInputReport: DriverInputReport,
  MiscCmd: MiscCmd,
  SteeringCmd: SteeringCmd,
};
