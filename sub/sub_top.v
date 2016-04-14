module sub_top #(
    parameter width = 6
)(
    input  [width-1:0] a,
    input  [width-1:0] b,
    output [width-1:0] out,
    output             ovf
);

    // SUB = ADD and NEG and CARRY IN
    add_top add(
        .c_in (1'b1),
        .a    (a),
        .b    (!b),
        .out  (out),
        .ovf  (ovf)
    );

endmodule
