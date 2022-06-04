//等候时间计费模块
//可以实现输入每十分钟的费率计费
//输入的wait_fare_pulse由wait_count模块产生
/*
wait_fare_pulse		-> wait_count模块产生的计费脉冲
rst_n				-> 复位信号，下降沿有效
wait_en				-> 启用信号，开关闭合即有效
max					-> fare_total模块输出的计满信号
wait_fare_per_unit	-> 每十分钟的等待单价

wait_fare_bcd		-> 以BCD码输出的时长费
*/
module wait_fare (
	input wire wait_fare_pulse,
	input wire rst_n,
	input wire wait_en,
	input wire max,
	input wire [11:0] wait_fare_per_unit,
	
	output wire [15:0] wait_fare_bcd
);

reg [15:0] wait_fare = 16'b0;
//费用是否挤满的标志位
reg max_wait = 1'b0;
wire [15:0] fare_next;
wire max_fare;

//防止出现不定态，先给寄存器赋初值，后赋给wire类型变量
assign wait_fare_bcd = wait_fare;

always@(posedge wait_fare_pulse or negedge rst_n) begin
	if (!rst_n) begin
		wait_fare <= 16'd0;
		max_wait <= 1'b0;
	end
	//判断是否满足暂停计费条件（wait_en为低电平，max和max_wait为高电平）
	//满足则暂停计费
	else if(!wait_en || max || max_wait) begin
		wait_fare <= wait_fare;
	end
	//若有进位，则标志位置1
	else if(max_fare) begin
		max_wait <= 1'b1;
	end
	//若上述条件都不满足，则继续计费
	else begin
		wait_fare <= fare_next;
	end
end

//调用bcd_adder_4模块实现单位时长费和总价的相加
bcd_adder_4 wait_fare_adder (
.a		(wait_fare						),
.b		({4'b0000,wait_fare_per_unit}	),
.c_in	(1'b0							),
	
.sum	(fare_next						),
.c_out	(max_fare						)
);

endmodule
