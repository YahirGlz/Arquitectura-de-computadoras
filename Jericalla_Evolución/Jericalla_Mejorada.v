`timescale 1ns/1ns
module jericalla_mejorada(input [16:0]main_bus,
				                  input clk,
					                output reg [31:0] out);

  wire  [7:0]control_bus; 
  wire [31:0]data_A,     data_B;
  wire [31:0]data_A_Bu1, data_B_Bu1;

  wire [31:0]memory_demux_A,    memory_demux_B;
  wire [31:0]memory_demux_A_Bu, memory_demux_B_Bu;

  wire [31:0]alu_demux_A, alu_demux_B;

  wire [31:0]data_out;

  wire  [3:0]op_Alu;
  wire [31:0]out_Alu;
  wire [31:0]out_Alu_Bu;

  wire control_demux_Bu;
  
  wire wm_Bu1, wm_Bu2;
  wire rm_Bu1, rm_Bu2;
  wire we_Bu1, we_Bu2;

  ////////////////////////////////////////////////////

  buffer bu_dataA_1(.in   (data_A), 
                    .clk_b(clk), 
                    .out  (data_A_Bu1));

  buffer bu_dataB_1(.in   (data_B), 
                    .clk_b(clk), 
                    .out  (data_B_Bu1));

  buffer bu_control_demux(.in   (control_bus[2]), 
                          .clk_b(clk), 
                          .out  (control_demux_Bu));

  buffer bu_memory_demux_A(.in   (memory_demux_A),
                           .clk_b(clk),
				                   .out  (memory_demux_A_Bu));

  buffer bu_memory_demux_B(.in   (memory_demux_B),
                           .clk_b(clk),
						               .out  (memory_demux_B_Bu));

  buffer bu_op_alu(.in   (control_bus[6:3]),
                   .clk_b(clk),
				           .out  (op_Alu));

  buffer bu_out_alu(.in   (out_Alu),
                    .clk_b(clk),
			     	        .out  (out_Alu_Bu));

  buffer we1(.in   (control_bus[7]),
             .clk_b(clk),
	           .out  (we_Bu1));

  buffer we2(.in   (we_Bu1),
             .clk_b(clk),
             .out  (we_Bu2));
  
  buffer bu_wm1(.in   (control_bus[1]),
                .clk_b(clk),
                .out  (wm_Bu1));

   buffer bu_wm2(.in  (wm_Bu1),
                .clk_b(clk),
                .out  (wm_Bu2));

  buffer bu_rm1(.in   (control_bus[0]),
                .clk_b(clk),
                .out  (rm_Bu1));

  buffer bu_rm2(.in   (rm_Bu1),
                .clk_b(clk),
                .out  (rm_Bu2));

  ///////////////////////////////////////////////////

  demux demux_A(.data_in(data_A_Bu1),
			          .s      (control_demux_Bu),
			          .alu    (alu_demux_A),
			          .memory (memory_demux_A));

  demux demux_B(.data_in(data_B_Bu1),
			          .s      (control_demux_Bu),
			          .alu    (alu_demux_B),
			          .memory (memory_demux_B));

  ///////////////////////////////////////////////////

  control ctrl(.opCode    (main_bus[16:15]), 
		           .controlBus(control_bus));

  banco_registros BR(.WA  (main_bus[14:10]), 
				             .RA_A(main_bus[9:5]), 
				             .RA_B(main_bus[4:0]), 
			               .dataIn(out_Alu_Bu), 
				             .WE    (we_Bu2), 
                     .dataA (data_A), 
				             .dataB (data_B)  ); 
  
  ALU alu(.X(alu_demux_A), 
		      .Y(alu_demux_B), 
		      .S(op_Alu), 
		      .r(out_Alu));

  memory memoria(.address(memory_demux_A_Bu), 
           		   .dataIn (memory_demux_B_Bu), 
           		   .W      (wm_Bu2),
           	     .R      (rm_Bu2), 
	   		         .dataOut(data_out));

  assign out = data_out; 

endmodule

// ------------------------------------------------------ //

module Jericalla_TB();
  wire [31:0]out_tb;
  wire [16:0]instrucciones[5:0];
  reg  [16:0]main_bus_tb;
  reg  clk_tb;
  jericalla_mejorada TB(.main_bus(main_bus_tb), .clk(clk_tb), .out(out_tb));

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
      main_bus_tb = instrucciones[i];
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

