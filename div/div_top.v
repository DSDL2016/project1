module div_top #(
	parameter width = 6
)(
	input						  clk,
	input						  sign,
	// a = b*q + r
	input		  [width-1:0] a, b,
	output reg [width-1:0] q, r,
	output					  ready
);
	
	reg [width-1:0] q_tmp, r_tmp;
	
	// internal counter
	
	// divider logic control
	
	// prescale
	
	// signed bit conversion
	
	// carry free adder
	
	// digit adjustment
	
	// refresh output
	
	// rewrite output
	
endmodule
