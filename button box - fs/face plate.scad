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

module face_cutout() {
    top_y = 47;
    hole_distance_button_y = 17;
    for (i=[0:1]) {
        // holes for top switch
        translate([i*hole_distance_button+hole_distance_button/2+side_padding,top_y,3])
        rotate(a=[180,0,0]) {
            key_switch_cutout(assembly_thickness = 12);
        }
    }

    for (i=[2:num_button-1]) {
        // holes for rotary
        translate([i*hole_distance_button+hole_distance_button/2+side_padding,top_y,-1])
        cylinder(h=10,d=7);
    }

    for (i=[0:num_button-1]) {
        // holes for second row of switches
        translate([i*hole_distance_button+hole_distance_button/2+side_padding,top_y-hole_distance_button_y,3])
        rotate(a=[180,0,0]) {
            key_switch_cutout(assembly_thickness = 12);
        }
    }

    for (i=[0:num_button-1]) {
        // holes for second row of switches
        translate([i*hole_distance_button+hole_distance_button/2+side_padding,top_y-hole_distance_button_y-hole_distance_button_y,3])
        rotate(a=[180,0,0]) {
            key_switch_cutout(assembly_thickness = 12);
        }
    }
}

module main() {
    difference() {
        box();
        translate([0,2.89778,0])
        rotate([75,0,0]) {
            face_cutout();
        }
    }
}
main();

//----- Helpers -----

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

module key_switch_cutout(
        assembly_thickness = 3) {
    tab_width=0.8;
    assembly_y=14;
    assembly_x=assembly_y+(2*tab_width);
    tab_thickness = 1.5;
    difference () {
        translate([0,0,assembly_thickness/2]) {
            cube(size=[assembly_x,assembly_y,assembly_thickness], center=true);
        }
        // Right side
        translate([assembly_y/2+tab_width/2,0,tab_thickness/2]) {
            // Middle tab
            cube(size=[tab_width,5,tab_thickness], center=true);
        }
        translate([assembly_y/2+tab_width/2,6.5,tab_thickness/2]) {
            // Top tab
            cube(size=[tab_width,1,tab_thickness], center=true);
        }
        translate([assembly_y/2+tab_width/2,-6.5,tab_thickness/2]) {
            // Buttom tab
            cube(size=[tab_width,1,tab_thickness], center=true);
        }
        // Left side
        translate([-(assembly_y/2+tab_width/2),0,tab_thickness/2]) {
            // Middle tab
            cube(size=[tab_width,5,tab_thickness], center=true);
        }
        translate([-(assembly_y/2+tab_width/2),6.5,tab_thickness/2]) {
            // Top tab
            cube(size=[tab_width,1,tab_thickness], center=true);
        }
        translate([-(assembly_y/2+tab_width/2),-6.5,tab_thickness/2]) {
            // Buttom tab
            cube(size=[tab_width,1,tab_thickness], center=true);
        }
    }
}

module box() {
    intersection() {
        cube([assembly_width,assembly_depth,assembly_height]);
        difference() {
            union() {
                translate([0,2.89778,0])
                rotate([75,0,0]) {
                    // Face plate
                    cube([assembly_width,60,3]); 
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
}