`define DE_ALU 1'b0
`define DE_MEM 1'b1

module Mux(input [31:0]A, input [31:0]B, input s, output reg [31:0]out);

  always @(*) begin
    
    case (s)
    `DE_MEM: begin out = A; end
    `DE_ALU: begin out = B; end
    endcase

  end

endmodule