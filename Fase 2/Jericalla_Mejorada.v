
module Jericalla_Mejorada(input [31:0]instruction,
				                  input clk_jm,
                          output reg [31:0]signal_extended_jm, 
                          output reg be_jm);

  wire  [8:0]uc_bus; 
  wire [31:0]data_A,   data_B;
  wire [31:0]data_A_b, data_B_b, data_B_b_b;

  wire  [3:0]ac_out;
  wire  [3:0]ac_out_b;
  wire [31:0]alu_out;
  wire [31:0]alu_out_b;
  wire [31:0]mem_out;
  wire [31:0]mux_out;

  //Agregado para solucionar el problema del delay en la escritura:
  wire [4:0]wa, wa_b, wa_b_b;
  
  wire mtr_b, mtr_b_b; //MemToReg   (Selecciona si pasamos salida de memoria o de alu al banco)
  wire mtw_b, mtw_b_b; //MemToWrite (read/write de la memoria)
  wire rw_b,  rw_b_b;  //RegWrite   (write enable del banco)
  
  ////////////////////////////////////////////////////

  wire zero_flag;
  wire [31:0]signal_extended;
  wire [31:0]mux_to_alu, mux_to_alu_b;

  ////////////////////////////////////////////////////

  Buffer_Subida Bu_Data_A(.in   (data_A), 
                          .clk_b(clk_jm), 
                          .out  (data_A_b));

  Buffer_Subida Bu_Data_B(.in   (data_B), 
                          .clk_b(clk_jm), 
                          .out  (data_B_b));

  Buffer_Subida Bu_Data_B_b(.in   (data_B_b), 
                            .clk_b(clk_jm), 
                            .out  (data_B_b_b));      

  Buffer_Subida Bu_to_Alu(.in   (mux_to_alu), 
                          .clk_b(clk_jm), 
                          .out  (mux_to_alu_b));

  Buffer_Subida Bu_Alu_Out(.in   (alu_out),
                           .clk_b(clk_jm),
			     	               .out  (alu_out_b));

  Buffer_Subida #(.width(4)) Bu_Ac_Out (.in   (ac_out), 
                                        .clk_b(clk_jm),
			     	                            .out  (ac_out_b));

  Buffer_Subida #(.width(1)) Bu_Mtr(.in   (uc_bus[2]), 
                                    .clk_b(clk_jm),
			     	                        .out  (mtr_b));

  Buffer_Subida #(.width(1)) Bu_Mtr_b(.in   (mtr_b), 
                                      .clk_b(clk_jm),
			     	                          .out  (mtr_b_b));

  Buffer_Subida #(.width(1)) Bu_Mtw(.in   (uc_bus[1]), 
                                    .clk_b(clk_jm),
			     	                        .out  (mtw_b));

  Buffer_Subida #(.width(1)) Bu_Mtw_b(.in   (mtw_b), 
                                      .clk_b(clk_jm),
			     	                          .out  (mtw_b_b));
              
  Buffer_Subida #(.width(1)) Bu_Rw(.in   (uc_bus[0]), 
                                   .clk_b(clk_jm),
			     	                       .out  (rw_b));

  Buffer_Subida #(.width(1)) Bu_Rw_b(.in   (rw_b), 
                                     .clk_b(clk_jm),
			     	                         .out  (rw_b_b));

  Buffer_Subida #(.width(5)) Wa_wa(.in   (wa), 
                                   .clk_b(clk_jm),
			     	                       .out  (wa_b));
                 
  Buffer_Subida #(.width(5)) Wa_wa_b(.in   (wa_b), 
                                     .clk_b(clk_jm),
			     	                         .out  (wa_b_b));


  ///////////////////////////////////////////////////

  Alu_Control Alu_Ctrl(.func  (instruction[5:0]),
                       .alu_op(uc_bus[5:3]),
                       .out   (ac_out));

  ///////////////////////////////////////////////////

  // To Banco Registros
  Mux Mux_To_BR(.A(mem_out), 
                .B(alu_out_b), 
                .s(mtr_b_b), 
                .out(mux_out));

  // Write Addres Banco Registros
  Mux #(.width(5)) Mux_WA(.A(instruction[15:11]), 
                          .B(instruction[20:16]), 
                          .s(uc_bus[8]), 
                          .out(wa));

  Mux Mux_To_Alu(.A(signal_extended), 
                 .B(data_B), 
                 .s(uc_bus[6]), 
                 .out(mux_to_alu));

  ///////////////////////////////////////////////////

  Extensor_Signo ES(.in (instruction[15:0]), 
                    .out(signal_extended));

  ///////////////////////////////////////////////////

  Unidad_Control Uc(.op_code(instruction[31:26]), 
		                .bus    (uc_bus));

  Banco_Registros Br(.wa  (wa_b_b), 
				             .ra_A(instruction[25:21]), 
				             .ra_B(instruction[20:16]), 
			               .data_in(mux_out), 
				             .we    (rw_b_b), 
                     .dataA (data_A), 
				             .dataB (data_B)  ); 
  
  Alu Alu_(.X   (data_A_b), 
		       .Y   (mux_to_alu_b), 
		       .op  (ac_out_b), 
		       .r   (alu_out), 
           .zero(zero_flag));

  Memory memoria(.address (alu_out_b), 
           		   .data_in (data_B_b_b), 
           		   .RW      (mtw_b_b), 
	   		         .data_out(mem_out));

  ///////////////////////////////////////////////////

  always @(*) begin
    signal_extended_jm = signal_extended;
    be_jm = uc_bus[7] & zero_flag;
  end    

endmodule
