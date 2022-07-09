library(ggplot2)
library(Cairo)
library(grid)

args = commandArgs (trailingOnly = T)
obs = read.table(args[1], sep = "\t",header = T, stringsAsFactors = F) 
pred = read.table(args[2], sep = "\t",header = T, stringsAsFactors = F) 

correlation = cor(obs$SymmetrizedAffinity, pred$SymmetrizedAffinity) 
pear_rsq = correlation**2
# rsq in deeprec way
ss_res = (obs$SymmetrizedAffinity - pred$SymmetrizedAffinity)%*% (obs$SymmetrizedAffinity - pred$SymmetrizedAffinity) 
mean_obs = mean(obs$SymmetrizedAffinity)
ss_tot = (obs$SymmetrizedAffinity - mean_obs)%*%(obs$SymmetrizedAffinity - mean_obs)

rsq = 1 - (ss_res/ss_tot)

cat (paste(correlation, pear_rsq, rsq, args[3], args[4], sep = "\t"), "\n") 


# input stream should have two fields only. 1st one should be x, and 2nd one should be y
# please sort in the oder you want apriory. This program is going to plot simply by taking the rows in order.
dt = data.frame(obs = obs$SymmetrizedAffinity, pred = pred$SymmetrizedAffinity) 
print (head(dt))

# ------------------- #
font_size = 10
figure2_theme <- function (){
    theme(plot.title=element_text( size=font_size )) +
    theme(axis.title.x = element_text(colour = "black", size = font_size),
          axis.title.y = element_text(colour = "black", size = font_size)) +
    theme(axis.text.x = element_text(size = font_size),
          axis.text.y = element_text(size = font_size)) +
    theme(legend.title= element_text(size = font_size),
          legend.text = element_text(size = font_size)) +
    theme(axis.line.x = element_line(color="black", size = 0.5),
          axis.line.y = element_line(color="black", size = 0.5)) +
    theme(plot.title = element_text(hjust = 0.5))
}
r2_val = grobTree(textGrob(paste0("Pearson R2 = ", round (pear_rsq,3)), x = 0.5, y = 0.9, hjust = 0.5))
plt = ggplot(dt, aes(x = obs, y = pred)) +  geom_hex() +
#   theme_bw(line_scale_size = 0.1) 
   xlab("Observed") + ylab("Predicted") + ggtitle(paste0(toupper(args[4]), " ", args[3], " (FeatureREDUCE)" ) )  +
   annotation_custom(r2_val) + 
   figure2_theme() +  #+ theme(axis.text.x = element_text(angle = 90)) 
   theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
   panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
pdf(args[5], height = 5, width = 6)
print(plt)
dev.off()

Cairo::CairoPNG(args[6], height = 5, width = 6, units = "in", res = 150)
print(plt)
dev.off()

