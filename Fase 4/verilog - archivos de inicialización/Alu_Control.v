`define TIPO_R  3'b010
`define SW_LW   3'b000
`define BRANQ_E 3'b001

`define F_ADD  6'b100000
`define F_SUB  6'b100010
`define F_AND  6'b100100
`define F_OR   6'b100101
`define F_SLT  6'b101010

`define OP_ADD 4'b1111
`define OP_SUB 4'b0110
`define OP_AND 4'b0000
`define OP_OR  4'b0001
`define OP_SLT 4'b0111

`define ADDI 3'b011
`define ORI  3'b100
`define ANDI 3'b101
`define SLTI 3'b110 

///////////////////////////////////////////////////////////////////////////////

module Alu_Control(input [5:0]func, input [2:0]alu_op, output reg [3:0]out);
  initial out = 0; 
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
    end 
    
    `SW_LW:   begin out = `OP_ADD; end
    `BRANQ_E: begin out = `OP_SUB; end
    `ADDI:    begin out = `OP_ADD; end
	  `ORI:     begin out = `OP_OR;  end
	  `ANDI:    begin out = `OP_AND; end
	  `SLTI:    begin out = `OP_SLT; end

    endcase 

  end

endmodule