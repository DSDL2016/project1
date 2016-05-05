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
	 wire [3:0] w_bcd_c121, w_bcd_c1210, w_bcd_c12100, w_bcd_c121000, w_bcd_c12sgn;
	 wire [3:0] w_bcd_c61, w_bcd_c610, w_bcd_c6100, w_bcd_c61000, w_bcd_c6sgn;
	 
	 reg r_sgn;
	 
	 // select signed or unsigned
	 always @(mod_sel) begin
	     r_sgn = (mod_sel == 2'b11) ? 0 : 1;
	 end
	 
	 bin2bcd conv_a(
	     .sgn     (r_sgn),
	     .bin     (a),
		  .bcd     ({w_bcd_a10, w_bcd_a1}),
		  .bcd_sgn (w_bcd_asgn)
	 );
	 
	 bin2bcd conv_b(
	     .sgn     (r_sgn),
	     .bin     (b),
		  .bcd     ({w_bcd_b10, w_bcd_b1}),
		  .bcd_sgn (w_bcd_bsgn)
	 );
	 
	 bin2bcd #(
		  .width  (2*width),
		  .digits (4)
	 ) conv_c12(
	     .sgn     (1),
	     .bin     (results),
		  .bcd     ({w_bcd_c121000, w_bcd_c12100, w_bcd_c1210, w_bcd_c121}),
		  .bcd_sgn (w_bcd_c12sgn)
	 );
	 
	 bin2bcd conv_c6(
	     .sgn     (1),
	     .bin     (results),
		  .bcd     ({w_bcd_c61000, w_bcd_c6100, w_bcd_c610, w_bcd_c61}),
		  .bcd_sgn (w_bcd_c6sgn)
	 );
	 
	 bin2bcd conv_q(
	     .sgn     (0),
		  .bin     (results[2*width-1:width]),
		  .bcd     ({w_bcd_q10, w_bcd_q1}),
		  .bcd_sgn (w_bcd_qsgn)
	 );
	 
	 bin2bcd conv_r(
	     .sgn     (0),
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
		  if (err) begin
				leds = {2*width{1'b0}};
				r_bcd = {{4{1'b1}}, 4'b1100, 4'b1101, 4'b1100, 
							4'b1100, 4'b1011, {4{1'b1}}, {4{1'b1}}};
		  end
		  else begin
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
					else if (mod_sel == 2'b10) begin
						 r_bcd = {w_bcd_c121, w_bcd_c1210, w_bcd_c12100, w_bcd_c121000,
									 w_bcd_c12sgn, {4{1'b1}}, {4{1'b1}}, {4{1'b1}}};
					end
					else begin
						 r_bcd = {w_bcd_c61, w_bcd_c610, w_bcd_c6100, w_bcd_c61000,
									 w_bcd_c6sgn, {4{1'b1}}, {4{1'b1}}, {4{1'b1}}};
					end
			  end
		  end
    end
	 
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
