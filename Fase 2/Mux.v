module Mux #(parameter width = 32) (input [width-1:0]A, 
                                    input [width-1:0]B, 
                                    input s, output reg [width-1:0]out);
  
  initial begin out = 0; end

  always @(*) begin
    if(s) begin out = A; end
    else  begin out = B; end
  end

endmodule