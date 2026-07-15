<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.11" tiledversion="1.12.2" name="gamepad-buttons" tilewidth="16" tileheight="16" tilecount="100" columns="20">
 <editorsettings>
  <export target="gamepad-buttons.lua" format="lua"/>
 </editorsettings>
 <properties>
  <property name="blanktilecount" type="int" value="42"/>
  <property name="blanktiles" value="10,11,12,13,14,15,61,62,63,64,65,66,67,68,69,70,72,73,74,75,76,77,78,79,81,82,83,84,85,86,87,88,89,90,92,93,94,95,96,97,98,99"/>
 </properties>
 <image source="gamepad-buttons.png" width="320" height="80"/>
 <tile id="9">
  <animation>
   <frame tileid="5" duration="100"/>
   <frame tileid="7" duration="100"/>
   <frame tileid="3" duration="100"/>
   <frame tileid="1" duration="100"/>
  </animation>
 </tile>
 <tile id="60">
  <animation>
   <frame tileid="20" duration="100"/>
   <frame tileid="21" duration="100"/>
  </animation>
 </tile>
 <tile id="71">
  <animation>
   <frame tileid="30" duration="100"/>
   <frame tileid="31" duration="900"/>
  </animation>
 </tile>
 <tile id="80">
  <animation>
   <frame tileid="40" duration="100"/>
   <frame tileid="41" duration="100"/>
  </animation>
 </tile>
 <tile id="91">
  <animation>
   <frame tileid="50" duration="100"/>
   <frame tileid="51" duration="900"/>
  </animation>
 </tile>
</tileset>
