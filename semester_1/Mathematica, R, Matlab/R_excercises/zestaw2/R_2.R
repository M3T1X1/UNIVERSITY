#zd1

M1<-matrix(c(1,2,3,3,2,1,5,3,1,10,21,51,3,4,1,126),4,4)

print(M1)
M2<-matrix(c(1.5,8,2.2,1,1,8.0,7.3,1,5,2,2,7,4,3,2.1,15),4,4)

print(M2)

if(ncol(M1)==nrow(M2)){D<-M1%*%M2}
if(ncol(M1)!=nrow(M2)){print("nie mozna pomnozyc")}
print("iloczyn macierzy")
print(D)

if(ncol(M1)==nrow(M1)){DET<-det(M1)}
if(ncol(M1)!=nrow(M1)){print("macierz nie jest kwadratowa")}
print("wyznacznik macierzy M1")
print(DET)
if(ncol(M2)==nrow(M2)){DET1<-det(M2)}
if(ncol(M2)!=nrow(M2)){print("macierz nie jest kwadratowa")}
print("wyznacznik macierzy M2")
print(DET1)
"4) macierz odwrotna - mozliwa gdy DET jest inne niz 0"
if(DET!=0){M1od<-solve(M1)}
if(DET==0){print("brak macierzy odwrotnej")}
print("macierz odwrotna dla M1")
print(M1od)
if(DET1!=0){M2od<-solve(M2)}
if(DET1==0){print("brak macierzy odwrotnej")}
print("macierz odwrotna dla M2")
print(M2od)
WW<-eigen(M1)
print("wektor wlasny macierzy M1")
print(WW$vectors)
"wartosc wlasna macierzy M1"
print(WW$values)
WW1<-eigen(M2)
print("wektor wlasny macierzy M2")
print(WW1$vectors)
print("wartorow wlasna M2")
print(WW1$values)
print("suma macierzy")
print(M1+M2)

#zd2

plec<-rep(c("m","k"),15)
grupa<-rep(c("a","b","c"),10)
wzrost<-seq(from=170, to=199, by=1)
waga<-seq(from=60, to=89, by=1)
osoba<-seq(1,30,by=1)
DFR<-data.frame(osoba,plec,grupa,wzrost, waga)
print(DFR)
sink()
