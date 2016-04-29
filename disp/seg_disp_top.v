module seg_disp_top #(
    parameter width = 6,
    parameter digits = 2
)(
    input      [width-1:0]     bin,
    output reg [bcd_width-1:0] bcd,
	 output reg [3:0]           bcd_sgn
);

    reg [width-1:0] r_bin;
	 reg [3:0]       r_sgn;
	 
	 wire [3:0] w_bcd1, w_bcd10;
    wire [6:0] w_seg1, w_seg10, w_segsgn;
	 
	 initial begin
	     r_bin = bin;
	 end
	 
	 always @(bin) begin
	     if (bin[width-1]) begin
		      r_bin = -bin;
				r_sgn = 4'b1010;
		  end
		  else begin
		      r_bin = bin;
				r_sgn = 4'b1111;
		  end
	 end
	 
	 bin2bcd conv #(
	     .width  (width),
		  .digits (digits)
	 )(
	 );
	 
	 assign 
	 
endmodule
