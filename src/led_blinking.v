`default_nettype none
  
module L_TIKA #(parameter   WIDTH = 32)
               (input  wire CLK, 
                input  wire RST, 
                output wire ULED);
  
  reg [WIDTH-1:0] cnt;
  
  assign ULED = cnt[2];
  
  always @(posedge CLK) begin
    if (RST) cnt <= 0;
    else     cnt <= cnt + 1;
  end
  
endmodule

`default_nettype wire
