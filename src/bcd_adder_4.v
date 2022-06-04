//四位BCD优先进位加法器
//调用了四个bcd_adder模块
//输入两个四位BCD码数字及前位进位
//输出四位BCD码和以及本位进位
/*
a	-> 输入的加数a
b	-> 输入的加数b
c_in	-> 输入的前位进位

sum	-> 输出的和
c_out	-> 输出的本位进位
*/
module bcd_adder_4 (
	input wire [15:0] a,
	input wire [15:0] b,
	input wire c_in,
	
	output wire [15:0] sum,
	output wire c_out
);

wire [3:0] a_1;
wire [3:0] a_2;
wire [3:0] a_3;
wire [3:0] a_4;
wire [3:0] b_1;
wire [3:0] b_2;
wire [3:0] b_3;
wire [3:0] b_4;
wire [3:0] a_o;
wire [3:0] b_o;
wire [3:0] c_o;
wire [3:0] d_o;
wire c_a;
wire c_b;
wire c_c;

//按位拆分加数和相加的和
assign a_1 = a [ 3:0 ];
assign a_2 = a [ 7:4 ];
assign a_3 = a [11:8 ];
assign a_4 = a [15:12];
assign b_1 = b [ 3:0 ];
assign b_2 = b [ 7:4 ];
assign b_3 = b [11:8 ];
assign b_4 = b [15:12];
assign sum [ 3:0 ] = a_o;
assign sum [ 7:4 ] = b_o;
assign sum [11:8 ] = c_o;
assign sum [15:12] = d_o;

//送入四个bcd_adder相加
bcd_adder bcd_adder_a (
.a	(a_1	), 
.b	(b_1	),
.c_in	(c_in	),
          
.sum	(a_o	),
.c_out	(c_a	) 				
);

bcd_adder bcd_adder_b (
.a	(a_2	), 
.b	(b_2	),
.c_in	(c_a	),
          
.sum	(b_o	),
.c_out	(c_b	) 				
);

bcd_adder bcd_adder_c (
.a	(a_3	), 
.b	(b_3	),
.c_in	(c_b	),
          
.sum	(c_o	),
.c_out	(c_c	) 				
);

bcd_adder bcd_adder_d (
.a	(a_4	), 
.b	(b_4	),
.c_in	(c_c	),
          
.sum	(d_o	),
.c_out	(c_out	) 				
);

endmodule
