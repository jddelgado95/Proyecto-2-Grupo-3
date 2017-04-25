`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2017 11:46:52 AM
// Design Name: 
// Module Name: Banco_Contadores
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


module Banco_Contadores(
input wire clk, 
input wire reset,
input wire Arriba,//enUP,
input wire Abajo,//enDOWN,
input wire Izquierda,//enLEFT,
input wire Derecha,//enRIGHT,
input wire [2:0] configuracion,//config_mode,//Cuatro estados del modo configuración
output wire [7:0] btn_data_SS, btn_data_MM, btn_data_HH, btn_data_YEAR, btn_data_MES, btn_data_DAY,
btn_data_SS_T, btn_data_MM_T, btn_data_HH_T,//Decenas y unidades para los números en pantalla(configuración)
output wire am_pm,//AM_PM,//Entrada para conocer si en la información de hora se despliega AM o PM
output wire [1:0] pos_cursor//cursor_location//Marca la posición del cursor en modo configuración
);

localparam N = 2;//Bits del contador de desplazamiento horizontal

reg [N-1:0] q_act, q_next;
reg enLEFT_reg, enRIGHT_reg;
wire enLEFT_tick, enRIGHT_tick;
wire [N-1:0] count_horizontal;
reg [3:0]enable_counters;//10 contadores en total de hora, fecha, timer

//Detección de flancos
always@(posedge clk)
begin
enLEFT_reg <= Izquierda;
enRIGHT_reg <= Derecha;
end

assign enLEFT_tick = ~enLEFT_reg & Izquierda;
assign enRIGHT_tick = ~enRIGHT_reg & Derecha;

//Contador horizontal
//Descripción del comportamiento
always@(posedge clk)
begin	
	
	if(reset)
	begin
		q_act <= 2'b0;
	end
	
	else
	begin
		q_act <= q_next;
	end
end

//Lógica de salida
always@*
begin
	if(enLEFT_tick)
	begin
	q_next = q_act + 1'b1;
	end
	
	else if(enRIGHT_tick)
	begin
	q_next = q_act - 1'b1;
	end
	
	else if(enLEFT_tick && q_act == 2 && configuracion == 1)
	begin
	q_next = 5'd0;
	end
	
	else if(enRIGHT_tick && q_act == 0 && configuracion == 1)
	begin
	q_next = 5'd2;
	end
	
	else if(enLEFT_tick && q_act == 2 && configuracion == 4)
	begin
	q_next = 5'd0;
	end
	
	else if(enRIGHT_tick && q_act == 0 && configuracion == 4)
	begin
	q_next = 5'd2;
	end	
	
	else
	begin
	q_next = q_act;
	end
end

assign count_horizontal = q_act;

//Instancias contadores de hora, fecha y timer

contador_AD_SS_2dig Instancia_contador_SS//Segundos de la hora
(
.clk(clk),
.reset(reset),
.contadoresH(enable_counters),
.Arriba(Arriba),
.Abajo(Abajo),
.datos_SS(btn_data_SS)
);

contador_AD_MM_2dig Instancia_contador_MM//Minutos de la hora
(
.clk(clk),
.reset(reset),
.Arriba(Arriba),
.Abajo(Abajo),
.contadoresH(enable_counters),
.datos_MM(btn_data_MM)
);

contador_AD_HH_2dig Instancia_contador_HH//Horas de la hora
(
.clk(clk), 
.reset(reset),
.contadoresH(enable_counters),
.Arriba(Arriba),
.Abajo(Abajo),
.am_pm(am_pm),
.datos_HH(btn_data_HH)
);   

contador_AD_YEAR_2dig Instancia_contador_YEAR//Años de la fecha
(
.clk(clk),
.reset(reset),
.Arriba(Arriba),
.contadoresH(enable_counters),
.Abajo(Abajo),
.datos_Aho(btn_data_YEAR)
);

contador_AD_MES_2dig Instancia_contador_MES//Meses de la fecha
(
.clk(clk),
.reset(reset),
.contadoresH(enable_counters),
.Arriba(Arriba),
.Abajo(Abajo),
.datos_mes(btn_data_MES)
);

contador_AD_DAY_2dig Instancia_contador_DAY//Día de la fecha
(
.clk(clk),
.reset(reset),
.contadoresH(enable_counters),
.Arriba(Arriba),
.Abajo(Abajo),
.datos_Dia(btn_data_DAY)
);


contador_AD_SS_T_2dig Instancia_contador_SS_T//Segundos del timer
(
.clk(clk),
.reset(reset),
.contadoresH(enable_counters),
.Arriba(Arriba),
.Abajo(Abajo),
.datos_SS_T(btn_data_SS_T)
);

contador_AD_MM_T_2dig Instancia_contador_MM_T//Minutos del timer
(
.clk(clk),
.reset(reset),
.contadoresH(enable_counters),
.Arriba(Arriba),
.Abajo(Abajo),
.datos_MM_T(btn_data_MM_T)
);

contador_AD_HH_T_2dig Instancia_contador_HH_T //Horas del timer
(
.clk(clk),
.reset(reset),
.contadoresH(enable_counters),
.Arriba(Arriba),
.Abajo(Abajo),
.datos_HH_T(btn_data_HH_T)
);

//Lógica de activación de cada contador dependiendo del modo configuración y la cuenta horizontal
always@*

	case(configuracion)//Evalúa que se está configurando (0: modo normal, 1: config.hora, 2: config.fecha, 3: config.timer)

	3'd0://Modo normal no habilita ningún contador
	begin
	enable_counters = 4'b0;
	end
	
	3'd1:
	begin
		case(count_horizontal)
		
		2'd0: enable_counters = 4'd1;//SS
		2'd1: enable_counters = 4'd2;//MM
		2'd2: enable_counters = 4'd3;//HH
		default: enable_counters = 4'd0;
	
		endcase
	end
	3'd2:
		case(count_horizontal)
		
		2'd0: enable_counters = 4'd4;//Año 
		2'd1: enable_counters = 4'd5;//Mes
		2'd2: enable_counters = 4'd6;//Día
		2'd3: enable_counters = 4'd7;//Día de la semana
		
		endcase
	3'd4:
		case(count_horizontal)
		
		2'd0: enable_counters = 4'd8;//SS_T
		2'd1: enable_counters = 4'd9;//MM_T
		2'd2: enable_counters = 4'd10;//HH_T
		default: enable_counters = 4'd0;
		
		endcase
	default: enable_counters = 4'b0;
	endcase

assign pos_cursor = count_horizontal;
endmodule