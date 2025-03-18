# demand_modelling

## Brief
* After SUMO .net.xml file was generated and checked, it is important to generate traffic flows. 
* There exists many ways to generate traffic flows (known as demand modelling in SUMO document), most of them were documented in the official documents.
* This file demonstrates servral ways to generate traffic flows to satisfied different demands in different scenario.
* At the end of each demonstration, there should be a .rou.xml file that is generated to be used in .sumocfg configuration.

## Resources
* [Introduction to demand modelling in SUMO - SUMO Documentation](https://sumo.dlr.de/docs/Demand/Introduction_to_demand_modelling_in_SUMO.html)
* [Application manuals](https://sumo.dlr.de/docs/index.html#application_manuals)

## Demand Modelling Examples

### Demand simple vehicles by flow in netedit
* [Official Document](https://sumo.dlr.de/docs/Netedit/elementsDemand.html#flow)
    * Save the demand by "File" -> "Demand Elements" -> "Save demand elements as". Name the file as `[DEMAND_FILE_NAME].rou.xml` and save.
* Take highway scenario for example, the .rou.xml file looks like the following block:
    ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <routes xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://sumo.dlr.de/xsd/routes_file.xsd">
            <flow id="flow_0" begin="0.00" departSpeed="22.20" arrivalSpeed="22.20" from="-21.0.00" to="-17.0.00" end="3600.00" probability="0.20" type="carTypeDistribution"/>
            <flow id="flow_1" begin="0.00" departSpeed="22.20" arrivalSpeed="22.20" from="-21.0.00" to="-30.0.00" end="3600.00" probability="0.06" type="carTypeDistribution"/>
        </routes>
    ```

### Demand vehicles by turning counts
- This instruction demonstrates how to generate vehicle flows by **turning count** of a single intersection.
- First we define a turn file.
    1. Define turn count file. e.g. shuinan.turns.xml
        ```xml
        <edgeRelations>
           <interval id="h1" begin="0.0" end="3600.0">
               <edgeRelation from="-11.0.00" to="14.0.00" count="3" type="carTypeDistribution"/>
               <edgeRelation from="-11.0.00" to="14.0.00" count="4" type="motorcycleTypeDistribution"/>
               <edgeRelation from="-11.0.00" to="-24.0.00" count="178" type="carTypeDistribution"/>
               <edgeRelation from="-11.0.00" to="-24.0.00" count="178" type="motorcycleTypeDistribution"/>
               <edgeRelation from="-11.0.00" to="-0.0.00" count="18" type="carTypeDistribution"/>
               <edgeRelation from="-11.0.00" to="-0.0.00" count="18" type="motorcycleTypeDistribution"/>

               <edgeRelation from="-14.0.00" to="-24.0.00" count="38" type="carTypeDistribution"/>
               <edgeRelation from="-14.0.00" to="-24.0.00" count="38" type="motorcycleTypeDistribution"/>
               <edgeRelation from="-14.0.00" to="-0.0.00" count="260" type="carTypeDistribution"/>
               <edgeRelation from="-14.0.00" to="-0.0.00" count="260" type="motorcycleTypeDistribution"/>
               <edgeRelation from="-14.0.00" to="11.0.00" count="2" type="carTypeDistribution"/>
               <edgeRelation from="-14.0.00" to="11.0.00" count="2" type="motorcycleTypeDistribution"/>
               
               <edgeRelation from="24.0.00" to="-0.0.00" count="24" type="carTypeDistribution"/>
               <edgeRelation from="24.0.00" to="-0.0.00" count="24" type="motorcycleTypeDistribution"/>
               <edgeRelation from="24.0.00" to="11.0.00" count="90" type="carTypeDistribution"/>
               <edgeRelation from="24.0.00" to="11.0.00" count="90" type="motorcycleTypeDistribution"/>
               <edgeRelation from="24.0.00" to="14.0.00" count="12" type="carTypeDistribution"/>
               <edgeRelation from="24.0.00" to="14.0.00" count="12" type="motorcycleTypeDistribution"/>
               
               <edgeRelation from="0.0.00" to="11.0.00" count="40" type="carTypeDistribution"/>
               <edgeRelation from="0.0.00" to="11.0.00" count="40" type="motorcycleTypeDistribution"/>
               <edgeRelation from="0.0.00" to="14.0.00" count="253" type="carTypeDistribution"/>
               <edgeRelation from="0.0.00" to="14.0.00" count="253" type="motorcycleTypeDistribution"/>
               <edgeRelation from="0.0.00" to="-24.0.00" count="186" type="carTypeDistribution"/>
               <edgeRelation from="0.0.00" to="-24.0.00" count="186" type="motorcycleTypeDistribution"/>          
           </interval>
        </edgeRelations>
        ```
    2. Then we define vehicles, which should already exist as [sumo_cosimulation/data/vehicles.add.xml](sumo_cosimulation/data/vehicles.add.xml)
    3. We are using [duarouter](https://sumo.dlr.de/docs/duarouter.html) to generate from .flow.xml file to .rou.xml file. So first we convert .turns.xml file to .flow.xml file.
        - e.g. `[sumo_cosimulation/data/shuinan] $ python ../../script/generate_by_turn_count.py -n shuinan.net.xml -t shuinan.turns.xml -v ../vehicles.add.xml -f shuinan.flow.xml -o shuinan.rou.xml --begin 0 --end 3600 --count-param 1`
        - This will generate a new file named shuinan.flow.xml
    4. The script calls duarouter afterward.
        - This will generate 2 new files shuinan.rou.xml and shuinan.rou.alt.xml


### Demand vehicles by TAZ to TAZ (traffic assignment zone)
- This instruction demonstrates how to generate vehicle flows by **TAZ to TAZ** fassion.
- TAZ is a zone that contains one or more edge(s).
- First we generate TAZ file in netedit.
    - `$ netedit [NET_FILE_NAME].net.xml`
    - Use TAZ mode. (shortcut z)
        1. Click "Start drawing" button (or Enter).
        2. Assign points of a polygon that contains
        3. Click "Stop drawing" button (or Enter), the program will connect the last point to the first point and form a polygon.
        4. Click on the blue edge of the polygon, some lane will display in purple and some in grey. The purple-colored lanes are lanes that belongs to the TAZ. Click on grey lanes to add lanes to the TAZ and vice versa.
        5. To save the defined TAZs, select "File" -> "Additionals and Shapes" -> "Save additionals as". Name the file as `[TAZ_FILE_NAME].add.xml` and save.
    - To load TAZ file in netedit, run the command `$ netedit -s [NET_FILE_NAME].net.xml -a [TAZ_FILE_NAME].add.xml`
- Then we generate flow file
- TO BE DONE