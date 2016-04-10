module seg_disp_top #(
    parameter width = 6,
    parameter digits = 2
)(
    input                     clk,
    input                     start,
    input      [width-1:0]    bin,
    output reg [4*digits-1:0] bcd,
    output                    done
);
	
	 /*
	  * shift-and-add-3 algorithm
	  */
	  
    // width of bit counter
    localparam  cnt_width = $clog2(width);

    // internal states
    reg  [width-1:0]     bin_reg;
    reg  [4*digits-1:0]  bcd_reg;
    wire [width-1:0]     bin_next;
    reg  [4*digits-1:0]  bcd_next;
    reg                  busy;
    reg  [cnt_width-1:0] counter;
    wire                 counter_done;

    initial begin
        // reset registers
        busy <= 0;
        bcd <= 0;
    end

    function [4*digits-1:0] bcd_asl;
        input [4*digits-1:0] din;
        input newbit;

        integer k;
        reg c_in;
        reg [3:0] digit;
        reg [3:0] digit_next;

        begin
            c_in = newbit;
            for(k = 0; k < digits; k = k+1) begin
                digit[3 -: 4] = din[4*k+3 -: 4];
                digit_next = digit - 5;

                if(digit > 4'b0100) begin
                    bcd_asl[4*k+3 -: 4] = {digit_next[2 -: 3], c_in};
                    c_in = 1'b1;
                end
                else begin
                    bcd_asl[4*k+3 -: 4] = {digit[2 -: 3], c_in};
                    c_in = 1'b0;
                end
            end
        end
    endfunction

    // binary ASL and BCD ASL
    assign bin_next = {bin_reg, 1'b0};
    always @(bcd_reg or bin_reg) begin
        // fetch MSB
        bcd_next <= bcd_asl(bcd_reg, bin_reg[width-1]);
    end

    // position counter
    always @(posedge clk) begin
        if(~busy)
            counter <= 0;
        else if(~counter_done)
            counter <= counter + 1;
    end
    assign counter_done = (counter == (width-1));

    // busy bit, input and output registers
    always @(posedge clk) begin
        if(start && ~busy) begin
            // start conversion
            //  1. signal START
            //  2. copy data to input
            //  3. clear output
            busy <= 1;
            bin_reg <= bin;
            bcd_reg <= 0;
        end
        else if(busy && counter_done && ~start) begin
            // stop conversion
            //  1. signal DONE
            //  2. copy result to output
            busy <= 0;
            bcd <= bcd_next;
        end
        else if(busy && ~counter_done) begin
            // intermediate state
            //  1. copy current result to next input
            bcd_reg <= bcd_next;
            bin_reg <= bin_next;
        end
    end
    assign done = ~busy;

endmodule
