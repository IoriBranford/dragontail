<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.11" tiledversion="1.11.0" name="cavedoor2-diagonal" tilewidth="64" tileheight="128" tilecount="3" columns="3" objectalignment="topright">
 <image source="cavedoor2-diagonal.png" width="192" height="128"/>
 <tile id="1" type="bandit-cave-door">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="64">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
    <polygon points="0,0 64,64 80,64 16,0"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2">
  <properties>
   <property name="name" value="collapse"/>
  </properties>
 </tile>
</tileset>
