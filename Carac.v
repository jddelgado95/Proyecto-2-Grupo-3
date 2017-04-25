`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2017 04:09:05 PM
// Design Name: 
// Module Name: Carac
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


module Carac(
input wire clk,
input wire [3:0] HORAS0, HORAS1, MINUTOS0, MINUTOS1, SEGUNDOS0, SEGUNDOS1,DIA0, DIA1, MES0, MES1, YEAR0, YEAR1,HORATIMER0, HORATIMER1, MINUTOSTIMER0, MINUTOSTIMER1,SEGUNDOSTIMER0, SEGUNDOSTIMER1,//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
input wire AM_PM,//Entrada para conocer si en la información de hora se despliega AM o PM
input wire [2:0] config_mode,//Cuatro estados del modo configuración
input wire [1:0] LOCATION,//Marca la posición del cursor en modo configuración
input wire [9:0] pixel_x, pixel_y,//Coordenada de cada pixel
input wire BLINK,
output wire text_on, //10 "textos" en total en pantalla (bandera que indica que se debe escribir texto)
output wire  RING_on, AMPM_on, //Localización de esos respectivos textos
output reg [11:0] text_RGB //12 bpp (4 bits para cada color)
);

//Declaración de señales

//Font ROM (caracteres 8x16)
wire [10:0] rom_addr; //ASCII 7-bits + Fila 4-bits
reg [6:0] char_addr; //ASCII 7-bits
reg [3:0] row_addr; //Direccion de fila del patrón de caracter en particular
reg [2:0] bit_addr; //Columna del pixel particular de un patrón de caracter
wire [7:0] font_word;//Fila de pixeles del patrón de caracter en particular
wire font_bit;//1 pixel del font_word específicado por bit_addr

//Direcciones "auxiliares" para cada uno de los 10 textos a mostrar
reg [6:0] char_addr_HORA, char_addr_digHORA, char_addr_digFECHA,char_addr_FECHA, char_addr_TIMER, char_addr_digTIMER, char_addr_RING, char_addr_AMPM, char_addr_cursor;//char_addr_DIA
wire [3:0] row_addr_HORA, row_addr_digHORA, row_addr_digFECHA,row_addr_FECHA, row_addr_TIMER,row_addr_digTIMER, row_addr_RING, row_addr_AMPM, row_addr_cursor; //row_addr_DIA,
wire [2:0] bit_addr_HORA, bit_addr_digHORA, bit_addr_digFECHA, bit_addr_FECHA,  bit_addr_TIMER, bit_addr_digTIMER, bit_addr_RING, bit_addr_AMPM,  bit_addr_cursor;//bit_addr_LOGO, bit_addr_DIA,
wire HORA_on, digHORA_on, digFECHA_on,  TIMER_on, digTIMER_on,FECHA_on; //DIA_on
//reg cursor_on;
	
//Instanciación de la font ROM
Font_ROM Instancia_font_unit (.clk(clk),.addr(rom_addr),.data(font_word));
//Descripción de comportamiento

//1.Palabra HORA (tamaño de fuente 32x64)
//Asigna de donde a donde se va a pintar la palabra HORA
assign HORA_on = (pixel_y[9:6]==1)&&(pixel_x[9:5]>=8)&&(pixel_x[9:5]<=11);//1,8,11 Entre cuales coordenadas se encuentra HORA
assign row_addr_HORA = pixel_y[5:2];
assign bit_addr_HORA = pixel_x[4:2];

always@*
begin
	case(pixel_x[6:5]) //Asigna 2 bits del pixel x para la palabra hora 
	//Asigna las direcciones de la font ROM
	   2'b00: char_addr_HORA = 7'h48;//H
	   2'b01: char_addr_HORA = 7'h4f;//O
	   2'b10: char_addr_HORA = 7'h52;//R
	   2'b11: char_addr_HORA = 7'h41;//A
	   //default: char_addr_HORA = 7'h0AA;//Espacio en turquesa
	endcase
	
end

//2.Dígitos para representar la HORA(tamaño de fuente 32x64)
//Aqui asigna de donde a donde se van a pintar los hh,mm,ss de la HORA 
assign digHORA_on = (pixel_y[9:6]==2)&&(pixel_x[9:5]>=6)&&(pixel_x[9:5]<=13);//2
assign row_addr_digHORA = pixel_y[5:2];
assign bit_addr_digHORA = pixel_x[4:2];

always@*
begin
	case(pixel_x[7:5])
	   3'b110: char_addr_digHORA = {3'b011, HORAS1};//(decenas hh)
	   3'b111: char_addr_digHORA = {3'b011, HORAS0};//(unidades hh)
	   3'b000: char_addr_digHORA = 7'h3a;//pinta los dos puntos de la font ROM
	   3'b001: char_addr_digHORA = {3'b011, MINUTOS1};//(decenas mm)
	   3'b010: char_addr_digHORA = {3'b011, MINUTOS0};//(unidades mm)
	   3'b011: char_addr_digHORA = 7'h3a;// pinta los dos puntos de la font ROM
	   3'b100: char_addr_digHORA = {3'b011, SEGUNDOS1};//(decenas ss)
	   3'b101: char_addr_digHORA = {3'b011, SEGUNDOS0};//(unidades ss)
	endcase
	
end

//3.Dígitos para representar la FECHA(tamaño de fuente 16x32)
//Asigna de donde a donde se va a pintar los dias, mes y a;o de la fecha
assign digFECHA_on = (pixel_y[9:5]==12)&&(pixel_x[9:4]>=7)&&(pixel_x[9:4]<=14);//12
assign row_addr_digFECHA = pixel_y[4:1];
assign bit_addr_digFECHA = pixel_x[3:1];

always@*
begin
	case(pixel_x[6:4])
	   3'b111: char_addr_digFECHA = {3'b011, DIA1};//(decenas DIA)
	   3'b000: char_addr_digFECHA = {3'b011, DIA0};//(unidades DIA)
	   3'b001: char_addr_digFECHA = 7'h2f;// pinta el slash de la Font ROM
	   3'b010: char_addr_digFECHA = {3'b011, MES1};//(decenas MES)
	   3'b011: char_addr_digFECHA = {3'b011, MES0};//(unidades MES)
	   3'b100: char_addr_digFECHA = 7'h2f;//"/"
	   3'b101: char_addr_digFECHA = {3'b011, YEAR1};//(decenas AÑO)
	   3'b110: char_addr_digFECHA = {3'b011, YEAR0};//(unidades	AÑO)
	endcase	
end

//4.Palabra FECHA(tamaño de fuente 16x32)
//Asigna de donde a donde se pinta la palabra FECHA 
assign FECHA_on = (pixel_y[9:5]==10)&&(pixel_x[9:4]>=7)&&(pixel_x[9:4]<=15);//10
assign row_addr_FECHA = pixel_y[4:1];
assign bit_addr_FECHA = pixel_x[3:1];

always@*
begin
	case(pixel_x[7:4])
	   4'h7: char_addr_FECHA = 7'h46;//F
	   4'h8: char_addr_FECHA = 7'h45;//E
	   4'h9: char_addr_FECHA = 7'h43;//C
	   4'ha: char_addr_FECHA = 7'h48;//H
	   4'hb: char_addr_FECHA = 7'h41;//A
	   default: char_addr_FECHA = 7'h00;//Espacio en blanco
	endcase	
end


//5.Palabra TEMPO(tamaño de fuente 16x32)
//Asigna de donde a donde se pinta la palabra TEMPO
assign TIMER_on = (pixel_y[9:5]==10)&&(pixel_x[9:4]>=27)&&(pixel_x[9:4]<=31); //27 , 31
assign row_addr_TIMER = pixel_y[4:1];
assign bit_addr_TIMER = pixel_x[3:1];

always@*
begin
	case(pixel_x[6:4])
	   3'b011: char_addr_TIMER = 7'h54;//T
	   3'b100: char_addr_TIMER = 7'h45;//E
	   3'b101: char_addr_TIMER = 7'h4d;//M
	   3'b110: char_addr_TIMER = 7'h50;//P
	   3'b111: char_addr_TIMER = 7'h4f;//O
	   default: char_addr_TIMER = 7'h00;//Espacio en blanco
	endcase	
end

//6.Dígitos para la cuenta del TIMER(tamaño de fuente 16x32)
//Asigna de donde a donde se pintan los numeros que conforman el TEMPO
assign digTIMER_on = (pixel_y[9:5]==12)&&(pixel_x[9:4]>=25)&&(pixel_x[9:4]<=32);//25,32
assign row_addr_digTIMER = pixel_y[4:1];
assign bit_addr_digTIMER = pixel_x[3:1];

always@*
begin
	case(pixel_x[6:4])
	   3'b001: char_addr_digTIMER = {3'b011, HORATIMER1};//(decenas hh tempo)
	   3'b010: char_addr_digTIMER = {3'b011, HORATIMER0};//(unidades hh tempo)
	   3'b011: char_addr_digTIMER = 7'h3a;//:
	   3'b100: char_addr_digTIMER = {3'b011, MINUTOSTIMER1};//(decenas mm tempo)
	   3'b101: char_addr_digTIMER = {3'b011, MINUTOSTIMER0};//(unidades mm tempo)
	   3'b110: char_addr_digTIMER = 7'h3a;//:
	   3'b111: char_addr_digTIMER = {3'b011, SEGUNDOSTIMER1};//(decenas ss tempo)
	   3'b000: char_addr_digTIMER = {3'b011, SEGUNDOSTIMER0};//(decenas ss tempo)
	endcase	
end

//7.Palabra RING(tamaño de fuente 32x64)
assign RING_on = (pixel_y[9:6]==2)&&(pixel_x[9:5]>=16)&&(pixel_x[9:5]<=19);
assign row_addr_RING = pixel_y[5:2];
assign bit_addr_RING = pixel_x[4:2];

always@*
begin
	case(pixel_x[6:5])
	   2'b00: char_addr_RING = 7'h54;//T
	   2'b01: char_addr_RING = 7'h49;//I
	   2'b10: char_addr_RING = 7'h4d;//M
	   2'b11: char_addr_RING = 7'h45;//E
	endcase	
end

//8.Palabra AM o PM(tamaño de fuente 16x32)
//Asigna de donde a donde se va a pintar la palabra AM/PM
assign AMPM_on = (pixel_y[9:5]==1)&&(pixel_x[9:4]>=26)&&(pixel_x[9:4]<=27);
assign row_addr_AMPM = pixel_y[4:1];
assign bit_addr_AMPM = pixel_x[3:1];

always@*
begin
	case(pixel_x[4])
	   1'b0:
	       begin
	           case(AM_PM)//AM_PM = 0: se escribe AM
	               1'b0: char_addr_AMPM = 7'h41;//A
	               1'b1: char_addr_AMPM = 7'h50;//P
	           endcase
	       end
	   1'b1: char_addr_AMPM = 7'h4d;//M
	endcase	
end


//Multiplexar las direcciones para font ROM y salida RBG
always @*
begin
text_RGB = 12'b0;//Fondo negro
//Asigna las salidas a los cables correspondientes, con sus respectivas direcciones para las letras a pintar como 
//para los digitos 
	if(HORA_on) 
		begin
		      char_addr = char_addr_HORA;
		      row_addr = row_addr_HORA;
              bit_addr = bit_addr_HORA;
			  if(font_bit) text_RGB = 12'h2F2; //Verde
		end
	
	else if(digHORA_on)
		begin
		      char_addr = char_addr_digHORA;
              row_addr = row_addr_digHORA;
              bit_addr = bit_addr_digHORA;
			  //(0: Segundos de la hora, 1: Minutos de la hora, 2: Horas de la Hora, 3: Ubicación de AM/PM)
			  //Evalúa que se está configurando (1: config.hora)
			  if(font_bit) text_RGB = 12'hFFF; //Blanco
			  else if ((BLINK)&&(~font_bit)&&(config_mode == 1)&&(pixel_y[9:6]==2)&&(pixel_x[9:5]>=6)&&(pixel_x[9:5]<=7)&&(LOCATION==2)) 
			  text_RGB = 12'h000;//Hace un cursor si se está en modo configuración, empieza a parpadear entre el color de fondo y el negro asignado
			 //si se cumple la condicion de las variables parpadeo, font bit, la configuracion en alto, y las coordenadas. 
			 //Asi al estar en localizacion 2 (las horas de la Hora), se va a poder cambiar. 
			  else if ((BLINK)&&(~font_bit)&&(config_mode == 1)&&(pixel_y[9:6]==2)&&(pixel_x[9:5]>=9)&&(pixel_x[9:5]<=10)&&(LOCATION==1))
			  text_RGB = 12'h000;//Hace un cursor si se está en modo configuración. Misma explicacion de arriba, solo que para minutos
			  else if ((BLINK)&&(~font_bit)&&(config_mode == 1)&&(pixel_y[9:6]==2)&&(pixel_x[9:5]>=12)&&(pixel_x[9:5]<=13)&&(LOCATION==0))
			  text_RGB = 12'h000;//Hace un cursor si se está en modo configuración para segundos
			  else if(~font_bit) text_RGB = 12'h0AA;//Fondo del texto igual al de los recuadros asigna turquesa. 
		end

	else if(digFECHA_on)
		begin
		      char_addr = char_addr_digFECHA;
              row_addr = row_addr_digFECHA;
              bit_addr = bit_addr_digFECHA;
			  //(0: Year, 1: Mes, 2: fecha del dia, 3: Ubicación de día semana. Configuracion en 2, por ser fecha)
			  if(font_bit) text_RGB = 12'hFFF; //Blanco
			  else if ((BLINK)&&(~font_bit)&&(config_mode == 2)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=7)&&(pixel_x[9:4]<=8)&&(LOCATION==2))
			  text_RGB = 12'h000;//Hace un cursor si se está en modo configuración
			  else if ((BLINK)&&(~font_bit)&&(config_mode == 2)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=10)&&(pixel_x[9:4]<=11)&&(LOCATION==1))
			  text_RGB = 12'h000;//Hace un cursor si se está en modo configuración
			  else if ((BLINK)&&(~font_bit)&&(config_mode == 2)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=13)&&(pixel_x[9:4]<=14)&&(LOCATION==0))
			  text_RGB = 12'h000;//Hace un cursor si se está en modo configuración
		   	  else if(~font_bit) text_RGB = 12'h0AA;//Fondo del texto igual al de los recuadros
		end
	
	else if(FECHA_on)
		begin
		      char_addr = char_addr_FECHA;
              row_addr = row_addr_FECHA;
              bit_addr = bit_addr_FECHA;
			  if(font_bit) text_RGB = 12'h2F2; //color de las letras, verdes
		end
		
	else if(TIMER_on)
		begin
		      char_addr = char_addr_TIMER;
              row_addr = row_addr_TIMER;
              bit_addr = bit_addr_TIMER;
		   	  if(font_bit) text_RGB = 12'h2F2; //Verde
		end

	else if(digTIMER_on)
		begin
		      char_addr = char_addr_digTIMER;
              row_addr = row_addr_digTIMER;
              bit_addr = bit_addr_digTIMER;
			  //(0: Segundos del timer, 1: Minutos del timer, 2: Horas del timer, configuracion en 4 por ser el timer)
			  //config mode==4 recordar cualquier cosa
			  if(font_bit) text_RGB = 12'hFFF; //Blanco
			  else if ((BLINK)&&(~font_bit)&&(config_mode == 3)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=25)&&(pixel_x[9:4]<=26)&&(LOCATION==2)) 
			  text_RGB = 12'h000;//Hace un cursor si se está en modo configuración
			  else if ((BLINK)&&(~font_bit)&&(config_mode == 3)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=28)&&(pixel_x[9:4]<=29)&&(LOCATION==1))
			  text_RGB = 12'h000;//Hace un cursor si se está en modo configuración
			  else if ((BLINK)&&(~font_bit)&&(config_mode == 3)&&(pixel_y[9:5]==12)&&(pixel_x[9:4]>=31)&&(pixel_x[9:4]<=32)&&(LOCATION==0))
			  text_RGB = 12'h000;//Hace un cursor si se está en modo configuración
			  else if(~font_bit) text_RGB = 12'h0AA;//Fondo del texto igual al de los recuadros
		end
			
	else if (RING_on)
		begin
		      char_addr = char_addr_RING;
              row_addr = row_addr_RING;
              bit_addr = bit_addr_RING;
		   	  if(font_bit) text_RGB = 12'hF11; //Rojo
		end
	
	else if (AMPM_on)
		begin
		      char_addr = char_addr_AMPM;
              row_addr = row_addr_AMPM;
              bit_addr = bit_addr_AMPM;
		      //(0: Los dos dígitos a la derecha, 1: Los dos dígitos intermedios, 2: Los dos dígitos a la izquierda, 3: Ubicación de AM/PM)
		   	  if(font_bit) text_RGB = 12'h2F2; //Verde
		end

end

assign text_on = HORA_on|digHORA_on|digFECHA_on|TIMER_on|digTIMER_on|FECHA_on;//LOGO_on,DIA_on|;//10 bloques de texto en total

//Interfaz con la font ROM
assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[~bit_addr];

endmodule