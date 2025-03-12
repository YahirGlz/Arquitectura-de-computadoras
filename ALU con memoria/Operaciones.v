
module AND(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A&B;
endmodule

module OR(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A|B;
endmodule

module ADD(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A+B;
endmodule

module SUBS(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A-B;
endmodule

module SOLT(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A<B?1:0;
endmodule

module NOR(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = ~(A|B);
endmodule





