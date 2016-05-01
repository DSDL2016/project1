module bcd2seg(
	input  	  [3:0] bcd,
	output reg [6:0] seg
);

	// truth table
	// 0 0 0 0 - 1 1 1 1 1 1 0
	// 0 0 0 1 - 0 1 1 0 0 0 0
	// 0 0 1 0 - 1 1 0 1 1 0 1
	// 0 0 1 1 - 1 1 1 1 0 0 1
	// 0 1 0 0 - 0 1 1 0 0 1 1
	// 0 1 0 1 - 1 0 1 1 0 1 1
	// 0 1 1 0 - 1 0 1 1 1 1 1
	// 0 1 1 1 - 1 1 1 0 0 0 0
	// 1 0 0 0 - 1 1 1 1 1 1 1
	// 1 0 0 1 - 1 1 1 1 0 1 1
	// 1 0 1 0 - 0 0 0 0 0 0 1 ("-")
	// 1 0 1 1 - x x x x x x x
	// ...
	// 1 1 1 1 - x x x x x x x

	always @(bcd) begin
		case (bcd)
			4'b0000: seg <= 7'b1111110;
			4'b0001: seg <= 7'b0110000;
			4'b0010: seg <= 7'b1101101;
			4'b0011: seg <= 7'b1111001;
			4'b0100: seg <= 7'b0110011;
			4'b0101: seg <= 7'b1011011;
			4'b0110: seg <= 7'b1011111;
			4'b0111: seg <= 7'b1110000;
			4'b1000: seg <= 7'b1111111;
			4'b1001: seg <= 7'b1111011;
			4'b1010: seg <= 7'b0000001;
			// don't care
			default: seg <= 7'b0000000;
		endcase
	end
	
endmodule