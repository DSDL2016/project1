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

	alu_top alu(
		.clk		 (clk),
		.a			 (a),
		.b			 (b),
		.func		 (func[1:0]),
		.out		 (out),
		.overflow (err)
	);

// DEPRECATED
//	seg_disp_top a_seg(
//	    .bin    (a),
//	    .bcd_1  (seg_3),
//	    .bcd_10 (seg_4) 
//	);
	
endmodule
