module add_test_bench();
  parameter WIDTH = 6;
  // 6-bit sign interger range
  parameter LOWER = -(1 << (WIDTH - 1));
  parameter UPPER = (1 << (WIDTH - 1)) - 1;
  
  reg cin;
  reg signed [WIDTH-1:0] a, b;
  
  wire w_cin, overflow;
  wire [WIDTH-1:0] w_a;
  wire [WIDTH-1:0] w_b;
  wire signed [WIDTH-1:0] wout;
  assign w_cin = cin;
  assign w_a = a;
  assign w_b = b;

  add_top add(cin, a, b, wout, overflow);
  
  integer test_cin, num_a, num_b, sum;
  initial begin
    // $display("range from %d %d", LOWER, UPPER);
    for (test_cin = 0; test_cin <= 1; test_cin = test_cin + 1) begin
      for (num_a = LOWER; num_a <= UPPER; num_a = num_a + 1) begin
        for (num_b = LOWER; num_b <= UPPER; num_b = num_b + 1) begin
          sum = num_a + num_b;
          cin = test_cin[0];
          a = num_a[WIDTH-1:0];
          b = num_b[WIDTH-1:0];
          
          # 10
          
          if (num_a != a || num_b != b) begin
            $display("Input error.");
            $display("Test Data:%3d+ %3d = %3d", num_a, num_b, sum);
            $display("Your result:%3d+ %3d = %d", a, b, wout);
            $display("overflow bit=%b", overflow);
          end

          if (sum >= LOWER && sum <= UPPER) begin
            if (overflow == 1) begin  
              $display("The result isn't overflow, but the overflow bit is set.");
              $display("Test Data:%3d+ %3d = %3d", num_a, num_b, sum);
              $display("Your result:%3d+ %3d = %d", a, b, wout);
              $display("overflow bit=%b", overflow);
            end else if (sum != wout) begin
              $display("Summation error");
              $display("Test Data:%3d+ %3d = %3d", num_a, num_b, sum);
              $display("Your result:%3d+ %3d = %d", a, b, wout);
              $display("overflow bit=%b", overflow);
            end
          end else begin
            if (overflow == 0) begin
              $display("The result is overflow, but the overflow bit isn't set.");
              $display("Test Data:%3d+ %3d = %3d", num_a, num_b, sum);
              $display("Your result:%3d+ %3d = %d", a, b, wout);
              $display("overflow bit=%b", overflow);
            end
          end

        end
      end
    end  
    
  end
endmodule

