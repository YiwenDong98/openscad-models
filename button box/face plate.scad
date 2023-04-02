use <MCAD/nuts_and_bolts.scad>

$fs=0.5;
$fa=5; 

side_padding = 6;
hole_distance_button = 18;
num_button = 6;

assembly_width = hole_distance_button*num_button+side_padding*2;
echo(str("width: ", assembly_width));
assembly_height = 55;
assembly_depth = 60;

module drilled_sheet(
    assembly_width,
    assembly_depth,
    assembly_height,
    nut_hole
    ) {
    difference() {
        hole_dist = 10;
        cube([assembly_width,assembly_depth,assembly_height]); // Bottom wall
        for (ix=[1:ceil(assembly_width/hole_dist)-1]) {
            for (iy=[1:ceil(assembly_depth/hole_dist)-1]) {
                translate([hole_dist*ix,hole_dist*iy,-1])
                cylinder(h=assembly_height*2+4,d=4,center=true);
                if (nut_hole) {
                    translate([hole_dist*ix,hole_dist*iy,assembly_height-3.2])
                    nutHole(4);
                }
            }
        }
    }
}

intersection() {
    cube([assembly_width,assembly_depth,assembly_height]);
    difference() {
        union() {
            translate([0,2.89778,0])
            rotate([75,0,0]) {
            difference() {
                
                cube([assembly_width,60,3]);
                
                for (i=[0:num_button-1]) {// holes for switch
                    translate([i*hole_distance_button+hole_distance_button/2+side_padding,20,-1])
                    cylinder(h=10,d=13.4);
                }
                
                for (i=[0:num_button-1]) {// holes for switch
                    translate([i*hole_distance_button+hole_distance_button/2+side_padding,45,-1])
                    cylinder(h=10,d=6);
                }
            }
            }
            cube([assembly_width,3,0.77647]);
            translate([0,0,assembly_height-2])
            difference() {
                drilled_sheet(assembly_width,assembly_depth,2,false); // Top wall
                translate([15,0,-1])
                cube([assembly_width-30,assembly_depth+1,4]);
            }
            cube([3,assembly_depth,assembly_height]); // Left wall
            translate([assembly_width-3,0,0])
            cube([3,assembly_depth,assembly_height]); // Right wall
            drilled_sheet(assembly_width,assembly_depth,3,false); // Bottom wall
        }
        translate([-1,2.89778-3,0])
        rotate([75,0,0])
        cube([assembly_width+2,60,1000]);
    }
}