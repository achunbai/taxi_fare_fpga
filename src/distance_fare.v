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

reg max_distance;
wire max_fare;
wire [15:0] fare_next;
//里程费用计满标志
reg distance_fare_flag = 1'b0;
reg [15:0] fare = 16'b0;
reg [16:0] distance = 16'b0;

assign distance_bcd = distance[15:8];
assign distance_fare_bcd = fare;

always@(posedge ten_meter_pulse or negedge rst_n) begin
	if (!rst_n) begin
		distance <= 16'd0;
		max_distance <= 1'b0;
	end
	//费用计满后里程继续计费，直到计满
	else if(!en || wait_en) begin
		distance <= distance;
	end
	else if (distance > 16'h9999) begin
		max_distance <= 1'b1;
	end
	else if (max_distance) begin
		distance <= 16'h9999;
	end
	else begin
		//直接用BCD码计数，没用加法器
		distance <= ((distance[3:0]==4'd9) & (distance[7:4]!=4'd9)) ? (distance + 8'h11-8'h0a) :
					((distance[3:0]==4'd9) & (distance[7:4]==4'd9) & (distance[11:8]!=4'd9)) ? (distance + 12'h111-12'h0aa) :
					((distance[3:0]==4'd9) & (distance[7:4]==4'd9) & (distance[11:8]==4'd9) & (distance[15:12]!=4'd9)) ? (distance + 16'h1111-16'h0aaa) :
					distance + 1'd1;
	end
end

always@(posedge ten_meter_pulse or negedge rst_n) begin
	if (!rst_n) begin
		fare <= 16'd0;
		distance_fare_flag <= 1'b0;
	end
	else if(!en || max || wait_en) begin
		fare <= fare;
	end
	else if (max_fare) begin
		fare <= 16'h9999;
		distance_fare_flag <= 1'b1;
	end
	else if (distance_fare_flag) begin
		fare <= 16'h9999;
	end
	else if (distance < 16'h300) begin
		fare <= s_fare;
	end
	else begin
		fare <= fare_next;
	end
end

bcd_adder_4 distance_fare_adder (
.a		(fare								),
.b		({4'b0000,distance_fare_per_pulse}	),
.c_in	(1'b0								),
	
.sum	(fare_next							),
.c_out	(max_fare							)
);

endmodule
