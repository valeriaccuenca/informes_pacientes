library(tidyverse)
library(ggplot2)

###Cargamos las dos bases de datos

rm(list=ls())

setwd(paste0(getwd(),"/Informes_PA_pacientes")) #Así nos carga la misma carpeta a todas, porque si no cada uno tiene su ruta específica

load("dta_pacientes.RData")


# necesito base con nombre_paciente + subject de los participantes 

## Corremos el script de rmarkdown que contiene el bucle para que salgan los informes en html

for (v in 2:length(nombre_paciente)) {
  
  print(paste0("Informe ", nombre_paciente[v]))
  rmarkdown::render(input = paste0("Informe_madre.Rmd"),
                    output_file = paste0("Informe_", nombre_ca[v], ".html"))
  
