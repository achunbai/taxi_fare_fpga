/*
仿真思路：
	测试显示输出是不是对劲的
*/
`timescale 1ns/1ns

module seg_disp_tb();

reg [15:0] fare_total_bcd;
reg [7:0] distance_bcd;

wire [7:0] fare_a;
wire [7:0] fare_b;
wire [7:0] fare_c;
wire [7:0] fare_d;
wire [7:0] distance_a;
wire [7:0] distance_b;


initial begin
    fare_total_bcd = 16'b0000_0000_0000_0000;
	 distance_bcd = 8'b0000_0000;
	 #20
    fare_total_bcd = 16'b0001_0001_0001_0001;
	 distance_bcd = 8'b0001_0001;
	 #20
	 fare_total_bcd = 16'b0011_0011_0011_0011;
	 distance_bcd = 8'b0011_0011;
	 #20
	 fare_total_bcd = 16'b0100_0100_0100_0100;
	 distance_bcd = 8'b0100_0100;
	 #20
	 fare_total_bcd = 16'b0101_0101_0101_0101;
	 distance_bcd = 8'b0101_0101;
	 #20
	 fare_total_bcd = 16'b0110_0110_0110_0110;
	 distance_bcd = 8'b0110_0110;
	 #20
	 fare_total_bcd = 16'b0111_0111_0111_0111;
	 distance_bcd = 8'b0111_0111;
	 #20
	 fare_total_bcd = 16'b1000_1000_1000_1000;
	 distance_bcd = 8'b1000_1000;
	 #20
	 fare_total_bcd = 16'b1001_1001_1001_1001;
	 distance_bcd = 8'b1001_1001;
	 #20
	 fare_total_bcd = 16'b1011_1011_1011_1011;
	 distance_bcd = 8'b1011_1011;
	 #20
	 fare_total_bcd = 16'b1111_1111_1111_1111;
	 distance_bcd = 8'b1111_1111;
	 #20
	 $stop;
	 end
	 
seg_disp seg_disp_test (
.fare_total_bcd	(fare_total_bcd	),
.distance_bcd	(distance_bcd	),
                
.fare_a			(fare_a			),
.fare_b			(fare_b			),
.fare_c			(fare_c			),
.fare_d			(fare_d			),
.distance_a		(distance_a		),
.distance_b		(distance_b		)
);

endmodule
