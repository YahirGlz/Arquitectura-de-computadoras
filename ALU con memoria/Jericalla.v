`timescale 1ns/1ns
module Jericalla(input [16:0]bus, output reg [31:0]dataOutJ, output reg ZFLG);
  wire [31:0]dataAJ, dataBJ;
  wire [31:0]dataRAM;
  wire [31:0]dataOut_WIRE;
  wire ZFLG_WIRE;
  ROM rom(.addressA(bus[8:5]),  .addressB(bus[4:1]), .dataA(dataAJ), .dataB(dataBJ));
  ALU alu(.X(dataAJ),           .Y(dataBJ),          .S(bus[12:9]),  .r(dataRAM),  .Zflag(ZFLG_WIRE));
  RAM ram(.address(bus[16:13]), .dataIn(dataRAM),    .RW(bus[0]),    .dataOut(dataOut_WIRE) );
  assign dataOutJ = dataOut_WIRE;
  assign ZFLG     = ZFLG_WIRE ;
endmodule 


module Jericalla_TB();
  reg  [16:0]bus_TB;
  wire [31:0]dataOutJ_TB;
  wire ZFLG_TB;
  Jericalla jericalla(.bus(bus_TB), .dataOutJ(dataOutJ_TB), .ZFLG(ZFLG_TB));
  initial begin
    #100;
    bus_TB = 17'b00000000010001101;  
    #100;
    bus_TB = 17'b00010001010001101; 
    #100;
    bus_TB = 17'b00100010010001101; 
    #100;
    bus_TB = 17'b00110110010001101; 
    #100;
    bus_TB = 17'b01000111010001101; 
    #100;
    bus_TB = 17'b01011100010001101; 
    #100;   
  end
endmodule

// DirRAM - OP - DirROMA - DirROMB - RW  
// RW 1 - Escritura
// RW 0 - Lectura
