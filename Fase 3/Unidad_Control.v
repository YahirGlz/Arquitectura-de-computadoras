 // rd  -  RegDst (Selecciona bits de dirección de escritura en el banco)
 // bra -  Branch (Salto de instrucciones hacia adelante)
 // as  -  Alu source
 // mtr -  MemToReg   
 // mtw -  MemToWrite (read/write de la memoria)
 // we  -  RegWrite   (write enable del banco)
 // jump - Salto a cualquier intrucción 
  
// jump - rd - bra - as - alu_op - mtr - mtw - we 

`define ADD 6'b001111
`define SUB 6'b000110
`define AND 6'b000000
`define OR  6'b000001
`define SLT 6'b000111

`define SW   6'b101011
`define LW   6'b100011
`define ADDI 6'b001000
`define ANDI 6'b001100
`define ORI  6'b001101
`define SLTI 6'b001010
`define BEQ  6'b000100

`define J    6'b000010

module Unidad_Control(input      [5:0]op_code,
	                  output reg [9:0]bus);

  initial begin bus = 9'bz; end

  always @(op_code) begin
	
    case (op_code)

	// TIPO R	
    `ADD, `SUB, `AND, `OR, `SLT:  bus = 10'b0_1_0_0_010_0_0_1; 
	
	// TIPO I
	`SW:   bus = 10'b0_0_0_1_000_1_1_0; 
	`LW:   bus = 10'b0_0_0_1_000_1_0_1; 
	`ADDI: bus = 10'b0_0_0_1_011_0_0_1; 
	`ORI:  bus = 10'b0_0_0_1_100_0_0_1; 
	`ANDI: bus = 10'b0_0_0_1_101_0_0_1; 
	`SLTI: bus = 10'b0_0_0_1_110_0_0_1; 
	`BEQ:  bus = 10'b0_0_1_0_001_0_0_0; 

	// TIPO J
	`J:    bus = 10'b1_0_0_0_001_0_0_0; 
	 
    endcase
	
	
  end

endmodule