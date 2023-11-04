// Cyble-style holder for PL-05N inductive proximity sensor 
// for Pipersberg G4 RF1 c gas-meter
// Remix of https://www.thingiverse.com/thing:5160100

$fn=200;

// Sensor holder
module holder(){
    difference(){
        // Outer shell
        union(){
            // Hook
            translate([-2.5,(-29/2-2),0]) cube([5,10,1.5]);
          
            // Connection to gas-meter
            intersection(){
                cylinder(d=21.5,h=1.5);
                translate([-21/2,-30/2,0])cube([17.5,30,1.5]);
            }
                
            // Sensor housing
            difference(){
                union(){
                    hull(){
                        translate([2,0,0])cylinder(d=32,h=10);
                        translate([2,2,10])cylinder(d1=29,d2=27,h=13);
                        translate([2,4,0])cylinder(d=32,h=10);
                    }
                    
                    translate([-7.5,-20,0])cube([15,53,15]);
                }
                
                // Outer ring on meter
                cylinder(d=25.5,h=1.5);
                  
                translate([-9.5/2,-20,0])cube([9.5,6,4.5]);
                  
                translate([(-11-1.5)/2,25.5/2+10.5,0])cube([11,8,3]);
                translate([(-8-1.5)/2,2+25.5/2+10.5,0])cube([8,4,20]);      
            }
        }
        
        // Sensor hole/holder
        translate([0, 3.5, 0]) rotate([0,0,90]){
//            // Original LJ12 A3-4Z sensor
//            lj12_a34z_sensor();
            
            // New PL-05N sensor
            translate([-1.5,-2.0,35/2]){
                pl5n_sensor();
            }
        }
        
        // Splint hole
        hull(){
            translate([-.75,34,10])rotate([90,0,0])cylinder(d=3.5,h=10);
            translate([-.75,34,6])rotate([90,0,0])cylinder(d=3.5,h=10);
        }
    }
}

// LJ12 A3-4-Z sensor
module lj12_a34z_sensor() {
    cylinder(d=10.8,h=4);
    translate([0,0,4])cylinder(d=12,h=25);
}

// PL-05N sensor
module pl5n_sensor() {
    sensor_width =            18.0;
    sensor_height =           36.0;
    sensor_holder_depth =      0.2;
    sensor_holder_length =    17.0;
    sensor_ripple_thickness =  6.5;
    
    difference(){
        // Sensor itself
        cube([sensor_width,sensor_width,sensor_height], center=true);
        
        offset_x = sensor_width/2-sensor_holder_depth/2;
        offset_z = -sensor_height/2 + sensor_holder_length/2;
        
        // Ripples on the side
        translate([+offset_x, 0, +offset_z])
            cube([sensor_holder_depth, sensor_ripple_thickness, sensor_holder_length], center=true);
        translate([-offset_x, 0, +offset_z])
            cube([sensor_holder_depth, sensor_ripple_thickness, sensor_holder_length], center=true);
    }
}

// Splint
module splint(){
    translate([-20,0,3])rotate([-90,0,0])difference(){
        union(){
          hull(){
            translate([3,0,0])cylinder(d=1,h=18);
            translate([-3,0,0])cylinder(d=1,h=18);
          }

          translate([-3.5,0,0])cube([7,3,20]);
          translate([0,2.5/2,-3])cylinder(d=3.5,h=5);
          translate([0,2.5/2,-3])sphere(d=3.5);

          translate([0,0,18])scale([2,1,1])cylinder(d=3.5,h=2);
        }

        translate([0,4,10])rotate([90,0,0])cylinder(d=3,h=10);
        translate([0,1,10])rotate([0,90,90])cylinder(d=6.5,h=10,$fn=6);
    }
}

// MAIN CODE

splint();
holder();
