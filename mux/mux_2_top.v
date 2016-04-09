module mux_2_top #(
	parameter width = 6
)(
	input	 [width-1:0] a, b,
	input					 sel,
	output [width-1:0] out
);

	genvar i;
	generate
		for(i = 0; i < width; i = i+1) begin : MUX_2X1_BLK
			mux_2x1 m(
				.a		(a[i]),
				.b		(b[i]),
				.sel	(sel),
				.out	(out[i])
			);
		end
	endgenerate

endmodule
