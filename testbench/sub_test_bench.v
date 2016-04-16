module sub_test_bench();

    parameter WIDTH = 6;

    // 6-bit sign interger range
    parameter LOWER = -(1 << (WIDTH - 1));
    parameter UPPER = (1 << (WIDTH - 1)) - 1;

    reg signed [WIDTH-1:0] r_a, r_b;

    wire                    overflow;
    wire signed [WIDTH-1:0] w_a, w_b;
    wire signed [WIDTH-1:0] w_out;

    // bond the input to registers
    assign w_cin = r_cin;
    assign w_a = r_a;
    assign w_b = r_b;

    // instantiate the module
    sub_top sub(w_a, w_b, w_out, overflow);

    // t_* for generated test
    // w_* for wire connections
    // r_* for registers
    integer t_a, t_b, t_out;

    initial begin
        $display("value can range from %d to %d", LOWER, UPPER);

        for (t_a = LOWER; t_a <= UPPER; t_a = t_a+1) begin
            for (t_b = LOWER; t_b <= UPPER; t_b = t_b+1) begin
                t_out = t_a - t_b;

                r_a = t_a[WIDTH-1:0];
                r_b = t_b[WIDTH-1:0];

                // wait for the device to settle
                # 10

                if (t_out >= LOWER && t_out <= UPPER) begin
                    // output in range
                    if (overflow == 1) begin  
                        $display("\nThe result isn't overflow, but the overflow bit is set.");
                        $display("Test Data  : %3d- %3d = %3d", t_a, t_b, t_out);
                        $display("Your result: %3d- %3d = %3d", w_a, w_b, w_out);
                        $display("overflow bit = %b", overflow);
                    end
                    else if (w_out != t_out) begin
                        $display("\nSubtraction error");
                        $display("Test Data  : %3d- %3d = %3d", t_a, t_b, t_out);
                        $display("Your result: %3d- %3d = %3d", w_a, w_b, w_out);
                        $display("overflow bit = %b", overflow);
                    end
                end
                else begin
                    // output overflow
                    if (overflow == 0) begin
                        $display("\nThe result is overflow, but the overflow bit isn't set.");
                        $display("Test Data  : %3d- %3d = %3d", t_a, t_b, t_out);
                        $display("Your result: %3d- %3d = %3d", w_a, w_b, w_out);
                        $display("overflow bit = %b", overflow);
                    end
                end
            end
        end
        $display("Test finished.");
    end

endmodule

