cmake_minimum_required(VERSION 2.8)
project("Box2D")
add_compile_options(-std=c++11)

set(collision_srcs
	Collision/Shapes/b2ChainShape.cpp
	Collision/Shapes/b2CircleShape.cpp
	Collision/Shapes/b2EdgeShape.cpp
	Collision/Shapes/b2PolygonShape.cpp
	Collision/b2BroadPhase.cpp
	Collision/b2CollideCircle.cpp
	Collision/b2CollideEdge.cpp
	Collision/b2CollidePolygon.cpp
	Collision/b2Collision.cpp
	Collision/b2Distance.cpp
	Collision/b2DynamicTree.cpp
	Collision/b2TimeOfImpact.cpp
)

set(common_srcs
	Common/b2BlockAllocator.cpp
	Common/b2Draw.cpp
	Common/b2Math.cpp
	Common/b2Settings.cpp
	Common/b2StackAllocator.cpp
	Common/b2Timer.cpp
)

set(dynamics_srcs
	Dynamics/Contacts/b2ChainAndCircleContact.cpp
	Dynamics/Contacts/b2ChainAndPolygonContact.cpp
	Dynamics/Contacts/b2CircleContact.cpp
	Dynamics/Contacts/b2Contact.cpp
	Dynamics/Contacts/b2ContactSolver.cpp
	Dynamics/Contacts/b2EdgeAndCircleContact.cpp
	Dynamics/Contacts/b2EdgeAndPolygonContact.cpp
	Dynamics/Contacts/b2PolygonAndCircleContact.cpp
	Dynamics/Contacts/b2PolygonContact.cpp
	Dynamics/Joints/b2DistanceJoint.cpp
	Dynamics/Joints/b2FrictionJoint.cpp
	Dynamics/Joints/b2GearJoint.cpp
	Dynamics/Joints/b2Joint.cpp
	Dynamics/Joints/b2MotorJoint.cpp
	Dynamics/Joints/b2MouseJoint.cpp
	Dynamics/Joints/b2PrismaticJoint.cpp
	Dynamics/Joints/b2PulleyJoint.cpp
	Dynamics/Joints/b2RevoluteJoint.cpp
	Dynamics/Joints/b2RopeJoint.cpp
	Dynamics/Joints/b2WeldJoint.cpp
	Dynamics/Joints/b2WheelJoint.cpp
	Dynamics/b2Body.cpp
	Dynamics/b2ContactManager.cpp
	Dynamics/b2Fixture.cpp
	Dynamics/b2Island.cpp
	Dynamics/b2WorldCallbacks.cpp
	Dynamics/b2World.cpp
)

set(rope_src
	Rope/b2Rope.cpp
)

add_library(${PROJECT_NAME} STATIC
	${collision_srcs}
	${common_srcs}
	${dynamics_srcs}
	${rope_src}
	${box2d_hdr}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/..
)
