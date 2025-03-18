#!/usr/bin/env python2

from diagnostic_msgs.msg import DiagnosticStatus
from std_msgs.msg import Bool, UInt8
import rospy
from diagnostic import *
from state import *
from topics import *
from system import *

class Node:
    def __init__(self):
        rospy.init_node("diagnostic")
        self.publisher = rospy.Publisher('/ready_to_drive', Bool, queue_size=1)
        self.status_publisher = rospy.Publisher(
            '/diagnostic/status', UInt8, queue_size=1)

        self.major_topic_updater = MyUpdater('/diagnostic/major_topics')
        self.major_topic_updater.setHardwareID("none")
        self.minor_topic_updater = MyUpdater('/diagnostic/minor_topics')
        self.minor_topic_updater.setHardwareID("none")
        self.topics = Topics(
            self.major_topic_updater, self.minor_topic_updater)
        self.major_task_updater = MyUpdater('/diagnostic/major_system')
        self.major_task_updater.setHardwareID("none")
        self.minor_task_updater = MyUpdater('/diagnostic/minor_system')
        self.minor_task_updater.setHardwareID("none")
        system = Sysetm(self.major_task_updater, self.minor_task_updater)

    def checkTopics(self):
        self.major_topic_updater.update()
        self.minor_topic_updater.update()
        valid = True
        for status in self.major_topic_updater.status_list:
            if status.level == DiagnosticStatus.ERROR:
                rospy.loginfo("Name: '%s', status %i: '%s'" %
                    (status.name, status.level, status.message))
                valid = False
        return valid

    def checkSystem(self):
        self.major_task_updater.update()
        self.minor_task_updater.update()
        valid = True
        for status in self.major_task_updater.status_list:
            if status.level == DiagnosticStatus.ERROR:
                rospy.loginfo("Name: '%s', status %i: '%s'" %
                    (status.name, status.level, status.message))
                valid = False
        return valid

    def run(self):
        state = DisengageState()
        ready_to_drive = Bool()
        ready_to_drive_status = UInt8()
        while not rospy.is_shutdown():
            rospy.sleep(0.1)
            check_topic = self.checkTopics()
            check_system = self.checkSystem()
            state = state.on_event(check_topic and check_system)
            ready_to_drive_status.data = state()
            self.status_publisher.publish(ready_to_drive_status)
            ready_to_drive.data = (state() is SelfDriveStatus.ENGAGE or
                state() is SelfDriveStatus.ON_DISENGAGING)
            self.publisher.publish(ready_to_drive)

def main():
    node = Node()
    node.run()

if __name__ == "__main__":
    main()
