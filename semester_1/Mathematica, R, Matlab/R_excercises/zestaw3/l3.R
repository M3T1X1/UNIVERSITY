#a) Średnia
srednia <- colMeans(Bazka[, c("A", "B", "C", "D")])  

#b) Odchylenie standardowe 
odchylenie_std <- apply(Bazka[, c("A", "B", "C", "D")], 2, sd) 

#c) Współczynnik zmienności 
wsp_zm <- odchylenie_std / srednia * 100  

#d) Mediana 
median <- apply(Bazka[, c("A", "B", "C", "D")], 2, median)  

#e) Kwartyle
kwartyl1 <- apply(Bazka[, c("A", "B", "C", "D")], 2, quantile, probs = 0.25) 
kwartyl2 <- apply(Bazka[, c("A", "B", "C", "D")], 2, quantile, probs = 0.75)  

#f) Minimum
minimum <- apply(Bazka[, c("A", "B", "C", "D")], 2, min)  

#g) Maksimum
maksimum <- apply(Bazka[, c("A", "B", "C", "D")], 2, max)

#Rozkłady ilościowe dla cech jakościowych:
table(Bazka$g1)
table(Bazka$g2)

#Rozkład procentowy dla cech jakościowych
prop.table(table(Bazka$g1)) * 100
prop.table(table(Bazka$g2)) * 100

#raport
raport <- data.frame(
  Cechy = c("A", "B", "C", "D"),
  Srednia = srednia,
  Odchylenie_Std = odchylenie_std,
  Wsp_Zm = wsp_zm,
  Mediana = mediana,
  Kwartyl1 = kwartyl1,
  Kwartyl2 = kwartyl2,
  Minimum = minimum,
  Maksimum = maksimum
)

#zapisanie raportu do pliku .xlsx

write.xlsx(raport, "Bazka.xlsx", sheetName = "raport", rowNames = FALSE)

install.packages("openxlsx")
library(openxlsx)