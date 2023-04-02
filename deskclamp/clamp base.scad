$fs=0.5;
$fa=5; 

difference() {
    union() {
        import("C:/TheGuy/Documents/CAD/deskclamp/Desk hanger flat.stl");
        translate([-5,-38,0])
        cube([70,8,40]);
    }
    translate([55,-30,-1])
    rotate(45)
    linear_extrude(6) {
        square(10);
    }
}