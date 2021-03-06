use <supports.scad>
use <positioning.scad>
use <util.scad>
use <placeholders.scad>
include <definitions.scad>

$fn = 4;
enable_projection = false;

module project() {
  if (enable_projection) {
    projection() children();
  }
  else {
    children();
  }
}

for (col=[0:5], i=[0,1]) {
  project()
  translate([col*55 + i * 27 - 150, 0, 0])
  rotate([0, 90, 0])
  multmatrix(un_key_place_transformation(col, 2))
  main_support_column(col);
}

translate([-140, -90, 0]) {
  for (i=[1:2]) {
    project()
    translate([20 * i - 20, 0, 0])
    rotate([0, 90, 0])
    multmatrix(inverted_thumb_place_transformation(1, 0))
    difference() {
      thumb_supports_col3();
      thumb_side_supports();
    }

    project()
    translate([-20 * i, 0, 0])
    rotate([0, 90, 0])
    multmatrix(inverted_thumb_place_transformation(2, 0))
      thumb_supports_col1();

    project()
    translate([20 * i + 20, 0, 0])
    rotate([0, 90, 0])
    multmatrix(inverted_thumb_place_transformation(0, 0))
      thumb_supports_col2();
  }
}

front_matrix = thumb_place_transformation(1, -1.5);
front_invert = inverted_thumb_place_transformation(1, -1.5);
front_undown = rotation_down(front_matrix, invert=true);

project()
translate([12, -95, 0])
rotate([-90, 0, -103])
multmatrix(front_undown)
multmatrix(front_invert)
thumb_front_cross_support();

back_matrix = thumb_place_transformation(1, -1.5);
back_invert = inverted_thumb_place_transformation(1, -1.5);
back_undown = rotation_down(back_matrix, invert=true);

project()
translate([-45, -75, 0])
rotate([-90, 0, -12])
multmatrix(back_undown)
multmatrix(back_invert)
thumb_back_cross_support();

project()
translate([120, -120, 0]) rotate([90, 0, 180]) main_front_cross_support();

project()
translate([60, -70, 0]) rotate([90, 0, 0]) main_back_cross_support();

project()
translate([30, -145, 0])
rotate([90, 0, 0])
multmatrix(un_key_place_transformation(0, 2.5))
main_inner_column_cross_support();

thumb_column_matrix = thumb_place_transformation(0, -.15);
thumb_column_invert = inverted_thumb_place_transformation(0, -.15);

project()
translate([100, -135, 0])
rotate([-90, 0, 0])
multmatrix(thumb_column_invert)
thumb_inner_column_cross_support();

for (y=[1:14], x=[0,1]) {
  project()
  translate([x * (plate_width+1) - 230, y * (plate_height+1)-165, 0])
  plate(1, 1);
}

for (y=[0:4]) {
  project()
  translate([-265, y * (plate_width*1.5+1) - 190, 0])
  rotate([0, 0, 90])
  plate(1.5, 1);
}

project()
translate([-145, -190, 0])
rotate([0, 0, 90])
plate(1.5, 1, w_offset=.25);

for (x=[0,1]) {
  project()
  translate([x * (plate_width+1) + 40, -190, 0])
  plate(1, 2);
}

