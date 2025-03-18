# Resolve Warning Messages of Net File

## Introduction
* After converting map from .xodr format to net file by netconvert, i.e. `$ netconvert --opendrive [map_name].xodr -o [map_name].net.xml`, some warnings might popped up in the terminal.  If these warnings keep showing in netedit, they might cause connection errors or strange behaviors, so it is recommended to fix them in netedit.  In this document, there will be case studies on how to fix these warnings.

### Case Study: itri_68_nanliao

#### Warning Messages
* Popped up warning messages of netconvert after running `$ netconvert --opendrive itri_68_nanliao.xodr -o itri_68_nanliao.net.xml`
![itri_68_nanliao warning messages](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netconvert-warning_messages.png)
* Popped up warning messages after running `$ netedit itri_68_nanliao.net.xml` and press **F5** in netedit
![itri_68_nanliao warning messages](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning_messages.png)

#### Solutions
* Note: It is highly recommended to save and reopen netedit every time when a warning is resolved.
##### Warning: Found sharp turn with radius 0.12 at the start of edge '-20.0.00'.
1. Locate edge -20.0.00 by "Locate" -> "Locate Edges" or shift-E
![itri_68_nanliao warning1](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning1.png)
    * It seems like the start of edge -20.0.00 is folded.
2. In inspect mode (shortcut I), right click on the edge -> edge operations -> Smooth edge, so is edge 20.0.00
3. However, we can clearly see that the edge -20.0.00 and edge 20.0.00 are not correctly linked to the right-side edges. we may need to manually crop both edge and connect them.
![itri_68_nanliao warning1-2](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning1-2.png)
4. Select a point that on edge -20.0.00 that is near to the broken junction and right click -> edge operations -> split edge here.  We can see a new junction and new splitted edge.
![itri_68_nanliao warning1-3](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning1-3.png)
![itri_68_nanliao warning1-4](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning1-4.png)
5. In delete mode (shortcut D), delete the new splitted edge, so as the edge 20.0.00 and the 2 edge in the other side of the original junction.
![itri_68_nanliao warning1-5](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning1-5.png)
6. In edge mode (shortcut E), connect junctions by directions.  Make sure the direction is connected right, that is, lane of forward-direction linked to forward-direction and vice versa.  The click order also has to follow the direction.
![itri_68_nanliao warning1-6](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning1-6.png)
7. In inspect mode (shortcut I), select new edges and modify "numLanes" in the left-side bar to 2.
8. Press F5 to see if they were connected correctly.  It may takes serveral times to connect and reconnect.
![itri_68_nanliao warning1-7](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning1-7.png)

##### Warning: Found sharp turn with radius 6.08 at the start of edge '-75.0.00'.
1. Find the edge -75.0.00 via shift-E, the start indicate the end that vehicles enter this edge.
2. Comparing to the google map, it seems like it is a interchange and it is not correctly connected.
![itri_68_nanliao warning2-1](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning2-1.png)
3. Right click on the edge -75.0.00, select "reset edge end points"
![itri_68_nanliao warning2-2](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning2-2.png)
4. Press F5 and the interchage is correctly connected.
![itri_68_nanliao warning2-3](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning2-3.png)
5. Check if the inter-connection of juction is correctly connected in connection mode (shortcut C)
![itri_68_nanliao warning2-4](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning2-4.png)


##### Warning: Found sharp turn with radius 6.42 at the end of edge '-75.0.00'
1. Find the edge -75.0.00 via shift-E
2. The sharp turn in the warning message is not obviously shown in the net, just split a little slice of edge and smooth it.
![itri_68_nanliao warning3-1](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning3-1.png)


##### Warning: Found sharp turn with radius 0.29 at the start of edge '-93.0.00'.
1. Find the edge -93.0.00 via shift-E
![itri_68_nanliao warning4-1](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning4-1.png)
2. It is clear that the start of edge -93.0.00 is folded, try to use smooth edge but it changes the road geometry dramatically.
![itri_68_nanliao warning4-2](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning4-2.png)
3. Instead of dirctly smooth the whole edge, we split a little slice and smooth it.  Then another problem revealed that the start of edge -93.0.00 is not connected to previous edge.
![itri_68_nanliao warning4-3](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning4-3.png)

4. So again, we split both side and both diretion then reconnect.
![itri_68_nanliao warning4-4](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning4-4.png)
![itri_68_nanliao warning4-5](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning4-5.png)

##### Warning: Shape for junction '258' has distance 64.93 to its given position.
1. Find the junction 258 via shift-J and it seems terrible.
![itri_68_nanliao warning5-1](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning5-1.png)
2. In inspect mode (shortcut I), right click on the junction -> reset junction shape.  It seems like the left red point is junctino 258.  So far, there is no way we can 100 percent recover the actual road geometry, we can only do our best to prevent SUMO agents to stuck at some disconnected edges.
![itri_68_nanliao warning5-2](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning5-2.png)
3. In inspect mode (shortcut I), right click on junction 258 -> Split junction (6 end points) and press F5
![itri_68_nanliao warning5-3](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning5-3.png)
4. Reconnect junctions in edge mode (shortcut E) and smooth newly added edges in inspect mode (shortcut I).
![itri_68_nanliao warning5-4](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning5-4.png)

##### Warning: Lane '1.0.00_0' is not connected from any incoming edge at junction '215'.
1. In connection mode (shortcut C), we can see that there is no internal-connection in junction 215 that is linked with lane 1.0.00_0 (the bottom-most lane)
![itri_68_nanliao warning6-1](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning6-1.png)
2. Connect the lane in order and click on OK in the left-side bar.
![itri_68_nanliao warning6-2](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning6-2.png)
![itri_68_nanliao warning6-3](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning6-3.png)


##### Warning: Connection '76.0.00_1->-76.0.00_1' is only 0.08m short.
1. It seems like the edge 76.0.00 is too short, just simply delet the red curcle in delete mode (shortcut D).
![itri_68_nanliao warning6-3](../images/resolve_warning_messages_of_net_file/itri_68_nanliao-netedit-warning6-3.png)

