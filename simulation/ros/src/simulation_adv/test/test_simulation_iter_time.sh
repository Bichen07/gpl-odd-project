#!/bin/bash

source /project/mmsl_simulation/devel/setup.bash



roslaunch simulation_adv run_by_tick.launch &



sleep 3


rosservice call /simulation/agent_srv/create '{"agentId": 'ego1/ego', "objectClassId": '', "pose": {"position": {"x": -209.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'ego2/ego', "objectClassId": '', "pose": {"position": {"x": -219.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'ego3/ego', "objectClassId": '', "pose": {"position": {"x": -229.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'ego4/ego', "objectClassId": '', "pose": {"position": {"x": -239.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'ego5/ego', "objectClassId": '', "pose": {"position": {"x": -249.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'ego6/ego', "objectClassId": '', "pose": {"position": {"x": -259.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'ego7/ego', "objectClassId": '', "pose": {"position": {"x": -269.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'ego8/ego', "objectClassId": '', "pose": {"position": {"x": -279.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'ego9/ego', "objectClassId": '', "pose": {"position": {"x": -289.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'ego10/ego', "objectClassId": '', "pose": {"position": {"x": -299.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &



rosservice call /simulation/agent_srv/create '{"agentId": 'agent1', "objectClassId": '', "pose": {"position": {"x": -109.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2', "objectClassId": '', "pose": {"position": {"x": -119.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3', "objectClassId": '', "pose": {"position": {"x": -129.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4', "objectClassId": '', "pose": {"position": {"x": -139.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5', "objectClassId": '', "pose": {"position": {"x": -149.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6', "objectClassId": '', "pose": {"position": {"x": -159.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7', "objectClassId": '', "pose": {"position": {"x": -169.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8', "objectClassId": '', "pose": {"position": {"x": -179.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9', "objectClassId": '', "pose": {"position": {"x": -189.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10', "objectClassId": '', "pose": {"position": {"x": -199.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &


sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent1-2', "objectClassId": '', "pose": {"position": {"x": -109.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2-2', "objectClassId": '', "pose": {"position": {"x": -119.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3-2', "objectClassId": '', "pose": {"position": {"x": -129.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4-2', "objectClassId": '', "pose": {"position": {"x": -139.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5-2', "objectClassId": '', "pose": {"position": {"x": -149.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6-2', "objectClassId": '', "pose": {"position": {"x": -159.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7-2', "objectClassId": '', "pose": {"position": {"x": -169.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8-2', "objectClassId": '', "pose": {"position": {"x": -179.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9-2', "objectClassId": '', "pose": {"position": {"x": -189.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10-2', "objectClassId": '', "pose": {"position": {"x": -199.923, "y": 79.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &


sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent1-3', "objectClassId": '', "pose": {"position": {"x": -109.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2-3', "objectClassId": '', "pose": {"position": {"x": -119.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3-3', "objectClassId": '', "pose": {"position": {"x": -129.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4-3', "objectClassId": '', "pose": {"position": {"x": -139.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5-3', "objectClassId": '', "pose": {"position": {"x": -149.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6-3', "objectClassId": '', "pose": {"position": {"x": -159.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7-3', "objectClassId": '', "pose": {"position": {"x": -169.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8-3', "objectClassId": '', "pose": {"position": {"x": -179.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9-3', "objectClassId": '', "pose": {"position": {"x": -189.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10-3', "objectClassId": '', "pose": {"position": {"x": -199.923, "y": 89.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &


sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent1-4', "objectClassId": '', "pose": {"position": {"x": -109.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2-4', "objectClassId": '', "pose": {"position": {"x": -119.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3-4', "objectClassId": '', "pose": {"position": {"x": -129.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4-4', "objectClassId": '', "pose": {"position": {"x": -139.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5-4', "objectClassId": '', "pose": {"position": {"x": -149.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6-4', "objectClassId": '', "pose": {"position": {"x": -159.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7-4', "objectClassId": '', "pose": {"position": {"x": -169.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8-4', "objectClassId": '', "pose": {"position": {"x": -179.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9-4', "objectClassId": '', "pose": {"position": {"x": -189.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10-4', "objectClassId": '', "pose": {"position": {"x": -199.923, "y": 99.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &


sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent1-5', "objectClassId": '', "pose": {"position": {"x": -109.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2-5', "objectClassId": '', "pose": {"position": {"x": -119.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3-5', "objectClassId": '', "pose": {"position": {"x": -129.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4-5', "objectClassId": '', "pose": {"position": {"x": -139.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5-5', "objectClassId": '', "pose": {"position": {"x": -149.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6-5', "objectClassId": '', "pose": {"position": {"x": -159.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7-5', "objectClassId": '', "pose": {"position": {"x": -169.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8-5', "objectClassId": '', "pose": {"position": {"x": -179.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9-5', "objectClassId": '', "pose": {"position": {"x": -189.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10-5', "objectClassId": '', "pose": {"position": {"x": -199.923, "y": 109.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &


sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent1-6', "objectClassId": '', "pose": {"position": {"x": -209.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2-6', "objectClassId": '', "pose": {"position": {"x": -219.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3-6', "objectClassId": '', "pose": {"position": {"x": -229.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4-6', "objectClassId": '', "pose": {"position": {"x": -239.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5-6', "objectClassId": '', "pose": {"position": {"x": -249.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6-6', "objectClassId": '', "pose": {"position": {"x": -259.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7-6', "objectClassId": '', "pose": {"position": {"x": -269.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8-6', "objectClassId": '', "pose": {"position": {"x": -279.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9-6', "objectClassId": '', "pose": {"position": {"x": -289.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10-6', "objectClassId": '', "pose": {"position": {"x": -299.923, "y": 119.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &


sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent1-7', "objectClassId": '', "pose": {"position": {"x": -209.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2-7', "objectClassId": '', "pose": {"position": {"x": -219.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3-7', "objectClassId": '', "pose": {"position": {"x": -229.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4-7', "objectClassId": '', "pose": {"position": {"x": -239.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5-7', "objectClassId": '', "pose": {"position": {"x": -249.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6-7', "objectClassId": '', "pose": {"position": {"x": -259.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7-7', "objectClassId": '', "pose": {"position": {"x": -269.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8-7', "objectClassId": '', "pose": {"position": {"x": -279.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9-7', "objectClassId": '', "pose": {"position": {"x": -289.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10-7', "objectClassId": '', "pose": {"position": {"x": -299.923, "y": 129.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &


sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent1-8', "objectClassId": '', "pose": {"position": {"x": -209.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2-8', "objectClassId": '', "pose": {"position": {"x": -219.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3-8', "objectClassId": '', "pose": {"position": {"x": -229.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4-8', "objectClassId": '', "pose": {"position": {"x": -239.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5-8', "objectClassId": '', "pose": {"position": {"x": -249.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6-8', "objectClassId": '', "pose": {"position": {"x": -259.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7-8', "objectClassId": '', "pose": {"position": {"x": -269.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8-8', "objectClassId": '', "pose": {"position": {"x": -279.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9-8', "objectClassId": '', "pose": {"position": {"x": -289.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10-8', "objectClassId": '', "pose": {"position": {"x": -299.923, "y": 139.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &


sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent1-9', "objectClassId": '', "pose": {"position": {"x": -209.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2-9', "objectClassId": '', "pose": {"position": {"x": -219.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3-9', "objectClassId": '', "pose": {"position": {"x": -229.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4-9', "objectClassId": '', "pose": {"position": {"x": -239.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5-9', "objectClassId": '', "pose": {"position": {"x": -249.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6-9', "objectClassId": '', "pose": {"position": {"x": -259.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7-9', "objectClassId": '', "pose": {"position": {"x": -269.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8-9', "objectClassId": '', "pose": {"position": {"x": -279.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9-9', "objectClassId": '', "pose": {"position": {"x": -289.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10-9', "objectClassId": '', "pose": {"position": {"x": -299.923, "y": 149.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &


sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent1-10', "objectClassId": '', "pose": {"position": {"x": -209.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent2-10', "objectClassId": '', "pose": {"position": {"x": -219.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent3-10', "objectClassId": '', "pose": {"position": {"x": -229.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent4-10', "objectClassId": '', "pose": {"position": {"x": -239.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.01

rosservice call /simulation/agent_srv/create '{"agentId": 'agent5-10', "objectClassId": '', "pose": {"position": {"x": -249.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent6-10', "objectClassId": '', "pose": {"position": {"x": -259.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep  0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent7-10', "objectClassId": '', "pose": {"position": {"x": -269.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent8-10', "objectClassId": '', "pose": {"position": {"x": -279.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent9-10', "objectClassId": '', "pose": {"position": {"x": -289.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &

sleep 0.002

rosservice call /simulation/agent_srv/create '{"agentId": 'agent10-10', "objectClassId": '', "pose": {"position": {"x": -299.923, "y": 159.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}' &



sleep 2

rosrun simulation_adv trigger_maker

pkill ros