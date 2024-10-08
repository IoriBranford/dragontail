<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.11" tiledversion="1.11.0" name="bandits" tilewidth="64" tileheight="64" tilecount="24" columns="4" objectalignment="bottom">
 <tileoffset x="0" y="8"/>
 <image source="bandits.png" width="256" height="384"/>
 <tile id="0" type="bandit-dagger"/>
 <tile id="1" type="bandit-dagger"/>
 <tile id="2" type="bandit-dagger"/>
 <tile id="3" type="bandit-dagger"/>
 <tile id="4" type="bandit-spear"/>
 <tile id="5" type="bandit-spear"/>
 <tile id="6" type="bandit-spear"/>
 <tile id="7" type="bandit-spear"/>
 <tile id="8" type="bandit-bow"/>
 <tile id="9" type="bandit-bow"/>
 <tile id="10" type="bandit-bow"/>
 <tile id="11" type="bandit-bow"/>
 <tile id="12" type="bandit-sling"/>
 <tile id="13" type="bandit-sling"/>
 <tile id="14" type="bandit-sling"/>
 <tile id="15" type="bandit-sling"/>
 <tile id="16" type="bandit-boss"/>
 <tile id="17" type="bandit-boss"/>
 <tile id="18" type="bandit-boss"/>
 <tile id="19" type="bandit-boss"/>
 <tile id="20" type="bandit-cave-door">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="48" width="64" height="16">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
    <polygon points="0,0 0,16 64,16 64,0"/>
   </object>
  </objectgroup>
 </tile>
</tileset>
