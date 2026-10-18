% =====================================================
% RETO 3 - ALGORITMO DE CONTROL Y CARGAS
% Curso: Software para Ingeniería - Código 203036
% UNAD - Universidad Nacional Abierta y a Distancia
% =====================================================

%%\ ---------------- CONFIGURACIÓN INICIAL ----------------
% Capacidad del banco de baterías
Capacidad_bat = 100;           % kWh
% Estado de carga inicial
SOC = 50;                       % Porcentaje - valor inicial
% Límites de seguridad
SOC_max = 100;
SOC_min = 0;

% VECTORES DE GENERACIÓN Y DEMANDA (24 horas)
% Nota: Si ya tienes tus propios datos del Reto 2, reemplázalos aquí
E_solar = [1, 2, 3, 4, 6, 10, 15, 20, 23, 25, 26, 25, ...
    24, 22, 18, 12, 8, 5, 2, 1, 0, 0, 0, 0];  % kWh
E_eolica = [8, 9, 10, 11, 10, 9, 8, 7, 6, 5, 4, 5, ...
    6, 7, 9, 10, 11, 12, 11, 10, 9, 8, 8, 9]; % kWh
E_demanda = [12, 11, 10, 9, 8, 9, 10, 12, 14, 15, 16, 17, ...
    16, 15, 14, 13, 12, 14, 16, 18, 17, 16, 15, 13]; % kWh

% Generación híbrida total
Egen = E_solar + E_eolica;

%%\ ---------------- BUCLE DE SIMULACIÓN 24 HORAS ----------------
fprintf('====== REPORTE DE CONTROL — SIMULACIÓN DE 24 HORAS ======\n'); %[output:64e5285d]
fprintf('Hora | Egen | Edem | Balance | SOC(%%) |      Servicios Activos\n'); %[output:1b9d89d9]
fprintf('-----------------------------------------------------------\n'); %[output:00baad14]

for hora = 1:24 %[output:group:763327c1]

    % Leer valores de la hora actual
    gen_actual = Egen(hora);
    dem_actual = E_demanda(hora);

    % Inicializar estado de servicios
    escuela = 'SÍ ✅';
    bombeo = 'SÍ ✅';
    alumbrado = 'SÍ ✅';

    % ---------------- LÓGICA DE DECISIÓN ----------------
    if gen_actual >= dem_actual
        % ESCENARIO DE SUPERÁVIT
        excedente = gen_actual - dem_actual;
        SOC_nuevo = SOC + (excedente / Capacidad_bat) * 100;

        % Limitar SOC al máximo de seguridad
        if SOC_nuevo > SOC_max
            SOC_nuevo = SOC_max;
        end

        % Todos los servicios permanecen activos

    else
        % ESCENARIO DE DÉFICIT
        faltante = dem_actual - gen_actual;
        SOC_nuevo = SOC - (faltante / Capacidad_bat) * 100;

        % Limitar SOC al mínimo absoluto
        if SOC_nuevo < SOC_min
            SOC_nuevo = SOC_min;
        end

        % Aplicar protocolo de prioridad de cargas
        if SOC_nuevo > 40
            % Ruta Segura — todo activo
        elseif SOC_nuevo > 20
            % Ruta de Alerta — desconectar alumbrado
            alumbrado = 'NO ❌';
        else
            % Ruta de Emergencia — desconectar bombeo y alumbrado
            bombeo = 'NO ❌';
            alumbrado = 'NO ❌';
        end
    end

    % Actualizar el estado de la batería
    SOC = SOC_nuevo;

    % Mostrar reporte en consola
    balance = gen_actual - dem_actual;
    fprintf('%4d | %4.0f | %4.0f | %+6.1f | %6.1f | Escuela: %s  Bombeo: %s  Alumbrado: %s\n', ... %[output:6477ecb6]
        hora, gen_actual, dem_actual, balance, SOC, escuela, bombeo, alumbrado); %[output:6477ecb6]
end %[output:group:763327c1]

fprintf('======= FIN DE LA SIMULACIÓN =======\n'); %[output:3f970a4f]

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
%[output:64e5285d]
%   data: {"dataType":"text","outputData":{"text":"====== REPORTE DE CONTROL — SIMULACIÓN DE 24 HORAS ======\n","truncated":false}}
%---
%[output:1b9d89d9]
%   data: {"dataType":"text","outputData":{"text":"Hora | Egen | Edem | Balance | SOC(%) |      Servicios Activos\n","truncated":false}}
%---
%[output:00baad14]
%   data: {"dataType":"text","outputData":{"text":"-----------------------------------------------------------\n","truncated":false}}
%---
%[output:6477ecb6]
%   data: {"dataType":"text","outputData":{"text":"   1 |    9 |   12 |   -3.0 |   47.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n   2 |   11 |   11 |   +0.0 |   47.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n   3 |   13 |   10 |   +3.0 |   50.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n   4 |   15 |    9 |   +6.0 |   56.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n   5 |   16 |    8 |   +8.0 |   64.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n   6 |   19 |    9 |  +10.0 |   74.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n   7 |   23 |   10 |  +13.0 |   87.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n   8 |   27 |   12 |  +15.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n   9 |   29 |   14 |  +15.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  10 |   30 |   15 |  +15.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  11 |   30 |   16 |  +14.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  12 |   30 |   17 |  +13.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  13 |   30 |   16 |  +14.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  14 |   29 |   15 |  +14.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  15 |   27 |   14 |  +13.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  16 |   22 |   13 |   +9.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  17 |   19 |   12 |   +7.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  18 |   17 |   14 |   +3.0 |  100.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  19 |   13 |   16 |   -3.0 |   97.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  20 |   11 |   18 |   -7.0 |   90.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  21 |    9 |   17 |   -8.0 |   82.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  22 |    8 |   16 |   -8.0 |   74.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  23 |    8 |   15 |   -7.0 |   67.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n  24 |    9 |   13 |   -4.0 |   63.0 | Escuela: SÍ ✅  Bombeo: SÍ ✅  Alumbrado: SÍ ✅\n","truncated":false}}
%---
%[output:3f970a4f]
%   data: {"dataType":"text","outputData":{"text":"======= FIN DE LA SIMULACIÓN =======\n","truncated":false}}
%---
