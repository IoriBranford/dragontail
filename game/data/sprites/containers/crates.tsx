<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.11" tiledversion="1.11.0" name="crates" tilewidth="32" tileheight="48" tilecount="6" columns="3" objectalignment="bottom">
 <tileoffset x="0" y="8"/>
 <image source="crates.png" width="96" height="96"/>
 <tile id="0">
  <objectgroup draworder="index" id="2">
   <object id="1" x="16" y="48">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
    <polygon points="0,0 10,-6 0,-12 -10,-6"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1">
  <objectgroup>
   <object id="1" x="16" y="48">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
    <polygon points="0,0 16,-8 0,-16 -16,-8"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="container-crate-tall">
  <objectgroup draworder="index" id="2">
   <object id="1" x="16" y="48">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
    <polygon points="0,0 16,-8 0,-16 -16,-8"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5">
  <properties>
   <property name="name" value="collapse"/>
  </properties>
 </tile>
</tileset>
