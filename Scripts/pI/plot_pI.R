#/usr/bin/env R
library("ggplot2")
pis <- list.files(pattern = "*.pI")
for (pi in pis) {
	F1 <-read.table(pi, sep = "\t", header = T)
	p1 <- ggplot(F1, aes(Isoelectric.point, Relative.frequency))+geom_point(size=2,shape=21)+geom_smooth(method= "gam")+theme_classic()
	out = paste(pi, ".tiff")
	ggsave(out, width = 12, height = 10, units ="in", dpi=150)
}
