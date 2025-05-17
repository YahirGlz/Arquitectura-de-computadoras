
module Pc(input [31:0]in, 
          input clk, 
          output reg  [31:0]out); // program counter
  initial out = 0; 
  always @(negedge clk) out = in;
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

module Ajuste_Direcciones(input [31:0]address, 
                          output reg [31:0]address_ajustada);
  initial address_ajustada = 0; 
  always @(*) address_ajustada = address + 4;

endmodule 

///////////////////////////////////////////////////////////////////////////////////

module Ciclo_Fetch(input clk_f, 
                   input [31:0]signal_extended_f, 
                   input be_f, 
                   input [25:0]j_adrees, 
                   input jump, 
                   output reg [31:0]instruction_f);

  initial instruction_f = 32'bz; 

  wire [31:0]pc_in, pc_out;
  wire [31:0]ad_out; 
  wire [31:0]instruction_wire;
  wire [31:0]signal_shifted_beq;
  wire [27:0]j_adress_extended, signal_shifted_ja;
  wire [31:0]mux_signal_branched, mux_jump_adress;
  wire [31:0]suma_de_signals;
  wire [31:0]ad_out_plus_ja;

  assign suma_de_signals = signal_shifted_beq + ad_out;
  assign ad_out_plus_ja  = {ad_out[31:28], signal_shifted_ja};

  Extensor_Signo #(.width_in(26), .width_out(28)) Es_Ja(.in (j_adrees), 
                                                        .out(j_adress_extended));

  Shift_Left #(.width(32) )SL_Beq(.in (signal_extended_f),
                                  .out(signal_shifted_beq));

  Shift_Left #(.width(28)) SL_Ja (.in (j_adress_extended),
                                  .out(signal_shifted_ja));

  Mux Mux_Salto_Instrucciones(.A(suma_de_signals), 
                              .B(ad_out), 
                              .s(be_f), 
                              .out(mux_signal_branched));
        
  Mux Mux_J_Adress(.A(ad_out_plus_ja), 
                   .B(mux_signal_branched), 
                   .s(jump), 
                   .out(mux_jump_adress));
        
  Buffer_Bajada Bu_Ad_Out(.in   (mux_jump_adress), 
                          .clk_b(clk_f), 
                          .out  (pc_in));

  Ajuste_Direcciones ad(.address(pc_out), .address_ajustada(ad_out));
  Pc                 pc(.in(pc_in),       .clk(clk_f), .out(pc_out));
  Memory_I           mi(.address(pc_out), .instruction(instruction_wire)); 
 
  always @(*) instruction_f = instruction_wire;
  
endmodule
