#zd1
x = c(3, 5, 3, 18, 54, 22, 1, 4, 7, 1, 15, 16, 4, 2, 1, 7, 12, 21, 4, 8)
y1<-x[3]; y1
y2<-x[1:7]; y2
y3<-x[which(x>14)]; y3

y3<-x[x>14]; y3
y4=x[c(1:3,4,8:length(x))]; y4
y5<-sort(x,decreasing = FALSE);y5
y6<-sort(x,decreasing = TRUE);y6

#zd2

rep(1:3,4)
seq(0,1, by=0.1)

#zd3

a1<-c(7,4,3,8,6,6,10,11)
harmonic<-length(a1)/sum(1/a1)
harmonic

#zd4

x<-runif(50, min = 0, max = 1)
y<-rep(1,50);y
y[which(x<0.5)]=0
y
length(which(x<0.5))
length(which(x<0.5))/length(x)

#zd5

n=10000
sum(1/c(1:n))-log(n)

#zd6

for(i in 1:10){print(2*i)}