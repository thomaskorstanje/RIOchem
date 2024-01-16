#COQUI - Chemistry, Organics and (Q)Discharge User Interface
#@thomaskorstanje --- Olsen Lab, University of Maine, Earth and Climate Sciences

library(tidyverse)
library(gridExtra)
library(cowplot)

space <- function(x) {
  gsub("^(\\d)", "  \\1", x)
}

cwdata <- read.csv("~/Desktop/EGL wd/GUIL Data/cwdatav2.csv")

cwdate <- ggplot(cwdata, aes(x = numdate, y = CW, color = as.factor(year), shape = as.factor(year))) +
  geom_point() +
  labs(title = "",
       x = "Numeric Date",
       y = "Chemical Weathering Flux (tons/km2/yr)",
       color = "year") +
  scale_shape_manual(values = c(19, 23, 17, 25, 15)) +
  scale_color_manual(values = c("#d44446", "#e97bb2","#e7c416","#f89d44", "#a2d142")) +
  geom_vline(xintercept = seq(30, max(cwdata$numdate), by = 30), linetype = "dashed", color = "gray", alpha = 0.5) +
  scale_x_continuous(breaks = seq(0, 360, by = 30)) +
  scale_y_continuous(breaks = seq(0, 600.0, by = 200.0), labels = space(seq(0, 600.0, by = 200.0))) +
  guides(
    color = guide_legend(title = "Year"),
    shape = guide_legend(title = "Year")
  ) +
  theme_minimal() +
  theme(legend.position = "none")  

qdate <- ggplot(cwdata, aes (x = numdate, y = Q, color = as.factor(year), shape = as.factor(year))) +
  geom_point() +
  labs(title = "",
       x = "",
       y = "Discharge (L/s)",
       color = "year") +
  scale_shape_manual(values = c(19, 23, 17, 25, 15)) +
  scale_color_manual(values = c("#d44446","#e97bb2", "#e7c416", "#f89d44", "#a2d142")) +
  geom_vline(xintercept = seq(30, max(cwdata$numdate), by = 30), linetype = "dashed", color = "gray", alpha = 0.5) +
  scale_x_continuous(breaks = seq(0, 360, by = 30), position = "top") +
   guides(
    color = guide_legend(title = "Year"),
    shape = guide_legend(title = "Year")
  ) +
  theme_minimal() +
  theme(legend.position = "none")


legend <- cowplot::get_legend(cwdate + theme(legend.position="right"))
final <- grid.arrange(qdate, cwdate, ncol = 1, top = "")
final <- cowplot::plot_grid(final, legend, ncol = 2, rel_widths = c(0.9, 0.1))


print(final)

ggsave("cwdate.png", plot = cwdate, width = 12, height = 3, units = "in")
ggsave("qdate.png", plot = qdate, width = 12, height = 3, units = "in")
ggsave("final.png", plot = final, width = 12, height = 6, units = "in")



