module pj1_test_bench();

    parameter WIDTH = 6;

    // 6-bit sign interger range
    parameter LOWER = -(1 << (WIDTH - 1));
    parameter UPPER = (1 << (WIDTH - 1)) - 1;

    reg signed [WIDTH - 1:0] a, b;
    reg        [1:0]         func;
    wire      [2 * WIDTH - 1:0] out;
    wire                    overflow;
    wire     [6:0]         seg_a_1, seg_a_10, seg_b_1, seg_b_10;
    wire err;
    reg choose, clk;
    project1_top pj(clk, a, b, {choose, func}, out, seg_a_1, seg_a_10, seg_b_1, seg_b_10, overflow);

    integer test_out, error_count, test_quotient, test_remainder;

    reg [2 * WIDTH - 1: 0] mul_ans;
    reg [WIDTH - 1: 0] add_ans, add_out, sub_ans, sub_out, div_quotient_ans, div_remainder_ans, div_quotient_out, div_remainder_out;

    integer i, j;
    initial begin
        clk = 0;
        error_count = 0;

        for (i = LOWER; i <= UPPER; i = i + 1) begin
          for (j = LOWER; j <= UPPER; j = j + 1) begin
            a = i[WIDTH - 1: 0];
            b = j[WIDTH - 1: 0];
            func = 2'b00; // add
              #1000
              clk = ~clk;
              #1000
              clk = ~clk; 
              #1000
            test_out = i + j;
            add_ans = test_out[WIDTH - 1: 0];
            add_out = out[WIDTH - 1: 0];
            if (test_out < LOWER || test_out > UPPER) begin
              if (overflow == 1'b0) begin
                $display("The result is overflow, but the overflow bit isn't set."); 
                $display("Test Data  : %3d+ %3d = %3d", i, j, test_out);
                $display("Your result: %3d+ %3d = %3d", a, b, add_out);
                $display("overflow bit = %b", overflow);
                error_count = error_count + 1;
              end
            end else if (overflow == 1'b1) begin
              $display("The result isn't overflow, but the overflow bit is set.");
              $display("Test Data  : %3d+ %3d = %3d", i, j, test_out);
              $display("Your result: %3d+ %3d = %3d", a, b, add_out);
              $display("overflow bit = %b", overflow);
              error_count = error_count + 1;
            end else if (add_ans != add_out) begin
              $display("Summation error %d != %d", add_ans, add_out);
              $display("Test Data  : %3d+ %3d = %3d", i, j, test_out);
              $display("Your result: %3d+ %3d = %3d", a, b, add_out);
              $display("overflow bit = %b", overflow);
              error_count = error_count + 1;
            end
/*
            func = 2'b01; // sub
              #1000
              clk = ~clk;
              #1000
              clk = ~clk; 
              #1000
            test_out = i - j;
            sub_ans = test_out[WIDTH - 1: 0];
            sub_out = out[WIDTH - 1: 0];

            if (test_out < LOWER || test_out > UPPER) begin
              if (overflow == 1'b0) begin
                $display("The result is overflow, but the overflow bit isn't set.");
                $display("Test Data  : %3d- %3d = %3d", i, j, test_out);
                $display("Your result: %3d- %3d = %3d", a, b, sub_out);
                $display("overflow bit = %b", overflow);
                error_count = error_count + 1;
              end
            end else if (overflow == 1'b1) begin
                $display("The result isn't overflow, but the overflow bit is set.");
                $display("Test Data  : %3d- %3d = %3d", i, j, test_out);
                $display("Your result: %3d- %3d = %3d", a, b, sub_out);
                $display("overflow bit = %b", overflow);
              error_count = error_count + 1;
            end else if (sub_ans != sub_out) begin
                $display("Subtraction error");
                $display("Test Data  : %3d- %3d = %3d", i, j, test_out);
                $display("Your result: %3d- %3d = %3d", a, b, sub_out);
                $display("overflow bit = %b", overflow);
              error_count = error_count + 1;
            end

            func = 2'b10; // mul
              #1000
              clk = ~clk;
              #1000
              clk = ~clk; 
              #1000
            test_out = i * j;
            mul_ans = test_out[2*WIDTH - 1: 0];
            if (mul_ans != out) begin
              $display("Multiplication error");
              $display("Test Data  : %3d*%3d = %5d", i, j, test_out);
              $display("Your result: %3d*%3d = %5d", a, b, out);
              error_count = error_count + 1;
            end

            if (i >= 0 && j > 0) begin
              func = 2'b11; // div
              #1000
              clk = ~clk;
              #1000
              clk = ~clk; 
              #1000
              test_quotient = i / j;
              div_quotient_ans = test_quotient[WIDTH - 1: 0];
              div_quotient_out = out[2 * WIDTH - 1: WIDTH];

              test_remainder = i % j;
              div_remainder_ans = test_remainder[WIDTH - 1: 0];
              div_remainder_out = out[WIDTH - 1: 0];

              if (div_quotient_ans != div_quotient_out || div_remainder_ans != div_remainder_out) begin
                $display("Division error");
                $display("Test Data  : %3d / %3d = %3d .. %3d", i, j, div_quotient_ans, div_remainder_ans);
                $display("Your result: %3d / %3d = %3d .. %3d", a, b, div_quotient_out, div_remainder_out);
                error_count = error_count + 1;
              end
            end
*/
          end
        end

        $display("Test finished. Total %d errors.\n", error_count);
    end
endmodule
