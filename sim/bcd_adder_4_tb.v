/*
仿真思路：
	输入BCD码自加一来测试输出是不是正确的
*/
`timescale 1ns/1ns

module bcd_adder_4_tb();

reg [15:0] a;
reg [15:0] b;
reg c_in;

wire [15:0] sum;
wire c_out;

parameter CYCLE = 5'd20;
always #10 a = 	((sum[3:0]==4'd9) & (sum[7:4]!=4'd9)) ? (sum + 5'b1_0001 - 5'b0_1010 ) :
				((sum[3:0]==4'd9) & (sum[7:4]==4'd9) & (sum[11:8]!=4'd9)) ? (sum + 9'b1_0001_0001 - 9'b0_1010_1010) :
				((sum[3:0]==4'd9) & (sum[7:4]==4'd9) & (sum[11:8]==4'd9) & (sum[15:12]!=4'd9)) ? (sum + 13'b1_0001_0001_0001 - 13'b0_1010_1010_1010) :
				sum + 1'd1;


initial begin
		a = 16'h0000;
		b = 16'h0001;
		c_in = 1'b0;
		#(CYCLE * 100)
	$stop;
end

bcd_adder_4 bcd_adder_4_test (
.a			(a		), 
.b			(b		),
.c_in		(c_in	),
          
.sum		(sum	),
.c_out		(c_out	) 				
);

endmodule