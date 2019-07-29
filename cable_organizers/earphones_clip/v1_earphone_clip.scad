/*
  I hate it to undo my cables..
*/


QUALITY = 60;
THICKNESS = 2;
RADIUS = 20;
CUT = 14;

module clip(){
  hull(){
    cylinder(h=THICKNESS, r=RADIUS, $fn=QUALITY);
    translate([60,0,0])cylinder(h=THICKNESS, r=RADIUS, $fn=QUALITY);
  }
}

module cutout(){
  color("red")translate([30,40,0])cylinder(h=THICKNESS, r=RADIUS+CUT, $fn=QUALITY);
  color("red")translate([30,-40,0])cylinder(h=THICKNESS, r=RADIUS+CUT, $fn=QUALITY);
  color("red")translate([-20,0,0])cylinder(h=THICKNESS, r=RADIUS-CUT, $fn=QUALITY);
  color("red")translate([-5,0,0])cylinder(h=THICKNESS, r=RADIUS-8, $fn=QUALITY);
  color("red")translate([80,0,0])cylinder(h=THICKNESS, r=RADIUS-CUT, $fn=QUALITY);
  color("red")translate([65,0,0])cylinder(h=THICKNESS, r=RADIUS-8, $fn=QUALITY);
}

// RENDER
module render () {
  difference(){
    clip();
    cutout();
  }
}
render();
