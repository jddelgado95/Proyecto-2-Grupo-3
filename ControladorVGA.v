`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2017 07:28:31 PM
// Design Name: 
// Module Name: ControladorVGA
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


module ControladorVGA(
input wire clock, reset,
input wire [3:0] digit0_HH, digit1_HH, digit0_MM, digit1_MM, digit0_SS, digit1_SS,//
digit0_DAY, digit1_DAY, digit0_MES, digit1_MES, digit0_YEAR, digit1_YEAR,//
digit0_HH_T, digit1_HH_T, digit0_MM_T, digit1_MM_T, digit0_SS_T, digit1_SS_T,//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
input wire AM_PM,//Entrada para conocer si en la información de hora se despliega AM o PM
//input wire [7:0] dia_semana,//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
input wire [2:0]config_mode,//Cuatro estados del modo configuración
input wire [1:0] cursor_location,//Marca la posición del cursor en modo configuración
input wire formato_hora,//Señal que indica si la hora esta en formato 12 hrs o 24 hrs (0->24 hrs)
input wire estado_alarma,
output wire hsync,vsync,
output wire [11:0] RGB
//output wire pixel_tick
);

wire [9:0] pixel_x,pixel_y;
wire video_on; 
wire pixel_tick;
reg [11:0] RGB_reg, RGB_next;
wire text_on, graph_on;
wire [11:0] fig_RGB, text_RGB;
wire BOX_RING_on;
wire RING_on, AMPM_on;

//Para generar parpadeo de 4 Hz
// Bits del contador para generar una señal periódica de (2^N)*10ns
localparam N =24;//~3Hz

reg [N-1:0] blink_reg;
reg blink;

localparam N_cursor = 25;//~2Hz

reg [N_cursor-1:0] blink_cursor_reg;
reg blink_cursor;

//Instanciaciones

Sincronizador_vga Instancia //timing_generator_VGA Instancia_timing_generator_VGA
(
.clk(clock),
.reset(reset),
.hsync(hsync),
.vsync(vsync),
.video_on(video_on),
.p_tick(pixel_tick),
.pixel_x(pixel_x), 
.pixel_y(pixel_y)
);

Generador_Cajas Instancia2 //generador_figuras Instancia_generador_figuras
(
.video_on(video_on),//señal que indica que se encuentra en la región visible de resolución 640x480
.pixel_x(pixel_x), 
.pixel_y(pixel_y),//coordenadas xy de cada pixel
.flag_print(graph_on),
.alarm_on(BOX_RING_on),//Señal que indica la localización del recuadro de RING
.rgbtext(fig_RGB) //12 bpp (4 bits para cada color)
);

Carac Instancia3//generador_caracteres Instancia_generador_caracteres
(
.clk(clock),
.HORAS0(digit0_HH), .HORAS1(digit1_HH), .MINUTOS0(digit0_MM), .MINUTOS1(digit1_MM), .SEGUNDOS0(digit0_SS), .SEGUNDOS1(digit1_SS),//
.DIA0(digit0_DAY), .DIA1(digit1_DAY), .MES0(digit0_MES), .MES1(digit1_MES), .YEAR0(digit0_YEAR), .YEAR1(digit1_YEAR),//
.HORATIMER0(digit0_HH_T),.HORATIMER1(digit1_HH_T), .MINUTOSTIMER0(digit0_MM_T), .MINUTOSTIMER1(digit1_MM_T), .SEGUNDOSTIMER0(digit0_SS_T), .SEGUNDOSTIMER1(digit1_SS_T),//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
.AM_PM(AM_PM),//Entrada para conocer si en la información de hora se despliega AM o PM
//.dia_semana(dia_semana),//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
.config_mode(config_mode),//1-bit: OR de los tres estados del modo configuración
.LOCATION(cursor_location),//Marca la posición del cursor en modo configuración
.pixel_x(pixel_x), .pixel_y(pixel_y),
.BLINK(blink_cursor),
.text_on(text_on), //7 "textos" en total en pantalla (bandera de indica que se debe escribir texto)
.RING_on(RING_on), .AMPM_on(AMPM_on), //Localización de esos respectivos textos
.text_RGB(text_RGB) //12 bpp (4 bits para cada color)
);

//=============================================
// Contador para generar pulso de parpadeo
//=============================================

always @(posedge clock, posedge reset)
begin
	if (reset)begin blink_reg <= 0; blink <= 0; end
	
	else
	begin
		if (blink_reg == 24'd16666666)
			begin
			blink_reg <= 0;
			blink <= ~blink;
			end
		else
			blink_reg <= blink_reg + 1'b1;
	end
end

//Parpadeo cursor
always @(posedge clock, posedge reset)
begin
	if (reset)begin blink_cursor_reg <= 0; blink_cursor <= 0; end
	
	else
	begin
		if (blink_cursor_reg == 25'd24999999)
			begin
			blink_cursor_reg <= 0;
			blink_cursor <= ~blink_cursor;
			end
		else
			blink_cursor_reg <= blink_cursor_reg + 1'b1;
	end
end		
//____________________________________________________________________________________________________________

//Multiplexión entre texto o figuras

/*Cuando haya que controlar la aparición
de RING o AM/PM (el cursor se controla desde antes) se modifica esta parte nada más
ver pg.365 Pong (en ese caso se agrega entrada IRQ y formato_HORA) */

always@*
begin

	if(~video_on)
	RGB_next = "0";//Fuera la pantalla visible
	
	else
		if(text_on) RGB_next = text_RGB;
		else if (AMPM_on && formato_hora) RGB_next = text_RGB;
		else if(graph_on) RGB_next = fig_RGB;
		else if (BOX_RING_on && estado_alarma && blink) RGB_next = fig_RGB;
		else if (RING_on && estado_alarma && blink) RGB_next = text_RGB;
		else RGB_next = 12'h000;//Fondo negro
end

always @(posedge clock)
if (pixel_tick) RGB_reg <= RGB_next;

//Salida al monitor VGA
assign RGB = RGB_reg;
endmodule
