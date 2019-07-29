/*
  Custom Plugs
  
  TODO:
    - Add more designs
*/

//  Just edit this size to your current Plug size.
//    (Dimensions are all in milimeter)
SIZE = 28;      //  The size of your plug
SUPPORT = 8;   //  The depth of your plug (depends on earlobe size).

//  Rendering options
QUALITY = 1000;   //  OpenSCAD renderer quality

// Plug
module plug(size, depth, quality){
  translate([0,0,1])union(){
    difference(){
      //  Flares
      union(){
        color("orange")translate([0,0,depth])color("white")cylinder(r=((size/2)+1), h=1, $fn=quality);
        color("orange")translate([0,0,depth/depth-2])color("white")cylinder(r=((size/2)+1), h=1, $fn=quality);
        //  Main ring
        color("green")cylinder(d=size, h=depth, $fn=quality);
      }
      translate([0,0,-SUPPORT])cylinder(r=((size/2)-0.5), h=depth*3, $fn=QUALITY);
    }
  }
}

// Renderer
module render(){plug(SIZE,SUPPORT,QUALITY);}render();
