`timescale 1ns/1ns

module PC(input [31:0]in, input clk, output reg  [31:0]out); // program counter
   initial begin out=-4; end 
   always @(posedge clk) begin
    out = in;
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////

module memoryI(input      [31:0]address, 
	           output reg [31:0]instruccion);
 
  reg [7:0]memory[999:0];

  initial begin  $readmemb("dataMeI.txt", memory);  end  

  always @(*) begin
    instruccion[31:24] = memory[address];
    instruccion[23:16] = memory[address+1];
    instruccion[15:8]  = memory[address+2];
    instruccion[7:0]   = memory[address+3];
  end

endmodule

///////////////////////////////////////////////////////////////////////////////////

module ajusteDirecciones(input [31:0]address, output reg [31:0]addressAjustada);

  always @(*) begin
    addressAjustada = address + 4;
  end

endmodule 

///////////////////////////////////////////////////////////////////////////////////

module cicloFetch(input clkF, output reg [31:0]instruccionF);

  wire [31:0] PC_IN_WIRE, PC_OUT_WIRE;
  wire [31:0] INSTRUCCION_WIRE;

  ajusteDirecciones ad(.address(PC_OUT_WIRE), .addressAjustada(PC_IN_WIRE));
  PC                pc(.in(PC_IN_WIRE),       .clk(clkF), .out(PC_OUT_WIRE));
  memoryI           mi(.address(PC_OUT_WIRE), .instruccion(INSTRUCCION_WIRE)); 
 
  assign instruccionF = INSTRUCCION_WIRE;

endmodule


module cicloFetch_TB();

  reg  clk_tb;
  wire [31:0]instruccion_tb;
  
  cicloFetch CF(.clkF(clk_tb), .instruccionF(instruccion_tb));
 
  
  
  initial begin
	  
    clk_tb = 0;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	#10
	clk_tb = ~clk_tb;
	
  end

endmodule


