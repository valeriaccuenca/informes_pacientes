

library(tidyverse)
library(dplyr)
library(stats)
library(kableExtra)
library(knitr)


load("dta_pacientes.RData")

dta_pacientes <-dta_pacientes %>% 
  mutate(total_pas = light+moderate+vigorous+veryvigorous) %>% 
  mutate(dia = recode(day,  monday = "Lunes",
                      tuesday = "Martes",
                      wednesday = "Miércoles",
                      thursday = "Jueves",
                      friday = "Viernes",
                      saturday = "Sábado",
                      sunday = "Domingo")) %>% 
  group_by(subject)

# tabla con el resumen de la actividad física semanal
tab_1 <-  dta_pacientes %>%
  filter(subject=="d_34") %>%
  select(dia, sedentary, light, moderate, vigorous, veryvigorous, MVPA, total_pas, total_activity_day) %>%
  summarise(
    Total_sedentaria = sum(sedentary),
    Total_ligera = sum(light),
    Total_moderada = sum(moderate),
    Total_vigorosa = sum(vigorous),
    Total_muyvigorosa = sum(veryvigorous),
    Total_MVPA = sum(MVPA),
    Total_PA = sum(total_pas),
    Total_Ac = sum(total_activity_day)) %>% 
  rename('Sedentaria'= Total_sedentaria, 'Ligera'= Total_ligera,'Moderada'= Total_moderada, 
       'Vigorosa'= Total_vigorosa, 'Muy vigorosa'= Total_muyvigorosa, "Actividad moderada a vigorosa" = Total_MVPA, 
       "Actividad física total" = Total_PA, "Actividad total registrada"= Total_Ac) %>% 
  kbl(format = ,align = "c") %>% 
  kable_styling() %>% 
  remove_column(columns = 1)
tab_1

# tabla con la actividad física diaria
tab_2 <-  dta_pacientes %>%
  filter(subject=="d_34") %>%
  select(dia, sedentary, light, moderate, vigorous, veryvigorous, MVPA, total_pas, total_activity_day) %>%
  rename('Día de la semana' = dia, 'Sedentaria'= sedentary, 'Ligera'= light,'Moderada'= moderate, 
         'Vigorosa'= vigorous, 'Muy vigorosa'= veryvigorous, "Actividad moderada a vigorosa" = MVPA, 
         "Actividad física total" = total_pas, "Actividad total registrada"= total_activity_day) %>% 
  kbl(format = ,align = "c") %>% 
  kable_styling() %>% 
  remove_column(columns = 1) 
tab_2

#ggplot con los tipos de actividad por día
library(ggplot2)
library(reshape2)


dta_long <- dta_pacientes %>% 
  filter(subject=="d_34") %>%
  select(day_n, dia, sedentary, light, moderate, vigorous, veryvigorous) %>% 
  melt(dta_pacientes, id.vars=c("subject", "day_n", "dia"),
         measure.vars=c("light", "moderate", "vigorous", "veryvigorous"),
         variable.name="type_pa",
         value.name="minutes")
dta_long

plot_1 <- ggplot(dta_long, aes(x = reorder(dia, day_n), y = minutes, fill = type_pa)) +
  geom_col(position = position_dodge2()) +
  theme_minimal()
plot_1


# melt(dta_,
#      # ID variables - all the variables to keep but not split apart on
#      id.vars=c("subject", "dia"),
#      # The source columns
#      measure.vars=c("light", "moderate", "vigorous", "veryvigorous"),
#      # Name of the destination column that will identify the original
#      # column that the measurement came from
#      variable.name="type_pa",
#      value.name="minutes")

 


 


