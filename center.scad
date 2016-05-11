// Units are in mm
$fn=20;

edge_length = 35;
height = 14;
bevel = 10;

holder_height_ratio = .8;
screw_hole_width = 3.34;
screw_head_width = 8;
screw_height_ratio = .85;

center_width = sqrt(pow(edge_length / 2, 2) + pow(bevel, 2));

module corner_indent() {
    indent_width = (sqrt(2) / 2) * edge_length - bevel;
    indent_height = 2 * height * holder_height_ratio + 1;
    rotate([0, 0, 45]) {
        translate([-indent_width / 2, -indent_width / 2, -1]) {
            cube([indent_width, indent_width, indent_height / 2]);
        }
    }
}

module edge_indent() {
    offset = sqrt(2) * edge_length;
    indent_width = offset - bevel;
    indent_height = 2 * height * holder_height_ratio + 1;
    rotate([0, 0, 45]) {
        translate([offset / 2, 0, -1]) {
            cube([indent_width, indent_width, indent_height], true);
        }
    }

}

module screw_hole() {
    union() {
        // Screw hole
        translate([0, 0, -1]) cylinder(h=height + 2, d=screw_hole_width);
        translate([0, 0, height * screw_height_ratio]) cylinder(h=height / 2 + 2, d=screw_head_width);
        translate([0, 0, height * screw_height_ratio - 2.9]) cylinder(h=3, d1=screw_hole_width, d2 = screw_head_width, center = false);
    }
}

translate([0, 0, height / 2]) {
    rotate([0, 180, 0]) {
        edge_offset = edge_length / 2;
        difference() {
            cube([edge_length, edge_length, height], true);
            rotate([0, 0, 0]) translate([0, 0, - height / 2]) edge_indent();
            rotate([0, 0, 180]) translate([0, 0, - height / 2]) edge_indent();
            translate([0, 0, -height / 2]) screw_hole();
        }
    }
}
