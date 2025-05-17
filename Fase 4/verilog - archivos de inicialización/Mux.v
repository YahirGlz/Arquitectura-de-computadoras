module Mux #(parameter width = 32) (input [width-1:0]A, 
                                    input [width-1:0]B, 
                                    input s, output reg [width-1:0]out);
  
  initial out = 0; 

  always @(*) begin
    if(s) out = A; 
    else  out = B; 
  end

endmodule