`timescale 1ns/1ns

module fare_total_tb();

reg [15:0] distance_fare_bcd;
reg [15:0] wait_fare_bcd;
reg rst_n;

wire [15:0] fare_total_bcd;
wire max;

parameter CYCLE = 5'd20;


initial begin
	 distance_fare_bcd = 16'b0000_0000_0000_0000;
	 wait_fare_bcd = 16'b0000_0000_0000_0000;
	 rst_n = 1'b0;
	 #(CYCLE * 20);
	 rst_n = 1'b1;
	 distance_fare_bcd = 16'b0001_0001_0001_0001;
	 wait_fare_bcd = 16'b0001_0001_0001_0001;
	 #(CYCLE * 20);
	 distance_fare_bcd = 16'b0001_0001_0001_0001;
	 wait_fare_bcd = 16'b1000_1000_1000_1000;
	 #(CYCLE * 20);
	 distance_fare_bcd = 16'b0001_0001_0001_0001;
	 wait_fare_bcd = 16'b0100_1000_1000_1001;
	 #(CYCLE * 20);
	 distance_fare_bcd = 16'b0001_0001_0001_0001;
	 wait_fare_bcd = 16'b0110_1001_1001_1001;
	 #(CYCLE * 20);
	 distance_fare_bcd = 16'b0001_0001_0001_0001;
	 wait_fare_bcd = 16'b1000_1001_1001_1001;
	 #(CYCLE * 20);
	 $stop;
end

fare_total fare_total_test (
.distance_fare_bcd	(distance_fare_bcd	),
.wait_fare_bcd		(wait_fare_bcd		),
.rst_n				(rst_n				),
                   
.fare_total_bcd		(fare_total_bcd		),
.max				(max				)
);

endmodule
