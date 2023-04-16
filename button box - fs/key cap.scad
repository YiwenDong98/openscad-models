$fs=0.05;
$fa=5; 


main();
module main() {
    height=5.8;
    thickness=1.6;
    translate([0,0,thickness]) {
        key_stem(height=height);
    }
    face(thickness=thickness);
}

module face(thickness=1.6,width=16,height=12) {
    translate([0,0,thickness/2])
    cube([width,height,thickness],center=true);
}

module key_stem(height=5.8) {
    linear_extrude(height=height,center=false) {
        difference() {
            circle(d=5.5);
            square([4.1,1.17],center=true);
            square([1.17,4.1],center=true);
            rotate(a=0,v=[0,0,1]){
                translate([-0.884,-0.884]) {
                    radius(0.3);
                }
            }
            rotate(a=90,v=[0,0,1]){
                translate([-0.884,-0.884]) {
                    radius(0.3);
                }
            }
            rotate(a=180,v=[0,0,1]){
                translate([-0.884,-0.884]) {
                    radius(0.3);
                }
            }
            rotate(a=270,v=[0,0,1]){
                translate([-0.884,-0.884]) {
                    radius(0.3);
                }
            }
        }
    }
}

module radius(r) {
    difference() {
        square([r,r],center=false);
        circle(d=r*2);
    }
}