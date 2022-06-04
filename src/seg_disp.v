//显示模块
//将输出的BCD码显示在七段数码管上
//调用了留个bcd_seg_disp模块显示
/*
fare_total_bcd	-> 输入的总价格信号，由fare_total模块产生
distance_bcd	-> 输入的里程信号，由distance_fare模块产生
max				-> 输入的计满信号，由fare_total模块产生

fare_a			-> 输出的总价第1位
fare_b			-> 输出的总价第2位
fare_c			-> 输出的总价第3位
fare_d			-> 输出的总价第4位
distance_a		-> 输出的里程第1位
distance_b		-> 输出的里程第2位
*/
module seg_disp (
	input wire [15:0] fare_total_bcd,
	input wire [7:0] distance_bcd,
	input wire max,
	
	output wire [7:0] fare_a,
	output wire [7:0] fare_b,
	output wire [7:0] fare_c,
	output wire [7:0] fare_d,
	output wire [7:0] distance_a,
	output wire [7:0] distance_b
);

//调整价格显示格式为xx.xx 里程显示格式为xx
//控制数码管上的小数点亮灭，开发板使用共阳极数码管
//1灭0亮
assign fare_a[0] = 1'b1;
assign fare_b[0] = 1'b1;
assign fare_c[0] = 1'b0;
assign fare_d[0] = 1'b1;
assign distance_a[0] = 1'b1;
assign distance_b[0] = 1'b1;

//调用了六个bcd_seg_disp模块进行译码
//按位拆分数据并译成七段译码器的信号
//价格百分位显示
bcd_seg_disp u_fare_a(
.in		(fare_total_bcd[3:0]),
.max	(max				),

.out	(fare_a[7:1]		)
);

//价格十分位显示
bcd_seg_disp u_fare_b(
.in		(fare_total_bcd[7:4]),
.max	(max				),

.out	(fare_b[7:1]		)
);

//价格个位显示
bcd_seg_disp u_fare_c(
.in		(fare_total_bcd[11:8]	),
.max	(max					),

.out	(fare_c[7:1]			)
);

//价格十位显示
bcd_seg_disp u_fare_d(
.in		(fare_total_bcd[15:12]	),
.max	(max					),

.out	(fare_d[7:1]			)
);

//里程个位显示
bcd_seg_disp u_distance_a(
.in		(distance_bcd[3:0]	),
.max	(max				),

.out	(distance_a[7:1]	)
);

//里程十位显示
bcd_seg_disp u_distance_b(
.in		(distance_bcd[7:4]	),
.max	(max				),

.out	(distance_b[7:1]	)
);

endmodule
