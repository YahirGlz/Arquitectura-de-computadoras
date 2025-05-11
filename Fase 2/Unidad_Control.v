 // rd  - RegDst (Selecciona bits de dirección de escritura en el banco)
 // bra - Branch (Salto de instrucciones)
 // as  - Alu source (Seleccionamos el operando B de la alu, para las tipo addi, ori, etc.)
 // mtr - MemToReg   (Selecciona si pasamos salida de memoria o de alu al banco)
 // mtw - MemToWrite (read/write de la memoria)
 // we  - RegWrite   (write enable del banco)
  
// TIPO R ---> rd = 1, bra = ?,  as = 0, alu_op, mtr = 0, mtw = 0, we = 1
// TIPO I ---> rd = X, bra = ?,  as = 1, alu_op, mtr = 1, mtw = 1, we = 0 (SW y LW)
// TIPO I ---> rd = 0, bra = ?,  as = 1, alu_op, mtr = 0, mtw = 0, we = 1 (Las otras)

// TIPO J ---> 


`define ADD 6'b000010
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

module Unidad_Control(input      [5:0]op_code,
	                  output reg [8:0]bus);

  initial begin bus = 9'bz; end

  always @(op_code) begin
	
    case (op_code)

	// TIPO R	
    `ADD, `SUB, `AND, `OR, `SLT:  bus = 9'b1_0_0_010_0_0_1; 
	
	// TIPO I
	`SW:   begin bus = 9'b0_0_1_000_1_1_0; end
	`LW:   begin bus = 9'b0_0_1_000_1_0_1; end

	`ADDI: begin bus = 9'b0_0_1_011_0_0_1; end
	`ORI:  begin bus = 9'b0_0_1_100_0_0_1; end
	`ANDI: begin bus = 9'b0_0_1_101_0_0_1; end
	`SLTI: begin bus = 9'b0_0_1_110_0_0_1; end
	
	
	`BEQ: begin bus = 9'b0_1_0_001_0_0_0; end

	// TIPO J
	// ***
	 
    endcase
	
	
  end

endmodule