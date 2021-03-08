#Assignment 5 2021/02/26

#Packages used 
library(readxl)
WT_KO <- read_excel("WT_KO.xlsx")

#Hypothesis 1: Mean tumor size were bigger on on Day 10 in KO mice compared to 
#WT mice treated with Vaccinia.

#modifying data structure
WT <- unlist(WT_KO[5,2:6])
KO <- unlist(WT_KO[5,7:11])
Group <- c(rep('WT', 5), rep('KO', 5))
Tumor_Size <- c(WT, KO)
DATA <- data.frame(Group, Tumor_Size)

set.seed(12345)

sims <- 9999
res <- numeric(sims)
for (i in 1:sims) {
  perms <- sample(nrow(DATA))
  shuffle <- transform(DATA,Tumor_Size=Tumor_Size[perms]) #new combos
  res[i] <- mean(shuffle$Tumor_Size[shuffle$Group=="WT"])-
    mean(shuffle$Tumor_Size[shuffle$Group=="KO"])
}
obs <- mean(DATA$Tumor_Size[DATA$Group=="WT"])-
  mean(DATA$Tumor_Size[DATA$Group=="KO"]) #real mean

res <- c(res,obs) #add to the possibilities


## JD: Taking the absolute value is OK, but it's usually better to figure out which tail you're in, calculate that tail, and double it.
p_val_perm <- mean(abs(res)>=abs(obs)); abs(obs); p_val_perm #p-val for obs

hist(res,col="gray",las=1,main="")
abline(v=obs,col="red")

p_val_t <- t.test(Tumor_Size~Group,data=DATA,var.equal=TRUE); p_val_t

#Hypothesis 2: Mean tumor size was bigger on Day 0 vs Day 10 for KO mice 
#treated with Vaccinia

PBS_10 <- unlist(WT_KO[5,12:15])
WT_10 <- unlist(WT_KO[5,2:6])
Group_2 <- c(rep('PBS_10', 4), rep('Vaccinia_10', 5))
Tumor_Size_2 <- c(PBS_10, WT_10)
DATA_2 <- data.frame(Group_2, Tumor_Size_2)

set.seed(12345) 
sims <- 9999
res <- numeric(sims)
for (i in 1:sims) {
  perms <- sample(nrow(DATA_2))
  shuffle <- transform(DATA_2,Tumor_Size_2=Tumor_Size_2[perms])
  res[i] <- mean(shuffle$Tumor_Size_2[shuffle$Group_2=="PBS_10"])-
    mean(shuffle$Tumor_Size_2[shuffle$Group_2=="Vaccinia_10"])
}
obs <- mean(DATA_2$Tumor_Size_2[DATA_2$Group_2=="PBS_10"])-
  mean(DATA_2$Tumor_Size_2[DATA_2$Group_2=="Vaccinia_10"])

res <- c(res,obs)

p_val_perm <- mean(abs(res)>=abs(obs)); abs(obs); p_val_perm #p-val for obs

hist(res,col="gray",las=1,main="")
abline(v=obs,col="red")

p_val_t <- t.test(Tumor_Size_2~Group_2,data=DATA_2,var.equal=TRUE); p_val_t

## Grade 2.0/3
