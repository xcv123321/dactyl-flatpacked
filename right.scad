include <definitions.scad>
use <positioning.scad>
use <placeholders.scad>
use <structures.scad>

module key (w=1, h=1) {
  plate(w, h);

  color("dimgray") switch();

  color("slategray")
  translate([0, 0, plate_thickness+3])
  scale([w, h, 1 ]) keycap();
}

/// KEY LAYOUT
// main keys
each_key() key();

// last little key
place_keys([5], [4]) key();

// modifier key column
place_keys([5.125], [0:3]) key(w=1.25);

// inner key column
// this seems difficult to include with the thumb cluster.
// place_keys([-1], [0]) key();
// place_keys([-1], [1.25, 2.75]) key(h=1.5);

// thumb cluster
place_thumb_keys([2], [-1:1]) key();
place_thumb_keys([1], [1]) key();
place_thumb_keys([0,1], [-0.5]) key(h=2);

/// SUPPORTS
color("burlywood") {
  // inner column
  place_column_ribs([0]) column_rib(1, 4);

  // main columns
  place_column_ribs([1:4]) column_rib(0, 4);

  // outer column
  place_keys([5], [2]) {
    translate([-(7 + plate_thickness / 2), 0, 0]) column_rib(0, 4);
    scale([1.1, 1, 1]) translate([7 + plate_thickness / 2, 0, 0]) column_rib(0, 0);
    translate([(7 + plate_thickness) * 1.25, 0, 0]) column_rib(0, 4);
  }

  place_thumb_column_ribs([1, 2]) thumb_column_rib(0, 2);
  place_thumb_column_ribs([0]) thumb_column_rib(0, 1);
}
