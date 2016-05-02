module bin2bcd #(
    parameter width = 6,
    parameter digits = 2,
	 parameter abs_val = 1
)(
    input      [width-1:0]     bin,
    output reg [bcd_width-1:0] bcd,
    output reg [3:0]           bcd_sgn
);

    localparam bcd_width = digits*4;
    integer i, j;

    // implement the double-dabble algorithm
    reg [width-1:0] r_bin;
    always @(bin) begin
	     if (abs_val) begin
            // turn the input to absolute value
			   if (bin[width-1]) begin
                r_bin = -bin;
                bcd_sgn = 4'b1010;
            end
            else begin
                r_bin = bin;
                bcd_sgn = 4'b1111;
            end
		  end

        // initialize bcd register to 0
        bcd = 0;

        // iterate through all the digits from r_bin
        for (i = 0; i < width; i = i+1) begin
            // concat selected bit to the end
            bcd = {bcd[(bcd_width-1)-1:0], r_bin[(width-1)-i]};

            //if a hex digit is more than 4, add 3
            if (i < width-1) begin
                for (j = 3; j < bcd_width; j = j+4) begin
                    if (bcd[j -: 4] > 4)
                        bcd[j -: 4] = bcd[j -: 4]+3;
                end
            end
        end
    end

endmodule
