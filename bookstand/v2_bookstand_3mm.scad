/*
	some info
*/

//	variables
QUALITY = 100;
RADIUS = 2;
MULTI = 1;
THICKNESS = 3;

// tests
module arm(){
	difference(){
	union(){
		color("green")hull(){
			translate([0,0,0])cylinder(h=THICKNESS, r=(RADIUS+MULTI), $fn=QUALITY);
			translate([90,0,0])cylinder(h=THICKNESS, r=RADIUS, $fn=QUALITY);
			translate([120,15,0])cylinder(h=THICKNESS, r=RADIUS, $fn=QUALITY);
		}
		color("cyan")hull(){
			translate([3,10,0])cylinder(h=THICKNESS, r=RADIUS, $fn=QUALITY);
			translate([0,0,0])cylinder(h=THICKNESS, r=(RADIUS+MULTI), $fn=QUALITY);
		}
	}
	color("red")translate([80,2,(THICKNESS-THICKNESS*1.5)])rotate([0,0,170])cube([THICKNESS, (THICKNESS*2), (THICKNESS*2)]);
	}
}

module cutout(x,y,z=(THICKNESS-THICKNESS*1.5)){
	translate([x,y,(z*1.2)])cube([THICKNESS, (THICKNESS*4), (THICKNESS*4)], center=true);
}

module try(){
	hull(){
		translate([0,0,0])cylinder(h=THICKNESS, r=(RADIUS*2), $fn=QUALITY);
		translate([0,100,0])cylinder(h=THICKNESS, r=(RADIUS*3), $fn=QUALITY);
	}
}
module tripod(z){
difference(){
	color("green"){
		rotate([0,0,0])try();
		rotate([0,0,90])try();
	}
	color("yellow")rotate([0,0,45]){cutout(-70,75,z);}
	color("yellow")rotate([0,0,45]){cutout(70,75,z);}
	}
}

module render(){
  translate([-20, -20, 0])rotate(90)arm();
	translate([0,0])tripod(0);
}
render();
