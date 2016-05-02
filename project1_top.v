module project1_top #(
    parameter width = 6,
	 parameter n_segs = 8
)(
    input      [width-1:0]    a,
    input      [width-1:0]    b,
    input      [2:0]          func,
    output reg [2*width-1:0]  leds,
    output     [0:7*n_segs-1] segs,
    output                    err
);

    wire               out_sel = func[2];
	 wire [1:0]         mod_sel = func[1:0];
	 wire [2*width-1:0] results;
	 
	 //
	 // alu
	 //
    alu_top alu(
        .a    (a),
        .b    (b),
        .func (mod_sel),
        .out  (results),
        .ovf  (err)
    );
	 
	 //
	 // bin2bcd
	 //
	 wire [3:0] w_bcd_a1, w_bcd_a10, w_bcd_asgn;
	 wire [3:0] w_bcd_b1, w_bcd_b10, w_bcd_bsgn;
	 wire [3:0] w_bcd_q1, w_bcd_q10, w_bcd_qsgn;
	 wire [3:0] w_bcd_r1, w_bcd_r10, w_bcd_rsgn;
	 wire [3:0] w_bcd_c1, w_bcd_c10, w_bcd_c100, w_bcd_c1000, w_bcd_csgn;
	 
	 bin2bcd conv_a(
	     .bin     (a),
		  .bcd     ({w_bcd_a10, w_bcd_a1}),
		  .bcd_sgn (w_bcd_asgn)
	 );
	 
	 bin2bcd conv_b(
	     .bin     (b),
		  .bcd     ({w_bcd_b10, w_bcd_b1}),
		  .bcd_sgn (w_bcd_bsgn)
	 );
	 
	 bin2bcd #(
		  .width  (2*width),
		  .digits (4)
	 ) conv_c(
	     .bin     (results),
		  .bcd     ({w_bcd_c1000, w_bcd_c100, w_bcd_c10, w_bcd_c1}),
		  .bcd_sgn (w_bcd_csgn)
	 );
	 
	 bin2bcd conv_q(
		  .bin     (results[2*width-1:width]),
		  .bcd     ({w_bcd_q10, w_bcd_q1}),
		  .bcd_sgn (w_bcd_qsgn)
	 );
	 
	 bin2bcd conv_r(
		  .bin     (results[width-1:0]),
		  .bcd     ({w_bcd_r10, w_bcd_r1}),
		  .bcd_sgn (w_bcd_rsgn)
	 );
	 
	 // using these wires to route 7seg display
	 // ...starts from HEX0 to HEX7
	 reg [4*n_segs-1:0] r_bcd;
	 wire [0:7*n_segs-1] w_segs;
	
	 //
	 // display selection
	 //
	 always @(*) begin
	     if (out_sel) begin
		      leds = {a, b};
				
				r_bcd = {w_bcd_b1, w_bcd_b10, w_bcd_bsgn, {4{1'b1}}, 
				         w_bcd_a1, w_bcd_a10, w_bcd_asgn, {4{1'b1}}};
		  end
		  else begin
		      leds = results;
				
		      if (mod_sel == 2'b11) begin
				    // divide mode
					 r_bcd = {w_bcd_r1, w_bcd_r10, w_bcd_rsgn, {4{1'b1}},
								 w_bcd_q1, w_bcd_q10, w_bcd_qsgn, {4{1'b1}}};
				end
				else begin
					 r_bcd = {w_bcd_c1, w_bcd_c10, w_bcd_c100, w_bcd_c1000,
								 w_bcd_csgn, {4{1'b1}}, {4{1'b1}}, {4{1'b1}}};
				end
		  end
    end
	 
	 // re-route quotion and remainder signal
	 
	 //
	 // bcd2seg
	 //
	 genvar i;
	 generate
	     for (i = 0; i < n_segs; i = i+1) begin : BCD2SEG_CONCAT
		      bcd2seg conv_seg(
				    .bcd (r_bcd[(n_segs-i)*4-1 -: 4]),
					 .seg (w_segs[i*7 +: 7])
				);
		  end
	 endgenerate
	 
	 // invert the output for HEX displays
	 assign segs = ~w_segs;
	 	 
endmodule
