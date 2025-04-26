
module Pc(input [31:0]in, input clk, output reg  [31:0]out); // program counter
   initial begin out = 0; end 
   always @(negedge clk) begin
    out = in;
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////

module Memory_I(input      [31:0]address, 
	              output reg [31:0]instruction);
 
  reg [7:0]memory[999:0];

  initial begin  $readmemb("instrucciones_8b.txt", memory);  end  
  initial begin  instruction = 32'bz; end 
  always @(*) begin
    instruction[31:24] = memory[address];
    instruction[23:16] = memory[address+1];
    instruction[15:8]  = memory[address+2];
    instruction[7:0]   = memory[address+3];
  end

endmodule

///////////////////////////////////////////////////////////////////////////////////

module Ajuste_Direcciones(input [31:0]address, output reg [31:0]address_ajustada);
  initial begin address_ajustada = 0; end
  always @(*) begin
    address_ajustada = address + 4;
  end

endmodule 

///////////////////////////////////////////////////////////////////////////////////

module Ciclo_Fetch(input clk_f, output reg [31:0]instruction_f);

  wire [31:0]Pc_In, Pc_Out;
  wire [31:0]Ad_Out; 
  wire [31:0]instruction_wire;

  Buffer_Bajada Bu_Ad_Out(.in   (Ad_Out), 
                          .clk_b(clk_f), 
                          .out  (Pc_In));

  Ajuste_Direcciones ad(.address(Pc_Out),   .address_ajustada(Ad_Out));
  Pc                 pc(.in(Pc_In),         .clk(clk_f), .out(Pc_Out));
  Memory_I           mi(.address(Pc_Out), .instruction(instruction_wire)); 
 
  assign instruction_f = instruction_wire;

endmodule

/*
module Ciclo_Fetch_TB();

  reg  clk_tb;
  wire [31:0]instruction_tb;
  
  Ciclo_Fetch CF(.clk_f(clk_tb), .instruction_f(instruction_tb));
 
  
  
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
*/

