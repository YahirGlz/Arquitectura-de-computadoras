
module Jericalla_Mejorada(input [31:0]intruction,
				                  input clk_jm);

  wire  [5:0]uc_bus; 
  wire [31:0]data_A,   data_B;
  wire [31:0]data_A_b, data_B_b, data_B_b_b;

  wire  [3:0]ac_out;
  wire  [3:0]ac_out_b;
  wire [31:0]alu_out;
  wire [31:0]alu_out_b;
  wire [31:0]mem_out;
  wire [31:0]mux_out;

  wire mtr_b, mtr_b_b; //MemToReg
  wire mtw_b, mtw_b_b; //MemToWrite
  wire rw_b,  rw_b_b;  //RegWrite
  
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

  Buffer_Subida Bu_Alu_Out(.in   (alu_out),
                    .clk_b(clk_jm),
			     	        .out  (alu_out_b));

  Buffer_Subida Bu_Ac_Out(.in   (ac_out),
                   .clk_b(clk_jm),
			     	       .out  (ac_out_b));

  Buffer_Subida Bu_Mtr(.in   (uc_bus[2]),
                .clk_b(clk_jm),
			     	    .out  (mtr_b));

  Buffer_Subida Bu_Mtr_b(.in   (mtr_b),
                  .clk_b(clk_jm),
			     	      .out  (mtr_b_b));

  Buffer_Subida Bu_Mtw(.in   (uc_bus[1]),
                .clk_b(clk_jm),
			     	    .out  (mtw_b));

  Buffer_Subida Bu_Mtw_b(.in   (mtw_b),
                  .clk_b(clk_jm),
			     	      .out  (mtw_b_b));
              
  
  Buffer_Subida Bu_Rw(.in   (uc_bus[0]),
               .clk_b(clk_jm),
			     	   .out  (rw_b));

  Buffer_Subida Bu_Rw_b(.in   (rw_b),
                 .clk_b(clk_jm),
			     	     .out  (rw_b_b));

  ///////////////////////////////////////////////////

  Alu_Control Alu_Ctrl(.func  (intruction[5:0]),
                       .alu_op(uc_bus[5:3]),
                       .out   (ac_out));

  ///////////////////////////////////////////////////

  Unidad_Control Uc(.op_code(intruction[31:26]), 
		                .bus    (uc_bus));


  Banco_Registros Br(.wa  (intruction[15:11]), 
				             .ra_A(intruction[25:21]), 
				             .ra_B(intruction[20:16]), 
			               .data_in(mux_out), 
				             .we    (rw_b_b), 
                     .dataA (data_A), 
				             .dataB (data_B)  ); 
  
  Alu Alu_(.X (data_A_b), 
		       .Y (data_B_b), 
		       .op(ac_out_b), 
		       .r (alu_out));

  Memory memoria(.address (data_B_b_b), 
           		   .data_in (alu_out_b), 
           		   .RW      (mtw_b_b), 
	   		         .data_out(mem_out));

  Mux Mux_(.A(mem_out), 
           .B(alu_out_b), 
           .s(mtr_b_b), 
           .out(mux_out));

endmodule

// ------------------------------------------------------ //
/*
module Jericalla_TB();
  wire [31:0]out_tb;
  wire [16:0]instrucciones[5:0];
  reg  [16:0]intruction_tb;
  reg  clk_tb;
  Jericalla_Mejorada TB(.intruction(intruction_tb), .clk(clk_tb), .out(out_tb));

  assign instrucciones[0] = 17'b 00_00100_00000_00001; // Suma
  assign instrucciones[1] = 17'b 11_00000_00111_00100; // SW de sum 

  assign instrucciones[2] = 17'b 01_00101_00001_00010; // Resta 
  assign instrucciones[3] = 17'b 11_00000_01000_00101; // SW de resta

  assign instrucciones[4] = 17'b 10_00110_00010_00011; // SOLT
  assign instrucciones[5] = 17'b 11_00000_01001_00110; // SW de SOLT
  
  integer i;
  initial begin
    clk_tb = 0;
    #100
    for(i=0;i<6;i=i+1) begin
      intruction_tb = instrucciones[i];
      #100
      clk_tb = ~clk_tb;
      #100
      clk_tb = ~clk_tb;
      #100
      clk_tb = ~clk_tb;
      #100
      clk_tb = ~clk_tb;
    end
    
  end

endmodule

*/