//计算里程和价格
//输入里程单价
//计算距离
/*
ten_meter_pulse			-> 输入的十米脉冲
en						-> 输入的使能信号
rst_n					-> 输入的复位信号
wait_en					-> 输入的等待启用信号
distance_fare_per_pulse	-> 以BCD码输入的每脉冲的价格
s_fare					-> 输入的起步价
max						-> 输入的计满信号，由fare_total产生

distance_bcd			-> 以BCD码输出的距离
distance_fare_bcd		-> 以BCD码输出的里程费用
*/
module distance_fare (
	input wire ten_meter_pulse,
	input wire en,
	input wire rst_n,
	input wire wait_en,
	input wire [11:0] distance_fare_per_pulse,
	input wire [11:0] s_fare,
	input wire max,
	
	output wire [7:0] distance_bcd,
	output wire [15:0] distance_fare_bcd
);

//里程计满标志
reg max_distance;
//四位BCD码加法器输出费用计满信号
wire max_fare;
//下一个要加上的里程费用
wire [15:0] fare_next;
//里程费用计满标志
reg distance_fare_flag = 1'b0;
//当前的里程费用
reg [15:0] fare = 16'b0;
//当前的里程
reg [16:0] distance = 16'b0;

//结果输出，防止出现不定态，先给寄存器赋初值，后赋给wire类型变量
//因里程需要用两位数码管输出，故只将高二位输出
assign distance_bcd = distance[15:8];
assign distance_fare_bcd = fare;

always@(posedge ten_meter_pulse or negedge rst_n) begin
	//判断复位信号，为低电平则将里程和里程计满标志置0
	if (!rst_n) begin
		distance <= 16'd0;
		max_distance <= 1'b0;
	end
	//判断是否达到暂停计里程条件（en为低电平，且wait_en为高电平）
	//满足该条件则暂停计算里程
	//费用计满后里程继续计费，直到计满，价格计满信号不影响里程计算
	else if(!en || wait_en) begin
		distance <= distance;
	end
	//因未使用BCD加法器计算里程（里程每脉冲10m），所以里程为16位，判断是否超过9999，超过则将标志位置1
	else if (distance > 16'h9999) begin
		max_distance <= 1'b1;
	end
	//判断里程计满标志是否为1，为1则直接输出最大值
	else if (max_distance) begin
		distance <= 16'h9999;
	end
	else begin
		//直接用BCD码计数，没用加法器
		//将二进制数转换成BCD码
		distance <= ((distance[3:0]==4'd9) & (distance[7:4]!=4'd9)) ? (distance + 8'h11-8'h0a) :
					((distance[3:0]==4'd9) & (distance[7:4]==4'd9) & (distance[11:8]!=4'd9)) ? (distance + 12'h111-12'h0aa) :
					((distance[3:0]==4'd9) & (distance[7:4]==4'd9) & (distance[11:8]==4'd9) & (distance[15:12]!=4'd9)) ? (distance + 16'h1111-16'h0aaa) :
					distance + 1'd1;
	end
end

always@(posedge ten_meter_pulse or negedge rst_n) begin
	//判断复位信号，为低电平则将里程费和里程费计满标志置0
	if (!rst_n) begin
		fare <= 16'd0;
		distance_fare_flag <= 1'b0;
	end
	//判断是否达到暂停计费条件（en为低电平，且wait_en和max为高电平）
	//满足该条件则暂停计费
	else if(!en || max || wait_en) begin
		fare <= fare;
	end
	//判断加法器是否有本位进位，有则将费用设置为最大值并将费用计满标志置1
	else if (max_fare) begin
		fare <= 16'h9999;
		distance_fare_flag <= 1'b1;
	end
	//判断费用计满标志是否为1，满足则将费用设置为最大值99.99
	else if (distance_fare_flag) begin
		fare <= 16'h9999;
	end
	//判断是否在起步价包含的里程数范围内，在则输出起步价
	else if (distance < 16'h300) begin
		fare <= s_fare;
	end
	//若属于正常计费区间，则计算里程费用
	else begin
		fare <= fare_next;
	end
end

//调用bcd_adder_4模块实现里程费用计算
//调整了输入的每十米费用位宽，防止出现不定态
bcd_adder_4 distance_fare_adder (
.a		(fare								),
.b		({4'b0000,distance_fare_per_pulse}	),
.c_in	(1'b0								),
	
.sum	(fare_next							),
.c_out	(max_fare							)
);

endmodule
