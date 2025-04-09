`define TIPO_R 2'b10

`define F_ADD  6'b100000
`define F_SUB  6'b100010
`define F_AND  6'b100100
`define F_OR   6'b100101
`define F_SLT  6'b101010

`define OP_ADD 4'b0010
`define OP_SUB 4'b0110
`define OP_AND 4'b0000
`define OP_OR  4'b0001
`define OP_SLT 4'b0111

///////////////////////////////////////////////////////////////////////////////

module alu_control(input [5:0]func, int [1:0]aluOp, output reg [3:0]aluControl);

  always @(*) begin

    case (aluOp) 

    TIPO_R: begin
      
      case (func) begin
      F_ADD: begin aluControl = OP_ADD; end
      F_SUB: begin aluControl = OP_SUB; end
      F_AND: begin alicanto   = OP_AND; end
      F_OR:  begin aluControl = OP_OR;  end
      F_SLT: begin aluControl = OP_SLT; end
      endcase 
    
    end // Tipo R

    endcase // aluOp

  end

endmodule