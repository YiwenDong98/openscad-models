translate([0,0,40])
mirror([0,0,1])
intersection() {
    translate([7,0,0])
    import("C:/TheGuy/Documents/CAD/deskclamp/clamp base.stl");
    
    union() {
        translate([0,-70,0])
        cube([80,100,40]);

        translate([-60,-50,0])
        cube([60,18,40]);
    }
}





difference() {
    translate([7,0,0])
    import("C:/TheGuy/Documents/CAD/deskclamp/clamp base.stl");
    
    translate([0,-70,0])
    cube([80,100,40]);
    
    translate([-60,-50,0])
    cube([60,18,40]);
}