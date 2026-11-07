1. 車輛能力問題，胡博士他們傳來的論文，是否有提到? 標準模型可以參考?
胡博信件部分內容:{
    (1) ODD-constrained agentic scenario generation

(1.1) Agentic AI 能否在不違反指定 ODD 的前提下，自主產生能揭露系統弱點的情境

(1.2) 加入一些規範，例如 Euro NCAP AEB test protocol，在 ODD 中生成指定的測試情境類別



(2) Given 行駛路線 & 地圖，Agentic AI 生成對應的 ODD

比較厲害的方法是用 google map，高精地圖也行



還有幾篇很快搜尋的參考文獻

https://anonymous-research-paper.github.io/Chat2Scenic/

https://arxiv.org/abs/2509.08638

---
前一陣子 simulation team 主要的工作是用 NVIDIA Alpamayo 嚐試一些應用，包含 decision-making guidance 以及 scenario retrieval。另外，Autoware 與 ITRI 自駕系統的 benchmark 也持續推動。但目前幾乎所有人力都放在「桃機旅客運輸系統」專案，上述工作要等約二個月後，simulation team 才會繼續執行。
如果方便，不涉及機密...或其他我們不應該知道細節...，建議弼辰可以分享已完成的功能，我目前有空的時間在週四和週五下午。
關於我分享的 idea: Given 行駛路線 & 地圖，Agentic AI 生成對應的 ODD，我補充一點細節：
         3.1 我原本的想法比較大膽一點。應用 VLA model 辨識 Google Maps Street View 或行車紀錄器檔案，完成 ODD 道路佈景屬性，可參考「自駕公車實驗運行安全指引」page 31 (已加入檔案連結)。有 point cloud map 和 semantic map 也幫助，可以完成更多屬性。
         3.2 有了 ODD 和行駛任務規格，應可宣告自駕系統性能 (自駕公車實驗運行安全指引 page 41)
         3.3 有 location-dependent traffic data 是很好的 inputs。另外，ISO 34502 page 57 有建議一個 structured analysis method 用來建立 test sceanrios. 如果有一個 Agentic AI 可以執行，我預期也可以節省很多 manual efforts。ISO 34502 https://drive.google.com/open?id=1fh4T1dxXlsB9PHhec7qIqCh4c8TlCt_T&usp=drive_fs

   4. 如果是以分析為主，現在有很多 end-to-end 的系統，更新後，如何分析前後軟體版本的 performance，我認為也是重要的方向。
   5. Safety-Critical Scenarios & Corner Cases 一直都是很重要的驗證需求，不過已經有很多文獻了，2026 年都還有，是個競爭的題目。


提供幾點小建議，希望對你們的研究有幫助。

}


2. 交通狀況越複雜，自駕車反應、處理的時間可能需要越久。還是可以假定固定時間內完成處理?

> **Research note — do not treat one fixed time as a fact.** Traffic complexity can change perception workload, tracking ambiguity, prediction/planning complexity, and scheduling/communication delay. For an actual ADS, measure a latency *distribution* for a stated hardware, software version, ODD, and scenario class (for example p50/p95/p99), rather than assert that every case finishes within one fixed time. A fixed value is acceptable only as a clearly labelled simulator or sensitivity-analysis assumption.
>
> The required future telemetry chain is: `sensor_capture` → `perception_detection` → `track_update` → `planner_input` → `trajectory_or_decision_output` → `control_command` → `actuator_feedback`. Define processing latency as `t(control_command) - t(sensor_capture)` and record actuation delay separately. This makes it possible to identify whether a delay occurred in sensing, perception, planning, control, or physical actuation.
>
> Autoware's [pipeline latency monitor](https://autowarefoundation.github.io/autoware_universe/main/system/autoware_pipeline_latency_monitor/) and [Reaction Analyzer](https://autowarefoundation.github.io/autoware_tools/main/system/reaction_analyzer/) provide concrete examples of measuring component, pipeline, and total reaction latency from timestamped ROS messages. Betz et al., [*Latency Measurement for Autonomous Driving Software Using Data Flow Extraction*](https://mediatum.ub.tum.de/doc/1785218/1785218.pdf), likewise defines end-to-end latency as the interval from new perception data becoming available to a steering/acceleration/brake command being produced. These are measurement methods, **not** a universal acceptable time threshold.
>
> **Project implication:** current archived trajectory data cannot measure this chain. The Phase-A capability card must keep response delay `unavailable`; any demonstrator profile must be labelled `assumed`, versioned, sourced, and accompanied by a sensitivity result.

