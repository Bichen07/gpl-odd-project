uint64 id
int32 type
geometry_msgs/Point position
float64 heading

int32 INVALID = 0       # invalid value
int32 UNKNOWN = 1       # unknown value
int32 TRAFFIC_SIGN = 2  # traffic sign (e.g. yield, stop)
int32 TRAFFIC_LIGHT = 3 # traffic light
int32 POLE = 4          # pole (e.g. street lamp)
int32 GUIDE_POST = 5    # guide post
int32 TREE = 6          # a tree
int32 STREET_LAMP = 7   # street lamp
int32 POSTBOX = 8       # post box
int32 MANHOLE = 9       # a manhole on the street
int32 POWERCABINET = 10 # electrical power box
int32 FIRE_HYDRANT = 11 # fire hydrant
int32 BOLLARD = 12      # bollard (different/bigger to GUIDE_POST and POLE)
int32 OTHER = 13        # none of the above
