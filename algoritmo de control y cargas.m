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
fprintf('====== REPORTE DE CONTROL — SIMULACIÓN DE 24 HORAS ======\n');
fprintf('Hora | Egen | Edem | Balance | SOC(%%) |      Servicios Activos\n');
fprintf('-----------------------------------------------------------\n');

for hora = 1:24

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
    fprintf('%4d | %4.0f | %4.0f | %+6.1f | %6.1f | Escuela: %s  Bombeo: %s  Alumbrado: %s\n', ...
        hora, gen_actual, dem_actual, balance, SOC, escuela, bombeo, alumbrado);
end

fprintf('======= FIN DE LA SIMULACIÓN =======\n');

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
