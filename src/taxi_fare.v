//顶层模块
/*
clk						-> 输入的时钟信号
rst_n					-> 输入的复位信号，下降沿有效
wait_en					-> 启用信号，开关闭合即有效
en						-> 输入的使能信号
ten_meter_pulse			-> 输入的十米脉冲
distance_fare_per_pulse	-> 以BCD码输入的每十米脉冲的价格
s_fare					-> 输入的起步价
wait_fare_per_unit		-> 每十分钟的等待单价

fare_a					-> 输出的总价第1位
fare_b					-> 输出的总价第2位
fare_c					-> 输出的总价第3位
fare_d					-> 输出的总价第4位
distance_a				-> 输出的里程第1位
distance_b				-> 输出的里程第2位
*/
module taxi_fare (
	input wire clk,
	input wire rst_n,
	input wire wait_en,
	input wire en,
	input wire [11:0] distance_fare_per_pulse,
	input wire [11:0] s_fare,
	input wire ten_meter_pulse,
	input wire [11:0] wait_fare_per_unit,
	
	output wire [7:0] fare_a,
	output wire [7:0] fare_b,
	output wire [7:0] fare_c,
	output wire [7:0] fare_d,
	output wire [7:0] distance_a,
	output wire [7:0] distance_b
);

//设置两个参数MIN_COUNT和WAIT_COUNT，方便后续调整和仿真时覆写
//每分钟包含3_000_000_000个时钟周期，但是这里只检测了上跳沿
//所以是每1_500_000_000个周期（半分钟）翻转一次输出脉冲信号
parameter MIN_COUNT = 32'd1_500_000_000;
//每十分钟含有10个时钟周期，但是这里只检测了上跳沿
//所以是每五个周期（五分钟）翻转一次输出脉冲信号
parameter WAIT_COUNT = 4'd5;
wire min_pulse;
wire max;
wire wait_fare_pulse;
wire [15:0] wait_fare_bcd;
wire [7:0] distance_bcd;
wire [15:0] distance_fare_bcd;
wire [15:0] fare_total_bcd;

freq_div#(
	.MIN_COUNT(MIN_COUNT)
) u_freq_div (
.clk		(clk		),
.rst_n		(rst_n		),
.en			(en			),
.max		(max		),
             
.min_pulse	(min_pulse	)
);

wait_count#(
	.WAIT_COUNT(WAIT_COUNT)
) 
u_wait_count (
.min_pulse			(min_pulse		),
.rst_n				(rst_n			),
                   
.wait_fare_pulse	(wait_fare_pulse)
);

wait_fare u_wait_fare (
.wait_fare_pulse		(wait_fare_pulse	),
.rst_n					(rst_n				),
.max					(max				),
.wait_en				(wait_en			),
.wait_fare_per_unit		(wait_fare_per_unit ),
                      
.wait_fare_bcd			(wait_fare_bcd		)
);

distance_fare u_distance_fare (
.ten_meter_pulse			(ten_meter_pulse		),
.en							(en						),
.max						(max					),
.rst_n						(rst_n					),
.wait_en					(wait_en				),
.distance_fare_per_pulse	(distance_fare_per_pulse),
.s_fare						(s_fare					),
                         
.distance_bcd				(distance_bcd			),
.distance_fare_bcd			(distance_fare_bcd		)
);

fare_total u_fare_total (
.distance_fare_bcd	(distance_fare_bcd	),
.wait_fare_bcd		(wait_fare_bcd		),
                   
.fare_total_bcd		(fare_total_bcd		),
.max				(max				)
);

seg_disp u_seg_disp (
.fare_total_bcd	(fare_total_bcd	),
.distance_bcd	(distance_bcd	),
.max			(max			),
                
.fare_a			(fare_a			),
.fare_b			(fare_b			),
.fare_c			(fare_c			),
.fare_d			(fare_d			),
.distance_a		(distance_a		),
.distance_b		(distance_b		)
);

endmodule
