`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2017 02:04:11 PM
// Design Name: 
// Module Name: DriverTraduc_RTC_Reg
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


module DriverTraduc_RTC_Reg(
    input reset,
input [7:0] direc_rtc,//addr_rtc,
output reg [3:0] direc_memlocal//addr_mem_local
);
//recibe la direccion generada de la maquina de estados general para enviar la direccion de memoria local a logica_distributir_dato_rtc_registros
 always@*
 begin
 if (reset) direc_memlocal = 4'b1111;
 else begin
 case (direc_rtc)
    8'h21: direc_memlocal = 4'b0000;
    8'h22: direc_memlocal = 4'b0001;
    8'h23: direc_memlocal = 4'b0010;
    8'h24: direc_memlocal = 4'b0011;
    8'h25: direc_memlocal = 4'b0100;
    8'h26: direc_memlocal = 4'b0101;
    8'h27: direc_memlocal = 4'b0110;
    8'h41: direc_memlocal = 4'b0111;
    8'h42: direc_memlocal = 4'b1000;
    8'h43: direc_memlocal = 4'b1001;
    default: direc_memlocal = 4'b1111;
    endcase
    end
 end

endmodule