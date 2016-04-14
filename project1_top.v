module project1_top #(
    parameter width = 6
)(
    input                clk,
    input  [width-1:0]   a,
    input  [width-1:0]   b,
    input  [2:0]         func,
    output [2*width-1:0] out,
    output               err
);

    alu_top alu(
        .clk  (clk),
        .a    (a),
        .b    (b),
        .func (func[1:0]),
        .out  (out),
        .ovf  (err)
    );
	
endmodule
