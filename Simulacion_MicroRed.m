%% SIMULACIÓN DE MICRORED
% Generación solar + generación eólica
% Comparación con la demanda de la comunidad

clc;
clear;
close all;

%% ============================================================
% DATOS DE LA SIMULACIÓN
% ============================================================

% Vector de horas
horas = 1:24;


%% ============================================================
% GENERACIÓN SOLAR
% ============================================================

% Vector de 24 posiciones que representa la generación solar.
% Las horas 1 a 5 y 18 a 24 corresponden al periodo nocturno.
% La generación máxima de 25 kW se alcanza en la hora 11.

solar = [0 0 0 0 5 9 13 15 21 24 25 24 ...
         21 15 13 9 5 0 0 0 0 0 0 0];


%% ============================================================
% GENERACIÓN EÓLICA
% ============================================================

% Vector de 24 posiciones que representa la generación eólica.
% Los valores varían durante las 24 horas.
% Ningún valor supera la potencia máxima de 15 kW.

eolica = [8 10 7 12 4 7 2 9 6 5 11 15 ...
          12 15 11 14 15 13 12 6 9 15 7 10];


%% ============================================================
% GENERACIÓN HÍBRIDA TOTAL
% ============================================================

% La generación híbrida total es la suma de la generación
% solar y la generación eólica.

generacion_hibrida_total = solar + eolica;


%% ============================================================
% DEMANDA DE LA COMUNIDAD
% ============================================================

% Vector de 24 posiciones que representa la demanda
% de energía de la comunidad durante el día.

demanda = [3 3 2.5 2.5 3 6 7 8 8.5 9 9 10 ...
           9 8 8 9 10 15 15 15 15 4 3 3];


%% ============================================================
% BALANCE ENERGÉTICO
% ============================================================

% Balance positivo:
% existe excedente de generación.

% Balance negativo:
% la generación no alcanza para cubrir la demanda.

balance = generacion_hibrida_total - demanda;


%% ============================================================
% GRÁFICA: GENERACIÓN HÍBRIDA VS DEMANDA
% ============================================================

figure;

% Generación híbrida total
plot(horas, generacion_hibrida_total, '-o', ...
    'Color', [0 0.4470 0.7410], ...
    'LineWidth', 2, ...
    'MarkerSize', 6, ...
    'DisplayName', 'Generación Híbrida Total');

hold on;

% Demanda de la comunidad
plot(horas, demanda, '-s', ...
    'Color', [0.8500 0.3250 0.0980], ...
    'LineWidth', 2, ...
    'MarkerSize', 5, ...
    'DisplayName', 'Demanda Comunidad');

% Generación solar
plot(horas, solar, '-^', ...
    'Color', [0.9290 0.6940 0.1250], ...
    'LineWidth', 2, ...
    'MarkerSize', 6, ...
    'DisplayName', 'Generación Solar');

% Generación eólica
plot(horas, eolica, '-d', ...
    'Color', [0.4660 0.6740 0.1880], ...
    'LineWidth', 2, ...
    'MarkerSize', 5, ...
    'DisplayName', 'Generación Eólica');

hold off;


%% ============================================================
% CONFIGURACIÓN DE LA GRÁFICA
% ============================================================

title('Generación Híbrida Total vs Demanda de la Comunidad');

xlabel('Tiempo en horas');

ylabel('Potencia en Kilovatios (kW)');

xticks(1:24);

xlim([1 24]);

grid on;

legend('Location', 'northwest');


%% ============================================================
% MOSTRAR RESULTADOS EN LA VENTANA DE COMANDOS
% ============================================================

disp('==============================================');
disp('       RESULTADOS DE LA MICRORED');
disp('==============================================');

disp('Generación Solar (kW):');
disp(solar);

disp('Generación Eólica (kW):');
disp(eolica);

disp('Generación Híbrida Total (kW):');
disp(generacion_hibrida_total);

disp('Demanda de la Comunidad (kW):');
disp(demanda);

disp('Balance Energético (kW):');
disp(balance);

disp('==============================================');