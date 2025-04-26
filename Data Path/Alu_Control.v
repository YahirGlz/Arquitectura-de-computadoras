`define TIPO_R 3'b010
`define TIPO_I 3'b000
`define TIPO_J 3'b011

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

`define SW 4'b1111

///////////////////////////////////////////////////////////////////////////////

module Alu_Control(input [5:0]func, inout [2:0]alu_op, output reg [3:0]out);

  always @(*) begin

    case (alu_op) 

    `TIPO_R: begin
      
      case (func) 
      `F_ADD: begin out = `OP_ADD; end
      `F_SUB: begin out = `OP_SUB; end
      `F_AND: begin out = `OP_AND; end
      `F_OR:  begin out = `OP_OR;  end
      `F_SLT: begin out = `OP_SLT; end
      endcase 
    
    end // Tipo R
    
    `TIPO_I: begin out = `SW; end
    `TIPO_J: begin /**/ end

    endcase // aluOp

  end

endmodule