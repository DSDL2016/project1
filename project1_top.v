module project1_top #(
    parameter width = 6
)(
    input	   				clk,
    input	 [width-1:0]	a,
    input	 [width-1:0]	b,
    input  [2:0]			func,
    output [2*width-1:0]	out,
    output [6:0]			seg_4, seg_3, seg_2, seg_1,
    output					err
);

	wire [width-1:0] tmp;
	
	add_top add(
		.c_in  (1'b0),
		.a  (a),
		.b  (b),
		.out (tmp),
		.overflow (err)
	);
	
	assign out = {{width{1'b0}}, tmp};
	
endmodule
