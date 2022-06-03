//等候时间计数模块
//十分钟输出一个计费脉冲
module wait_count (
	input wire min_pulse,
	input wire rst_n,
	
	output wire wait_fare_pulse
);

parameter WAIT_COUNT = 4'd10;

reg [3:0] counter;
reg wait_fare = 1'd0;
assign wait_fare_pulse = wait_fare;

always@(posedge min_pulse or negedge rst_n) begin
	if (!rst_n) begin
		counter <= WAIT_COUNT;
		wait_fare <= 1'd0;
	end
	else if (counter == 1'd1) begin
		wait_fare <= ~wait_fare;
		counter <= WAIT_COUNT;
	end
	else begin
		counter <= counter - 1'd1;
	end
end

endmodule
