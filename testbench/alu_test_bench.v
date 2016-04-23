module alu_test_bench();

    parameter WIDTH = 6;

    // 6-bit sign interger range
    parameter LOWER = -(1 << (WIDTH - 1));
    parameter UPPER = (1 << (WIDTH - 1)) - 1;

    reg clock = 1'b0;
    reg signed [WIDTH - 1:0] a, b;
    wire                    overflow;
    reg        [1:0]         func;
    wire signed [2 * WIDTH - 1:0] out;

    alu_top alu(clock, a, b, func, out, overflow);

    integer test_out, error_count;

    reg signed [2 * WIDTH - 1: 0] mul_ans;

    integer i, j;
    initial begin
        $display("value can range from %d to %d", LOWER, UPPER);
        error_count = 0;

        func = 2'b10; // mul
        for (i = LOWER; i <= UPPER; i = i + 1) begin
          for (j = LOWER; j <= UPPER; j = j + 1) begin
            test_out = i * j;
            mul_ans = test_out[2 * WIDTH - 1: 0];
            a = i[WIDTH - 1: 0];
            b = j[WIDTH - 1: 0];
            #10000
            if (mul_ans != out) begin
              $display("Multiplication error");
              $display("Test Data  : %3d*%3d = %5d", i, j, mul_ans);
              $display("Your result: %3d*%3d = %5d", a, b, out);
              error_count = error_count + 1;
            end
          end
        end
        
        $display("Test finished. Total %d errors.\n", error_count);
    end

    always #1000 begin
      clock = ~clock;
    end
	
endmodule
/*
          // division
          if (a >= 0 && b > 0) begin
            func = 2'b11; // div
            quotient = out[2 * WIDTH - 1: WIDTH];
            remainder = out[WIDTH - 1: 0];
#100
          clock = ~clock;
#100
          clock = ~clock;
#100
            if (a / b != quotient || a % b != remainder) begin
              $display("Division error");
              error_count = error_count + 1;
            end
            
          end
*/
          /*
          func = 2'b00; // add
          test_out = a + b;
          add_ans = {test_out[31], test_out[WIDTH - 2: 0]}; 
#100
          clock = ~clock;
#100
          clock = ~clock;
#100
          if (test_out < LOWER || test_out > UPPER) begin
            if (overflow == 1'b0) begin
              $display("The result is overflow, but the overflow bit isn't set."); 
              $display("Test Data  : %3d+ %3d = %3d", a, b, test_out);
              $display("Your result: %3d+ %3d = %3d", a, b, out);
              $display("overflow bit = %b", overflow);
              error_count = error_count + 1;
            end
          end else if (overflow == 1'b1) begin
            $display("The result isn't overflow, but the overflow bit is set.");
            $display("Test Data  : %3d+ %3d = %3d", a, b, add_ans);
            $display("Your result: %3d+ %3d = %3d %b", a, b, out, out);
            $display("overflow bit = %b", overflow);
            error_count = error_count + 1;
          end else if (add_ans != out[WIDTH - 1: 0]) begin
            $display("Summation error");
            $display("Test Data  : %3d+ %3d = %3d", a, b, add_ans);
            $display("Your result: %3d+ %3d = %3d %b", a, b, out, out);
            $display("overflow bit = %b", overflow);
            error_count = error_count + 1;
          end

          func = 2'b01; // sub
          test_out = a - b;
#100
          clock = ~clock;
#100
          clock = ~clock;
#100
          if (test_out < LOWER || test_out > UPPER) begin
            if (overflow == 1'b0) begin
              $display("The result is overflow, but the overflow bit isn't set.");
              error_count = error_count + 1;
            end
          end else if (overflow == 1'b1) begin
            $display("The result isn't overflow, but the overflow bit is set.");
            error_count = error_count + 1;
          end else if (test_out != out) begin
            $display("Subtraction error");
            error_count = error_count + 1;
          end
*/
