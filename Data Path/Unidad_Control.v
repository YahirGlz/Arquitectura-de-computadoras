// TIPO R -> we  = 1
//        -> mtw = 0
//        -> mtr = 0

`define ADD 6'b000010
`define SUB 6'b000110
`define AND 6'b000000
`define OR  6'b000001
`define SLT 6'b000111

`define SW 6'b101011
`define LW 6'b100011

module Unidad_Control(input      [5:0]op_code,
	                  output reg [5:0]bus);

  always @(op_code) begin
	
    case (op_code)

    `ADD, `SUB, `AND, `OR, `SLT:  bus = 6'b010_0_0_1; // TIPO R
	`SW: begin bus = 6'b000_1_1_0; end 
	// TIPO J
    default: bus = 6'b000000;   
	 
    endcase
	
	/*
    case  (op_code)
	  TIPO R
	  ADD:  begin bus = 6'b010_x_0_1; end 
	  SUB:  begin bus = 6'b010_x_0_1; end 
	  AND:  begin bus = 6'b010_x_0_1; end 
	  OR:   begin bus = 6'b010_x_0_1; end  
	  SLT:  begin bus = 6'b010_x_0_1; end 
	  
    endcase
    */
  end

endmodule