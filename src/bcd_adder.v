//一位BCD加法器
//输入a，b两个加数和前位进位，输出和以及本位进位
/*
a	-> 输入的加数a
b	-> 输入的加数b
c_in	-> 输入的前位进位

sum	-> 输出的和
c_out	-> 输出的本位进位
*/
module bcd_adder (
	input	wire [3:0] a, 
	input	wire [3:0] b,
	input 	wire c_in,

	output wire [3:0] sum,
	output wire c_out
);

//计算ab两数之和
wire [4:0] ab_sum = {1'b0, a} + {1'b0, b} + {4'b0, c_in};
//将两数之和转换成bcd码
assign sum = (ab_sum[3:0] > 4'd9) ? (ab_sum[3:0]-4'd10) : ab_sum[3:0];
//优先进位计算
assign c_out = 	(ab_sum[4]) ? 1'b1 : 
		((ab_sum[3:0] > 4'd9) ? 1'b1 : 1'b0);

endmodule
