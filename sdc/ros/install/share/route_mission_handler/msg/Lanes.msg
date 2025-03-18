int32 type
int32 NORMAL=0
int32 SPLIT_LEFT=1
int32 SPLIT_RIGHT=2
int32 MERGE_TO_RIGHT=3
int32 MERGE_TO_LEFT=4
int32 TOBE_MERGED=5
int32 SPLIT_STRAIGHT=6

int32 id
bool isTurn
bool direction
int32 laneno
int32[] nexts
int32[] roadLineIds
Waypoints[] points
int32 max_speed_limit
int32 roadType
