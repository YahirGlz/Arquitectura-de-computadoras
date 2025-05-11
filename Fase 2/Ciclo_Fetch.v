
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

  initial begin  
    $readmemb("instrucciones_8b.txt", memory);   
    instruction = 32'bz;
  end
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

module Ciclo_Fetch(input clk_f, input [31:0]signal_extended_f, input be_f, output reg [31:0]instruction_f);

  initial begin  instruction_f = 32'bz; end

  wire [31:0]pc_in, pc_out;
  wire [31:0]ad_out; 
  wire [31:0]instruction_wire;
  wire [31:0]signal_shifted;
  wire [31:0]mux_signal_branched;
  wire [31:0]suma_de_signals;

  assign suma_de_signals = signal_shifted + ad_out;
  
  Shift_Left SL(.in (signal_extended_f),
                .out(signal_shifted));

  Mux Mux_Salto_Instrucciones(.A(suma_de_signals), 
                              .B(ad_out), 
                              .s(be_f), 
                              .out(mux_signal_branched));

  Buffer_Bajada Bu_Ad_Out(.in   (mux_signal_branched), 
                          .clk_b(clk_f), 
                          .out  (pc_in));

  Ajuste_Direcciones ad(.address(pc_out), .address_ajustada(ad_out));
  Pc                 pc(.in(pc_in),       .clk(clk_f), .out(pc_out));
  Memory_I           mi(.address(pc_out), .instruction(instruction_wire)); 
 
  always @(*) begin
    instruction_f = instruction_wire;
  end
  
endmodule
