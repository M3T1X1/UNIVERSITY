#zd1 

il<-function(a,b){
  if(ncol(a)==nrow(b)){print("iloczyn macierzy");print(a%*%b)}
  if(ncol(a)!=nrow(b)){print("nie mo?na policzy? iloczynu")}}

a<-matrix(c(2,5,13,24,9,7,5,2,1 ),3,3)
a
b<-matrix(c(3,5,1,7,4,8,3,2,22 ),3,3)
b
il(a,b)

#zd2

parz<-function(a){
  
  b<-a%%2
  if(b==1){print("nieparzysta")}
  else
  {print("parzysta")}
}

parz(4)