//总价计算模块
//调用了四个bcd_adder模块相加
//实现总价的计算，如果总价达到了99.99，max输出高电平
/*
distance_fare_bcd	-> 输入的里程费，由wait_fare模块产生
wait_fare_bcd		-> 输入的时长费，由distance_fare模块产生

fare_total_bcd		-> 输出的总价格
max					-> 输出的计满信号
*/
module fare_total (
	input wire [15:0] distance_fare_bcd,
	input wire [15:0] wait_fare_bcd,
	
	output wire [15:0] fare_total_bcd,
	output wire max
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

//将输入两个数字按位拆分
//拆成单独的百分位（a），十分位（b），个位（c），十位（d）
assign a_1 = distance_fare_bcd [ 3:0 ];
assign a_2 = distance_fare_bcd [ 7:4 ];
assign a_3 = distance_fare_bcd [11:8 ];
assign a_4 = distance_fare_bcd [15:12];
assign b_1 = wait_fare_bcd [ 3:0 ];
assign b_2 = wait_fare_bcd [ 7:4 ];
assign b_3 = wait_fare_bcd [11:8 ];
assign b_4 = wait_fare_bcd [15:12];
assign fare_total_bcd [ 3:0 ] = a_o;
assign fare_total_bcd [ 7:4 ] = b_o;
assign fare_total_bcd [11:8 ] = c_o;
assign fare_total_bcd [15:12] = d_o;

//调用bcd_adder模块相加
//百分位上的数据相加
bcd_adder bcd_adder_a (
.a			(a_1	), 
.b			(b_1	),
.c_in		(1'b0	),
          
.sum		(a_o	),
.c_out		(c_a	) 				
);

//十分位上的数据相加
bcd_adder bcd_adder_b (
.a			(a_2	), 
.b			(b_2	),
.c_in		(c_a	),
          
.sum		(b_o	),
.c_out		(c_b	) 				
);

//个位上的数据相加
bcd_adder bcd_adder_c (
.a			(a_3	), 
.b			(b_3	),
.c_in		(c_b	),
          
.sum		(c_o	),
.c_out		(c_c	) 				
);

//十位上的数据相加
bcd_adder bcd_adder_d (
.a			(a_4	), 
.b			(b_4	),
.c_in		(c_c	),
          
.sum		(d_o	),
.c_out		(max	) 				
);

endmodule
