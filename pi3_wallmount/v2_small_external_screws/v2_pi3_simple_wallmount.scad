/*
  Simple Pi3 (wall)mount.
  Measurements are in mm.
  
  Author: gn0mish@protonmail.com

  #!yaml
  mount:
    usage:
      grams: 7
      time: '35 minutes'
    misc:
      screws:
      size: '2mm x 10mm'
      amount: 8
    printing:
      settings:
        layer height: 0.2
        infill: 8
        infill pattern: 'zig zag'
        speed: '30-60'
        adhesion type: 'skirt'
      material:
        pla_0:
          print temp: 205
          bed temp: 63
          vendor: anycubic
        pla_1:
          print temp: 205
          bed temp: 63
          vendor: https://www.123-3d.nl
        petg:
          print temp: 240
          bed temp: 80
          vendor: https://www.123-3d.nl
*/

// Editable variables
QUALITY = 100;      // Render QUALITY setting for OpenSCAD.
THICKNESS = 2;      // Desired THICKNESS of the print.
STAND_LENGTH = 10;  // Desired standoff LENGTH

// Do NOT edit these variables unless you know what you are doing...
MULTIPLIER = 2.7;
RADIUS = 6;
WIDTH = 55 + RADIUS;
LENGTH = 65 + RADIUS;
SCREW_SIZE = 1.4;

// Modules
module external_mounts () {union(){difference(){
  hull(){
    cylinder(h=THICKNESS,r1=RADIUS,r2=RADIUS, $fn=QUALITY);
    translate([10,10,0])cylinder(h=THICKNESS,r1=(RADIUS/2),r2=(RADIUS/2),$fn=QUALITY);
  }
  translate([10,10,0])cylinder(h=THICKNESS,r=SCREW_SIZE,$fn=QUALITY);
}}};

module standoff () {difference(){
  cylinder(h=STAND_LENGTH,r1=RADIUS,r2=3.5,$fn=QUALITY);
  cylinder(h=STAND_LENGTH,r1=0,r2=SCREW_SIZE,$fn=QUALITY);}
};

module tapered_hole(){cylinder(h=THICKNESS, r1=1, r2=3,$fn=QUALITY);};

module pi3_plate (){
  /*
    Unifying module to create the pi3 mount.
  */
  union() {
    difference(){
    // render base plate
      translate([6,6,0]){
        hull(){
          r = 6; z = THICKNESS; test = 0;
          translate([0,WIDTH-12,test])cylinder(r=r,h=z,$fn=QUALITY);
          translate([LENGTH-12,WIDTH-12,test])cylinder(r=r,h=z,$fn=QUALITY);
          translate([0,0,test])cylinder(r=r,h=z,$fn=QUALITY);
          translate([LENGTH-12,0,test])cylinder(r=r,h=z,$fn=QUALITY);
        };
      };
      
      // base plate inner cut out
      translate([12,12,0]){
        hull(){
          r = 2; z = THICKNESS; test = 0;
          translate([0,WIDTH-24,test])cylinder(r=r,h=z,$fn=QUALITY);
          translate([LENGTH-24,WIDTH-24,test])cylinder(r=r,h=z,$fn=QUALITY);
          translate([0,0,test])cylinder(r=r,h=z,$fn=QUALITY);
          translate([LENGTH-24,0,test])cylinder(r=r,h=z,$fn=QUALITY);
        };
      };
      
      // render side tapered cut outs
      // width wise
      hull () {
        translate([5,RADIUS*MULTIPLIER,0])cylinder(THICKNESS,1,3,$fn=QUALITY);
        translate([5,WIDTH-(RADIUS*MULTIPLIER),0])cylinder(THICKNESS,1,3,$fn=QUALITY);
      };
      
      hull () {
        translate([LENGTH-5,WIDTH-(RADIUS*MULTIPLIER),0])cylinder(THICKNESS,1,3,$fn=QUALITY);
        translate([LENGTH-5,RADIUS*MULTIPLIER,0])cylinder(THICKNESS,1,3,$fn=QUALITY);
      };
      
      // length wise
      hull(){
        translate([RADIUS*MULTIPLIER,WIDTH-5,0])cylinder(THICKNESS,1,3,$fn=QUALITY);
        translate([LENGTH-(RADIUS*MULTIPLIER),WIDTH-5,0])cylinder(THICKNESS,1,3,$fn=QUALITY);
      };
      
      hull(){
        translate([RADIUS*MULTIPLIER,5,0])cylinder(THICKNESS,1,3,$fn=QUALITY);
        translate([LENGTH-(RADIUS*MULTIPLIER),5,0])cylinder(THICKNESS,1,3,$fn=QUALITY);
      };
    };
    
    // render standoffs
    x1 = LENGTH - RADIUS; y1 = RADIUS; y2 = WIDTH - RADIUS;
    translate([y1,y2,THICKNESS]){standoff();};
    translate([x1,y2,THICKNESS]){standoff();};
    translate([y1,y1,THICKNESS]){standoff();};
    translate([x1,y1,THICKNESS]){standoff();};

    // render external_mounts
    translate([6,6,0])rotate([0,0,180])external_mounts();
    translate([LENGTH-RADIUS,WIDTH-RADIUS,0])rotate([0,0,0])external_mounts();
    translate([6,55,0])rotate([0,0,90])external_mounts();
    translate([65,6,0])rotate([0,0,270])external_mounts();
  };
};
pi3_plate();
