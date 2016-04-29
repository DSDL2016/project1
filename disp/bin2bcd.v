module bin2bcd #(
    parameter width = 6,
    parameter digits = 2
)(
    input      [width-1:0]     bin,
    output reg [bcd_width-1:0] bcd
);

    localparam bcd_width = digits*4;
    integer i, j;

    // implement the double-dabble algorithm

    always @(bin) begin
        // initialize bcd register to 0
        bcd = 0;

        // iterate through all the digits from bin
        for (i = 0; i < width; i = i+1) begin
            // concat selected bit to the end
            bcd = {bcd[(bcd_width-1)-1:0], bin[(width-1)-i]};

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
