/*
  Simple Pi3 mount.

  Measurements are in mm.
  
  Author: gn0mish@protonmail.com
  
  TODO:
    - Improve variable usage.
    - Create submodules for certain parts of code.
*/


// Editable variables
quality = 200;      // Render quality setting for OpenSCAD.
thickness = 1;      // Desired thickness of the print.
stand_length = 10;  // Desired standoff length


// Do NOT edit these variables.
multiplier = 2.7;
radius = 6;
width = 55 + radius;
length = 65 + radius;


// Modules
module external_mounts () {
  union(){
    difference(){
      hull(){
        cylinder(h=thickness,r1=radius,r2=radius, $fn=quality);
        translate([10,10,0])cylinder(h=thickness,r1=radius,r2=radius,$fn=quality);
      };
      translate([10,10,0])cylinder(h=thickness,r1=2,r2=radius,$fn=quality);
    };
  };
};

module standoff () {
  difference(){
    cylinder(h=stand_length,r1=6,r2=3.5,$fn=quality);
    cylinder(h=stand_length,r1=0,r2=1,$fn=quality);
  }
};

module tapered_hole(){
  cylinder(h=thickness, r1=1, r2=3,$fn=quality);
};

module pi3 (){
  /*
    Unifying module to create the pi3 mount.
  */
  union() {
    difference(){
    // render base plate
      translate([6,6,0]){
        hull(){
          r = 6; z = thickness; test = 0;
          translate([0,width-12,test])cylinder(r=r,h=z,$fn=quality);
          translate([length-12,width-12,test])cylinder(r=r,h=z,$fn=quality);
          translate([0,0,test])cylinder(r=r,h=z,$fn=quality);
          translate([length-12,0,test])cylinder(r=r,h=z,$fn=quality);
        };
      };
      
      // inner cut out
      translate([12,12,0]){
        hull(){
          r = 2; z = thickness; test = 0;
          translate([0,width-24,test])cylinder(r=r,h=z,$fn=quality);
          translate([length-24,width-24,test])cylinder(r=r,h=z,$fn=quality);
          translate([0,0,test])cylinder(r=r,h=z,$fn=quality);
          translate([length-24,0,test])cylinder(r=r,h=z,$fn=quality);
        };
      };
      
      // render side cut outs
      // Width wise
      hull () {
        translate([5,radius*multiplier,0])cylinder(thickness,3,4,$fn=quality);
        translate([5,width-(radius*multiplier),0])cylinder(thickness,3,4,$fn=quality);
      };
      
      hull () {
        translate([length-5,width-(radius*multiplier),0])cylinder(thickness,3,4,$fn=quality);
        translate([length-5,radius*multiplier,0])cylinder(thickness,3,4,$fn=quality);
      };
      
      // Length wise
      hull(){
        translate([radius*multiplier,width-5,0])cylinder(thickness,3,4,$fn=quality);
        translate([length-(radius*multiplier),width-5,0])cylinder(thickness,3,4,$fn=quality);
      };
      
      hull(){
        translate([radius*multiplier,5,0])cylinder(thickness,3,4,$fn=quality);
        translate([length-(radius*multiplier),5,0])cylinder(thickness,3,4,$fn=quality);
      };
    };
    
    // render standoffs
    x1 = length - radius; y1 = radius; y2 = width - radius;
    translate([y1,y2,thickness]){standoff();};
    translate([x1,y2,thickness]){standoff();};
    translate([y1,y1,thickness]){standoff();};
    translate([x1,y1,thickness]){standoff();};

    // render external_mounts
    translate([6,6,0])rotate([0,0,180])external_mounts();
    translate([length-radius,width-radius,0])rotate([0,0,0])external_mounts();
    translate([6,55,0])rotate([0,0,90])external_mounts();
    translate([65,6,0])rotate([0,0,270])external_mounts();
  };
};
pi3();