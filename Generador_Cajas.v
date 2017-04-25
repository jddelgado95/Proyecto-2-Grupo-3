`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2017 03:18:54 PM
// Design Name: 
// Module Name: Generador_Cajas
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


module Generador_Cajas(
//wire [2:0] rgbswitches,
input wire [9:0] pixel_x, pixel_y, 
output reg [11:0] rgbtext,
input wire video_on,//señal que indica que se encuentra en la región visible de resolución 640x480
//input wire [9:0] pixel_x, pixel_y,//coordenadas xy de cada pixel
output wire graph_on,//flag que ayuda a pintar las letras
output wire alarm_on//flag que indica que es posible pintar la caja
//output reg [11:0] fig_RGB //12 bpp (4 bits para cada color)
);

//Declaración de constantes y señales
//Coordenas xy de la región visible
localparam HD = 640; // Display horizontal maximo
localparam VD = 480; // Display vertical maximo
//Coordenas xy de la región visible
//localparam MAX_X = 640;
//localparam MAX_Y = 480;

//Límites del recuadro para la hora (320x192)
localparam BOX_H_XL = 160; //Límite izquierdo
localparam BOX_H_XR = 479; //Límite derecho
localparam BOX_H_YT = 64;// Límite superior
localparam BOX_H_YB = 255;//Límite inferior

//Límites del recuadro para la fecha (256x96)
localparam BOX_F_XL = 48;//Límite izquierdo
localparam BOX_F_XR = 303;//Límite derecho
localparam BOX_F_YT = 352;//Límite superior
localparam BOX_F_YB = 447;//Límite inferior

//Límites del recuadro para el timer (256x96)
localparam BOX_T_XL = 336;//Límite izquierdo
localparam BOX_T_XR = 591;//Límite derecho
localparam BOX_T_YT = 352;//Límite superior
localparam BOX_T_YB = 447;//Límite inferior

//Límites del recuadro para de alarma "Alarma" (48x48)
localparam BOX_ALM_XL = 544;//Límite izquierdo
localparam BOX_ALM_XR = 591;//Límite derecho
localparam BOX_ALM_YT = 64;// Límite superior
localparam BOX_ALM_YB = 111;//Límite inferior

//Señales de salida de los objetos
wire BOX_HORA_on, BOX_FECHA_on, BOX_TIMER_on; //flags que se utilizaran para indicar donde es permitido pintar
wire [11:0] BOX_HORA_RGB, BOX_FECHA_RGB, BOX_TIMER_RGB, BOX_ALM_RGB;//salidas de los pintados 

/*Para rellenar con píxeles dentro de los límites 
de los objetos*/

//Recuadro HORA
assign BOX_HORA_on = (BOX_H_XL<=pixel_x)&&(pixel_x<=BOX_H_XR)
						&&(BOX_H_YT<=pixel_y)&&(pixel_y<=BOX_H_YB);//AND que indica las coordenadas de pintado de la caja de hora

assign BOX_HORA_RGB = 12'h0AA;//Turquesa oscuro le asigna el color a la caja, a la salida de los pixeles pintados

//Recuadro FECHA
assign BOX_FECHA_on = (BOX_F_XL<=pixel_x)&&(pixel_x<=BOX_F_XR)
						&&(BOX_F_YT<=pixel_y)&&(pixel_y<=BOX_F_YB);//AND que indica las coordenadas de pintado de la caja de fecha


assign BOX_FECHA_RGB = 12'h0AA;//Turquesa oscuro

//Recuadro TIMER
assign BOX_TIMER_on = (BOX_T_XL<=pixel_x)&&(pixel_x<=BOX_T_XR)
						&&(BOX_T_YT<=pixel_y)&&(pixel_y<=BOX_T_YB);//AND que indica las coordenadas de pintado de la caja del timer


assign BOX_TIMER_RGB = 12'h0AA;//Turquesa oscuro

//Recuadro RING
assign alarm_on = (BOX_ALM_XL<=pixel_x)&&(pixel_x<=BOX_ALM_XR)
						&&(BOX_ALM_YT<=pixel_y)&&(pixel_y<=BOX_ALM_YB);//AND que indica las coordenadas de pintado de la caja de la alarma


assign BOX_ALM_RGB = 12'hF00;//Rojo puro

//Multiplexar la salida RGB
always @*
begin	
	if(~video_on)
		rgbtext = 12'b0;//fondo negro
	
 else//Asigna que si se encuentra dentro de las coordenadas de pintado, entonces que la salida sea lo que se pinto
		if (BOX_HORA_on) rgbtext = BOX_HORA_RGB;
		else if (BOX_FECHA_on) rgbtext = BOX_FECHA_RGB;
		else if (BOX_TIMER_on) rgbtext = BOX_TIMER_RGB;
		else if (alarm_on) rgbtext = BOX_ALM_RGB;
		else rgbtext = 12'b0;//fondo negro
end

assign graph_on = BOX_HORA_on | BOX_FECHA_on | BOX_TIMER_on;
	
endmodule
