import rospy

def TryToCallAfterFailed(tag, max_attempt, sleep):
    def function_wrapper(func):
        def wrap(self, *args, **kwargs):
            attempt = 0
            while True:
                try:
                    result = func(self, *args, **kwargs)
                    if attempt > 0:
                        rospy.loginfo("[TryUntillSuccess - {}] function called {} success after {} attempts."\
                            "".format(tag, func.__name__, attempt+1))
                    return result
                except Exception as e:
                    if attempt >= max_attempt:
                        raise e
                    attempt += 1
                    rospy.logwarn("[TryUntillSuccess - {}] Got exception \"{}\" "\
                        "while calling function \"{}\" with args \"{}\" and kwargs \"{}\". "\
                        "will keep trying in {} sec. (attempt {}/{})"\
                        "".format(tag, e, func.__name__, args, kwargs, sleep, attempt, max_attempt))
                    rospy.sleep(sleep)
        return wrap
    return function_wrapper
