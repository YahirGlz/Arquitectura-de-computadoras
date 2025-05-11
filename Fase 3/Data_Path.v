`timescale 1ns/1ns

module Data_Path(input clk_dp);
  wire [31:0]instruction_wire;
  wire [31:0]signal_extended_dp;
  wire branch_equal;
  wire jump_f;
  wire [25:0]j_adress_f;

  Ciclo_Fetch C_F(.clk_f(clk_dp), 
                  .instruction_f(instruction_wire),
                  .be_f(branch_equal),
                  .j_adrees(j_adress_f),
                  .jump(jump_f),
                  .signal_extended_f(signal_extended_dp));

  Jericalla_Mejorada J_M(.instruction(instruction_wire),
				                 .clk_jm(clk_dp),
                         .signal_extended_jm(signal_extended_dp),
                         .be_jm(branch_equal),
                         .j_adress_jm(j_adress_f),
                         .jump_jm(jump_f));
endmodule

module Data_Path_TB();
  reg clk_tb;
  Data_Path DP(.clk_dp(clk_tb));

  integer i;
  initial begin
    clk_tb = 0;
    #10
    for(i=0;i<1000;i=i+1) begin
      #10 clk_tb = ~clk_tb;
      #10 clk_tb = ~clk_tb;
      #10 clk_tb = ~clk_tb;
      #10 clk_tb = ~clk_tb;
    end
    
  end

endmodule