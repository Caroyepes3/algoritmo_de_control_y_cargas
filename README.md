# ⚡ Algoritmo de Control y Cargas para Micro-Redes Híbridas

Este proyecto contiene un algoritmo desarrollado en **MATLAB** diseñado para la simulación, gestión y optimización de la demanda y generación de energía en una micro-red híbrida (baterías, solar y eólica).

---

## 📋 Información del Proyecto
* **Institución:** Universidad Nacional Abierta y a Distancia (UNAD)
* **Curso:** Software para Ingeniería - Código 203036
* **Estudiante:** Carolina Yepes
* **Fase:** Reto 3 (Algoritmo de Control y Cargas)

---

## 🛠️ Archivos Incluidos en el Repositorio

* **`algoritmo_de_control_y_cargas.m`**: Script principal que ejecuta las reglas de control de carga y descarga de las baterías de acuerdo con la demanda del sistema.
* **`Simulacion_MicroRed.m`**: Archivo de simulación del bucle de 24 horas para analizar el comportamiento híbrido (Generación Solar + Eólica).
* **`FirstStepsInMATLAB.mlx`**: Guía interactiva (Live Script) con los pasos iniciales y configuraciones base del entorno.

---

## 🚀 Cómo Ejecutar la Simulación

1. Descarga o clona este repositorio en tu computadora.
2. Abre **MATLAB** y dirígete a la carpeta del proyecto.
3. Ejecuta el archivo principal `Simulacion_MicroRed.m`.
4. Observa en los gráficos o en el *Workspace* el comportamiento del bucle de simulación de 24 horas.

---

## 📊 Características del Sistema Simulado
* **Simulación horaria:** Ciclo completo de demanda y generación de 24 horas.
* **Fuentes híbridas:** Integración de energía solar y eólica.
* **Gestión de almacenamiento:** Control dinámico de porcentaje de carga inicial y capacidad de baterías (en kWh).
