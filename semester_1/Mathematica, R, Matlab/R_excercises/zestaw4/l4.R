# 1. Narysuj histogram dla wybranej zmiennej liczbowej 
hist(Bazka$A, col = "blue", main = "Histogram zmiennej liczbowej",      
xlab = "Wartość zmiennej", ylab = "Liczba obserwacji", breaks = 20)  
# 2. Przedstaw rozkład cechy nie liczbowej 
barplot(table(Bazka$g1), col = "yellow", main = "Rozkład cechy nie liczbowej", xlab = "Wartość cechy", ylab = "Liczba obserwacji")  

# 3. Narysuj wykres rozkładu dwóch zmiennych ilościowych 
plot(Bazka$A, Bazka$B, col = "purple", main = "Wykres rozkładu dwóch zmiennych ilościowych", xlab = "Zmienna liczba 1", ylab = "Zmienna liczba 2") 

# 4. Narysuj zależność dwóch zmiennych liczbowych i zmiennych jakościowych 
plot(Bazka$A, Bazka$B, col = as.factor(Bazka$g1),     
main = "Zależność dwóch zmiennych liczbowych i jakościowej",      
xlab = "Zmienna liczba 1", ylab = "Zmienna liczba 2")  

# Dodaj zależność liniową z punktami wybranej zmiennej ilościow
model <- lm(Bazka$B ~ Bazka$A)
abline(model, col = "red", lty = 2)
legend("topright", legend = c("Linia regresji"), col = "red", lty = 2)