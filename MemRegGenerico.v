`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2017 06:46:25 PM
// Design Name: 
// Module Name: MemRegGenerico
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MemRegGenerico( //RgistroUniversal 
		input wire hold,
		input wire [7:0]in_rtc_dato, //entra el dato de la RTC
		input wire [7:0]in_count_dato,//Contador del dato 
		input wire clk, //system clock
		input wire reset, //system reset
		input wire chip_select, //Control data
		output wire [7:0]out_dato
    );
reg [7:0]reg_dato;
reg [7:0]next_dato;

//Secuencial
always@(negedge clk, posedge reset)
begin
	if(reset) reg_dato <= 0;
	else reg_dato <= next_dato;
end

//Combinacional
always@*
	begin
	if (~hold) begin 
	case(chip_select)
	1'b0: next_dato = in_rtc_dato;
	1'b1: next_dato = in_count_dato;
	endcase
	end
	else next_dato = reg_dato;
	end

assign out_dato = reg_dato;

endmodule
