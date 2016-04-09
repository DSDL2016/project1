module div_top #(
	parameter width = 6
)(
	input						  clk,
	input						  sign,
	// a = b*q + r
	input		  [width-1:0] a, b,
	output reg [width-1:0] q, r,
	output					  done
);

	/*
	 * serial divider model
	 */
	
	localparam cnt_width = $clog2(width);
	
	// storage for intermediate calculations
	reg [width-1:0] q_tmp, r_tmp;
	
	// internal state
	reg 					  busy;
	reg [cnt_width-1:0] counter;
	
	initial begin
		// reset internal state
		busy = 0;
		counter = 0;
		
		// reset temporary storages
		q_tmp = 0;
		r_tmp = 0;
	end
	
	always @(posedge clk) begin
	
	end
	
	not done_sig(done, busy);
	
endmodule
