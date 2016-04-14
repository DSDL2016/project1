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
	
	// busy bit and 
	always @(posedge clk) begin
	
	end
	assign done = !busy;
	
 P := N
 D := D << n              * P and D need twice the word width of N and Q
 for i = n-1..0 do        * for example 31..0 for 32 bits
   if P >= 0 then
     q[i] := +1
     P := 2*P - D
   else
     q[i] := -1
     P := 2*P + D
   end if
 end
 
 * Note: N=Numerator, D=Denominator, n=#bits, P=Partial remainder, q(i)=bit #i of quotient.
	
endmodule
