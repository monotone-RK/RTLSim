`default_nettype none

`include "led_blinking.v"

module test;
  parameter clock_half_period = 5;
  
  /* input */   
  reg CLK;
  reg RST;
  
  /* output */   
  wire ULED;

  // Clock and Reset Generator
  initial begin CLK = 0; forever #(clock_half_period) CLK = ~CLK; end
  initial begin RST = 1; #1000; RST = 0; end
  
  L_TIKA uut(CLK, RST, ULED);
  
  // get waveform data
  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0, uut);
  end

  // simulation finish flag
  always @(posedge CLK) begin
    if (RST) begin
    end else begin
      $write("count: %d\n", uut.cnt); $fflush();
      if (uut.cnt == 30) $finish();
    end
  end
  
endmodule

`default_nettype wire
