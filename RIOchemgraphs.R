#COQUI - Chemistry, Organics and (Q)Discharge User Interface
#@thomaskorstanje --- Olsen Lab, University of Maine, Earth and Climate Sciences

library(tidyverse)

mgdate <- ggplot(molALL, aes(x = numdate, y = Mg, color = year)) +
  geom_line() +
  geom_point() +
  labs(title = "Mg Concentration over the Year at GUIL",
       x = "Numeric Date",
       y = "Mg Concentration in mol",
       color = "year") +
scale_y_log10() +
scale_color_manual(values = c("#e97bb2", "#f88283", "#f89d44", "#f5d332", "#a2d142")) +
geom_vline(xintercept = seq(30, max(molALL$numdate), by = 30), linetype = "dashed", color = "gray", alpha = 0.5) + 
scale_x_continuous(breaks = seq(0, max(molALL$numdate), by = 30), labels = seq(0, max(molALL$numdate), by = 30)) +  
theme_minimal()  

print(mgdate)
ggsave("mgdate.png", plot = mgdate, width = 12, height = 6, units = "in")
