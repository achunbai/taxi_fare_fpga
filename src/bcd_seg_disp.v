//BCD七段数码管显示译码
//共阳极
//MAX信号为高电平时输出9
/*
in	-> 输入的BCD码
max	-> 输入的计满信号，由fare_total模块产生

out	-> 输出的七段数码管对应的数字
*/
module bcd_seg_disp (
	input wire [3:0] in,
	input wire max,
	
	output reg [6:0] out
);

always@(*)begin
	//如果计满信号为高电平，则直接输出9
	if (max) begin
		out <= 7'b0010000;
	end
	//输入0-9十种BCD码判断，并输出对应的七段数码管显示信号
	else begin
		case (in)
			4'b0000:
				out <= 7'b1000000;
			4'b0001:
				out <= 7'b1111001;
			4'b0010:
				out <= 7'b0100100;
			4'b0011:
				out <= 7'b0110000;
			4'b0100:
				out <= 7'b0011001;
			4'b0101:
				out <= 7'b0010010;
			4'b0110:
				out <= 7'b0000010;
			4'b0111:
				out <= 7'b1111000;
			4'b1000:
				out <= 7'b0000000;
			4'b1001:
				out <= 7'b0010000;
			default:
				out <= 7'b1111111;
		endcase
	end
end

endmodule
