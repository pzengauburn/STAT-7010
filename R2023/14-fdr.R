######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-03-30
######################################################################

# 6033 x 102 data matrix 
# The first 50 columns are the gene expression levels 50 control subjects,
# while the last 52 columns represent the prostate cancer subjects.

filename = "http://hastie.su.domains/CASI_files/DATA/prostmat.csv"
prostmat = read.csv(filename)
str(prostmat)

n.gene = nrow(prostmat)

pvalue = numeric(n.gene)
for(i in 1:n.gene)
{
    pvalue[i] = t.test(prostmat[i, 1:50], prostmat[i, 51:102], var.equal = TRUE)$p.value
}

summary(pvalue)
sum(pvalue < 0.05)                              # 477 significant genes 
sum(pvalue < 0.05 / n.gene)                     # 2 significant genes using Bonferroni's 
sum(sort(pvalue) < 0.05 / (n.gene:1))           # 2 significant genes using Holm's  
sum(sort(pvalue) < 0.05 * (1:n.gene) / n.gene)  # 21 significant genes using FDR

bon = p.adjust(pvalue, method = "bonferroni")
holm = p.adjust(pvalue, method = "holm")
BH = p.adjust(pvalue, method = "fdr")

par(mar = c(4.5, 4.5, 0.5, 0.5))
plot(sort(pvalue)[1:50], ylab = "p-value")
lines(1:50, 1:50 * 0.05/n.gene, col = "red")
lines(1:50, 0.05 / (n.gene - 1:50 + 1), col = "blue")
legend(0, max(sort(pvalue)[1:50]), c("FDR", "Holm's"), 
       lty = c(1, 1), col = c("red", "blue"))

######################################################################
# THE END 
######################################################################
