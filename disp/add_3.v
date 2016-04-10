module add_3(
	input  	  [3:0] bin,
	output reg [3:0] bcd
);

	// truth table
	// 0 0 0 0 - 0 0 0 0
	// 0 0 0 1 - 0 0 0 1
	// 0 0 1 0 - 0 0 1 0
	// 0 0 1 1 - 0 0 1 1
	// 0 1 0 0 - 0 1 0 0
	// 0 1 0 1 - 1 0 0 0
	// 0 1 1 0 - 1 0 0 1
	// 0 1 1 1 - 1 0 1 0
	// 1 0 0 0 - 1 0 1 1
	// 1 0 0 1 - 1 1 0 0
	// 1 0 1 0 - x x x x
	// ...
	// 1 1 1 1 - x x x x

	always @(bin) begin
		case (bin)
			4'b0000: bcd <= 4'b0000;
			4'b0001: bcd <= 4'b0001;
			4'b0010: bcd <= 4'b0010;
			4'b0011: bcd <= 4'b0011;
			4'b0100: bcd <= 4'b0100;
			4'b0101: bcd <= 4'b1000;
			4'b0110: bcd <= 4'b1001;
			4'b0111: bcd <= 4'b1010;
			4'b1000: bcd <= 4'b1011;
			4'b1001: bcd <= 4'b1100;
			// don't care
			default: bcd <= 4'b0000;
		endcase
	end
	
endmodule
