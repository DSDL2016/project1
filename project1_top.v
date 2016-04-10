module project1_top #(
	parameter width = 6
)(
	input	   				clk,
	input	 [width-1:0]	a,
	input	 [width-1:0]	b,
	input  [2:0]			func,
	output [2*width-1:0]	out,
	output [6:0]			seg_a_1, seg_a_10, seg_b_1, seg_b_10,
	output					err
);

	alu_top alu(
		.clk		 (clk),
		.a			 (a),
		.b			 (b),
		.func		 (func[1:0]),
		.out		 (out),
		.overflow (err)
	);
	
endmodule