3. 從模型下手，有哪些可以參考，查詢perception 模組，能不能參考，例如怎樣可以接受資訊? 反應要多久? 

> **Research note — reference architecture, not evidence about the historical trial.** A practical modular reference is: sensor drivers/time synchronization → sensor preprocessing → object detection/classification → tracking and fusion → prediction → planning → control → vehicle/actuator feedback. The [Autoware perception documentation](https://autowarefoundation.github.io/autoware_core/main/perception/autoware_core_perception/) and its [perception replayer](https://autowarefoundation.github.io/autoware_tools/main/planning/planning_debug_tools/) are useful examples of the interfaces to archive: sensor data, localization, tracked/predicted objects, occupancy grid, route, and traffic signals.
>
> For this project, a perception event should be accepted only when it contains at least: sensor/source ID; sensor capture timestamp; detection/tracking timestamp; actor/track ID; class and confidence; pose/velocity; coordinate frame; software/configuration version; and an artifact or log hash. A planner/control event should additionally record its input-track ID, decision/trajectory timestamp, command timestamp, and actuator feedback. Without this evidence, the project cannot infer that the system received, detected, tracked, or reacted to a particular actor.
>
> A model can be used in two different ways: (1) a **run-bound model**, whose configuration and hash were recorded during the trial, can support a conditional engineering calculation; or (2) a **reference assumption profile**, used only for sensitivity analysis. ISO 11010-1 provides a [framework for selecting vehicle-dynamics model classes and types](https://www.iso.org/standard/75910.html) for an intended manoeuvre; it does not prescribe one universal vehicle model or prove the capability of this project’s historical trial.

#### Perception-model review and proposed project plan (future data capture; no historical backfill)

**Important distinction.** ISO 11010-1 concerns **vehicle-dynamics simulation models**, not perception models. A perception model must answer a different question: what information was available to the ADS at a particular time, with what uncertainty and latency? A trajectory alone cannot answer that question retrospectively.

**Current repository finding.** The current simulator code already publishes a topic named `detected_objects`, and `simulation_monitor/config/recorded_data.json` lists that topic for accident recording. However, `scenario_simulator.cpp` populates the publisher by passing every simulator agent from `mAgentManager->GetAgents()`, and `scenario_detected_object_publisher.cpp` converts those agent states into `itri_msgs/DetectedObjectArray`. Static code inspection therefore supports only this conclusion: this path is **simulator-world-state / oracle object data**, unless a future runtime audit proves that a different ADS perception publisher supplied the message. It must not be relabelled as camera/LiDAR/radar detection, proof of line-of-sight, or proof that the historical Ego system perceived the actor.

| Candidate model / interface | What it can legitimately represent | Fit for this project | Decision |
| --- | --- | --- | --- |
| Existing simulator `detected_objects` / agent states | Timestamped simulator ground truth: actor identity, pose, velocity, and dimensions available to the simulator. | Useful for trajectory truth, ground-truth association, collision analysis, and evaluating a later simulated perception output. It is not perception evidence. | Preserve as a separate `simulator_ground_truth` stream; never use it as `first_detected`. |
| esmini ideal sensor | A configurable FOV/near/far visibility filter over object reference points. esmini explicitly notes that its sensor model is rough, does not consider OpenDRIVE stationary objects, and does not model full object overlap/occlusion. | Useful only as a transparent, configured visibility **sensitivity** demonstrator. | Optional small experiment; output is `configured`/`assumed`, never recorded ADS detection. |
| ASAM OSI / OSMP interface | A modular chain from simulator `GroundTruth` to `SensorView`/`FeatureData` to limited-perception `SensorData`. | Good long-term interoperability boundary between esmini and a pluggable sensor/perception model. | Recommended data contract if future simulation work is approved; do not claim esmini already supplies a sensor model. |
| Perception Error Model (PEM) | A calibrated probabilistic model of missed, delayed, mislocalized, or misclassified objects, without rendering a physical sensor. | Potentially efficient for sensitivity studies once calibrated against target-system logs or a justified dataset. | Research option only; do not import generic PEM parameters as facts about this Ego or archived trial. |
| Full simulated sensor + perception stack (for example CARLA/AWSIM plus Autoware) | Logged simulated camera/LiDAR/radar inputs, detector/fusion/tracker outputs, and pipeline latency. | Strongest virtual-perception evaluation, but requires a simulator bridge, compatible ROS version/message adapters, hardware budget, and validation. | Separate future pilot, not Phase-A scope and not required for the Replayer/LLM work. |
| Actual ADS/sensor ROS logs | The real output of the evaluated detection, tracking, planning, and control pipeline. | Best evidence for first detection and response timing when source identity and time synchronization are retained. | Preferred future source whenever the simulation/ADS team can provide it. |

**Relevant external references.** esmini can export [OSI GroundTruth](https://esmini.github.io/esmini-lib-programming.html) but says sensor models are out of scope; its documented ideal sensor has only FOV/near/far reference-point filtering. [ASAM OSI](https://www.asam.net/fileadmin/Standards/OSI/ASAM_OSI_User-Guide_v3.5.0.html) distinguishes simulator `GroundTruth` from `SensorData` produced by sensor models. Autoware provides a reference modular architecture for [detection/tracking/fusion](https://autowarefoundation.github.io/autoware_core/main/perception/autoware_core_perception/), and its [multi-object tracker](https://autowarefoundation.github.io/autoware_universe/pr-10143/perception/autoware_multi_object_tracker/) illustrates detections-to-tracks interfaces. Piazzoni et al., [*PEM: Perception Error Model for Virtual Testing of Autonomous Vehicles*](https://doi.org/10.1109/TITS.2023.3311633), supports error-model-based virtual tests, but calibrates the model rather than treating it as universal ground truth.

**Recommended construction: a provenance-first perception evidence pipeline.** Do not begin by training a new vision model. First capture and distinguish the following time-aligned streams under one immutable `run_id`:

```text
simulator_ground_truth  →  sensor/perception pipeline  →  planner  →  controller  →  actuator feedback
        (world truth)        (what the ADS received)       (decision)    (command)      (vehicle motion)
```

1. **World-state stream:** simulator actor ID, pose, dimensions, velocity, map/frame, simulator time, and run hash. This is a validation reference only.
2. **Detection stream:** sensor ID, capture time, detection publication time, object/track ID, class, confidence/existence probability, pose/covariance, frame, and a ground-truth association ID/method.
3. **Tracking and planning streams:** track creation/update/loss, planner-input snapshot hash, predicted actor IDs, selected trajectory/mode, and decision timestamp.
4. **Control and actuation streams:** command issue time, requested brake/throttle/steering, feedback time, measured acceleration/steering, and controller/configuration hash.
5. **Manifest:** simulator, map, vehicle, sensor, perception, planner, and controller versions/hashes; clock convention; ROS topic names/types; and an immutable bag/artifact hash.

Only a detection or track emitted by the evaluated pipeline may populate `perception.first_detected` with `status: recorded`. Ground truth may be used to evaluate false negatives, delay, and association quality, but it must retain `source.kind: simulator_ground_truth`. An ideal-sensor or PEM result is a separately stored `configured` or `assumed` sensitivity result and cannot overwrite either stream.

**Implementation plan and gate.** This plan does not change the current archived-data conclusion: `first_detected` remains `unavailable`, and it does not block Phase B’s evidence-first Replayer. When future simulation work is approved, perform the following bounded pilot before choosing a model:

1. Audit the live ROS graph (`rostopic info`, message definition, publisher package, clock source, and configuration hashes) for `detected_objects`, planner, controller, and actuator topics. Prove whether each is simulator ground truth or ADS output.
2. Record one short, reproducible cut-in run as a rosbag plus a signed/hashable manifest; archive both source streams separately.
3. Build a read-only adapter that exports a versioned `perception_evidence/v1` artifact and verifies timestamp ordering, coordinate frames, actor association, and hashes.
4. Make the Analyzer compute first detection, detection-to-plan delay, plan-to-command delay, and command-to-feedback delay only when the corresponding recorded events exist; otherwise emit `unavailable`.
5. Validate the adapter on a known visible actor and a deliberately absent/occluded actor. The test must prove that absence is preserved and that simulator ground truth cannot be promoted to a detection event.
6. Only after this baseline succeeds, decide whether an esmini ideal-sensor sensitivity model, calibrated PEM, or a full Autoware/CARLA/AWSIM pilot is worth the additional scope.

**Provisional recommendation:** use the existing simulator object stream as ground-truth reference and add provenance-preserving logging first. Do not use a generic deep-learning perception model, a VLM, or a literature latency value to manufacture historical perception evidence. A full sensor-plus-Autoware stack is valuable research infrastructure, but it is a later validation experiment rather than a prerequisite for the current visual-analysis thesis.

4. 怎麼假設接受到資訊是合理的? ISO

> **Research note — ISO can structure assumptions, but cannot convert an assumption into a recorded detection.** ISO 34502:2022 is a scenario-based safety-evaluation framework, not a sensor-performance specification. In the supplied [ISO 34502 PDF](ISO%2034502-2022.pdf), printed page 57 (PDF page 63/88) describes SOCA, a structured method for scenario-space analysis. Its Annex C provides a taxonomy of perception-related critical-scenario factors. These support a checklist of factors such as sensor field of view, target range/bearing, target type, illumination/weather, occlusion, road geometry, and surrounding traffic; they do **not** supply a valid first-detection timestamp or a single latency value for this trial. The [official ISO record](https://www.iso.org/standard/78951.html) also describes the standard as a scenario-based safety-evaluation framework for product development.
>
> A reasonable assumption must be stored as an explicit, replaceable profile: `profile_id`, sensor modality/mount/FOV/range, processing-latency distribution, vehicle dynamics inputs, source/rationale, applicability limits, version/hash, and sensitivity variants. It must be marked `assumed` in the capability card, Replayer, Dashboard, and LLM response. It must never populate `perception.first_detected`, whose value is `recorded` only when a timestamped sensor/tracker event exists.
>
> **Recommended decision rule:** use a derived geometric visibility opportunity to decide whether a case merits engineering review; use an assumed profile only to compare possible outcomes; require recorded perception events to confirm actual detection.

5. real time perception ，最低標準，要在幾秒內產生接收結果，產生結果與反應，動作。去調查 看模組 論文。

> **Research note — there is no single cross-ADS “minimum seconds” requirement.** The latency budget has to be tied to the ODD, speed, scenario, sensor suite, braking/steering authority, and safety concept, then verified by measurement. The latency research above supports recording the complete sensing-to-command chain; it does not justify importing one number into all scenarios.
>
> Regulation and consumer-test protocols can supply **test-specific comparison scenarios**, not an internal timing limit for this project. For example, [UN Regulation No. 152](https://unece.org/sites/default/files/2024-04/R152r2E.pdf) specifies particular AEBS requirements for M1/N1 car-to-car cases, including warning timing relative to emergency braking and a braking-demand requirement. [Euro NCAP’s AEB/LSS VRU protocol](https://www.euroncap.com/vru-protection/) specifies controlled assessment scenarios and measurements. Neither proves that the archived Ego system met those requirements, nor should either be represented as an ADS-wide perception deadline.
>
> **Future implementation requirement:** select a project-specific reaction-budget policy only after defining the ODD and manoeuvre. Record each stage timestamp, calculate its distribution across repeated runs, retain the software/configuration hash, and report violations against that declared policy. Until then, Phase A must report actual response time as `unavailable`.

### Theory support: trajectory-derived visibility opportunity (not detection)

The proposed line-of-sight analysis is a standard geometric/occlusion-analysis idea, but its claim must remain narrow: it establishes a **derived opportunity for geometric visibility**, not that a real sensor produced a detection. Occlusion-aware driving research explicitly models objects and regions blocked from an ego vehicle's field of view, including [Wang et al., *Potential risk assessment for safe driving of autonomous vehicles under occluded vision*](https://www.nature.com/articles/s41598-022-08810-z) and [Li et al., *Occlusion-aware on-road autonomous driving*](https://www.sciencedirect.com/science/article/pii/S0030402621009906). A trajectory-plus-ray-casting approach is also used for visibility assessment in [Gouda and El-Basyouny, *Evaluation of Traffic Sign Occlusion for Autonomous Vehicles Using Point Cloud Data*](https://journals.sagepub.com/doi/10.1177/03611981241255359). These works support the geometry/occlusion method; they do not validate perception for this project’s historical run.

> **Proposed derived procedure and evidence rule:**
>
> 1. Synchronize recorded ego and actor trajectories using their timestamps.
> 2. For every pre-collision frame, derive ego pose/heading, actor pose/heading and footprint, relative distance, bearing, closing speed, and time-to-collision.
> 3. Use a recorded map and recorded static/dynamic obstacle geometry to ray-cast from the ego reference point to the actor footprint.
> 4. Mark an interval as `clear_line_of_sight` only when the required geometry is available and no recorded obstacle intersects the ray. Save the trajectory/map/obstacle artifact IDs and SHA-256 hashes.
> 5. Report derived intervals and measurements such as first clear-line-of-sight time, range, bearing, and TTC; report missing three-dimensional geometry, actor dimensions, or occluder state as limitations.
>
> If the available archive has positions only, but lacks sufficiently reliable map/occluder/actor-footprint geometry, the result must be `visibility_opportunity: unavailable` rather than a guessed clear line of sight. If an assumed sensor FOV/range/latency profile is later applied, its result is a separate `assumed` sensitivity analysis and must not overwrite the derived geometry or the unavailable detection state.

肇責分析，可能要多讀一些論文，要調查完整一些。很難百分百判別肇責是誰

參考資料：

1. vscc 車輛安審 型式認證
2. 交通事故資料庫? NHTSA 事故報告

怎麼判斷肇責?

> **Research note — distinguish engineering evidence review from legal liability.** The project should not attempt to output legal fault allocation. VSCC/type approval concerns vehicle compliance and certification processes, not legal responsibility for a specific collision; see the [Taiwan vehicle-management overview](https://www.artc.org.tw/tw/technology/authorization/19). NHTSA crash reporting is useful background for which crash/context fields should be collected, but NHTSA explicitly cautions that incident reports can be incomplete or unverified; see the [Standing General Order data and limitations](https://www.nhtsa.gov/es/node/103486).
>
> The appropriate Phase-A output is an engineering review matrix: (1) collision and trajectory facts; (2) geometric visibility opportunity, if derivable; (3) recorded perception/tracking evidence, if available; (4) planner/control/actuator timing, if available; and (5) road, vehicle-capability, and right-of-way evidence. Missing evidence remains `unavailable`. Possible outputs are `insufficient_data`, `requires_engineering_review`, or a conditional capability result under stated assumptions — never “the ADS/other road user is legally responsible.”
>
> A derived clear line of sight can justify the question “should perception logs be reviewed?” It cannot establish “the ADS saw the actor,” “the ADS should certainly have detected the actor,” or “the ADS caused the crash.” Such a conclusion needs timestamped sensor, tracker, planner, control, vehicle, and road-context evidence, plus a separate legal analysis outside this research system.

或許可以參考醫療、財務金融? 有時間序列分析、預測。或是因果關係分析。

視覺化， human AI 合作。是否能夠放到目前應用情境底下。

功能怎麼讓AI熟悉，推薦給user，怎麼教導agent? 讓agent熟悉學會我的介面?

理論或架構上的創新，要能夠闡述。

在調查過程中要思考這些，結合成論文重點。

---

## Phase-A implementation update — 2026-11-07

**This is an implementation decision, not a claim about the historical trial.**
The Analyzer now creates a separate `visibility-evidence/v1` artifact
(`processed/visibility.yaml`) alongside `action.yaml` and `capability.yaml`.
It implements the evidence boundary discussed above:

1. `perception.first_detected` remains `unavailable` unless a timestamped detector
   or tracker event is recorded by the evaluated pipeline.
2. `fov_range_opportunity` can be **derived** only from a versioned perception
   profile that declares FOV/range values, units, status, source, rationale,
   applicability limits, and a content hash.
3. `visibility_opportunity` can be **derived** only when complete map/static/dynamic
   occluder geometry is supplied. With positions alone, it is `unavailable`; the
   system does not guess clear line of sight.
4. Profile latency is an `assumed` or `configured` sensitivity input. It is stored
   separately, cannot become measured response delay, and cannot change the
   deterministic primary capability verdict.

For the present archived case, all three visibility fields are correctly
`unavailable`: there is no recorded perception event, no versioned profile, and no
complete occluder geometry. This is an intended, useful result. It gives the later
Replayer, Q&A, and agent a precise answer: “the trajectory supports motion facts,
but it does not support a claim that the ADS detected the actor.”

The next permitted research/data task is an approved A3 capture pilot, not a
historical backfill: log separate `simulator_ground_truth`, `ads_perception`,
`planner_event`, `control_event`, and `actuator_feedback` streams under one run ID
with topic/publisher/configuration hashes. Only then can the project compute actual
detection and response intervals. Until that occurs, the implementation can still
use A1/A2 for evidence-first Replayer annotations and uncertainty-aware Q&A, but it
must not deliver a legal responsibility conclusion.
