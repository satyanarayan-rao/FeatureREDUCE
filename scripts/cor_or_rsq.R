args = commandArgs (trailingOnly = T)
obs = read.table(args[1], sep = "\t",header = T, stringsAsFactors = F) 
pred = read.table(args[2], sep = "\t",header = T, stringsAsFactors = F) 

correlation = cor(obs$SymmetrizedAffinity, pred$SymmetrizedAffinity) 
rsq = correlation**2

cat (paste(correlation, rsq, args[3], args[4], sep = "\t"), "\n") 
