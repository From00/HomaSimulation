#!/usr/bin/Rscript
library(reshape2)
library(ggplot2)
library(gridExtra)

# Plots the stretch vs. unsched bytes from text data files generated by PlotDigeter.py script
stretchVsUnsched <- read.table("stretchVsUnsched.txt", na.strings = "NA",
        col.names=c('LoadFactor', 'WorkLoad', 'MsgSizeRange', 'UnschedBytes', 'MeanStretch', 'MedianStretch', 'TailStretch'),
        header=TRUE)
stretchVsUnsched$LoadFactor <- factor(stretchVsUnsched$LoadFactor)
avgStretchVsUnsched <- subset(stretchVsUnsched, !is.na(MeanStretch), select=c('LoadFactor', 'WorkLoad', 'MsgSizeRange', 'UnschedBytes', 'MeanStretch'))
medianStretchVsUnsched <- subset(stretchVsUnsched, !is.na(MedianStretch), select=c('LoadFactor', 'WorkLoad', 'MsgSizeRange', 'UnschedBytes', 'MedianStretch'))
tailStretchVsUnsched <- subset(stretchVsUnsched, !is.na(TailStretch), select=c('LoadFactor', 'WorkLoad', 'MsgSizeRange', 'UnschedBytes', 'TailStretch'))
nCols = length(unique(stretchVsUnsched$WorkLoad))
pdf("MeanStretchVsUnsched.pdf", width=60, height=90)
ggplot(avgStretchVsUnsched, aes(x=UnschedBytes, y=MeanStretch)) + 
    geom_line(aes(color=LoadFactor, size = 3, alpha = 0.8)) +
    facet_wrap(MsgSizeRange~WorkLoad, scales="free_y", ncol=nCols) +
    theme(text = element_text(size=30), axis.text.x = element_text(angle=45, vjust=0.5)) +
    scale_x_continuous(breaks = unique(stretchVsUnsched$UnschedBytes)) +
    scale_y_continuous(limits = c(0, NA)) +
    aes(ymin=0, xmin=0)
dev.off()

pdf("MedianStretchVsUnsched.pdf", width=60, height=90)
ggplot(medianStretchVsUnsched, aes(x=UnschedBytes, y=MedianStretch)) + 
    geom_line(aes(color=LoadFactor, size = 3, alpha = 0.8)) +
    facet_wrap(MsgSizeRange~WorkLoad, scales="free_y", ncol=nCols) +
    theme(text = element_text(size=30), axis.text.x = element_text(angle=45, vjust=0.5)) +
    scale_x_continuous(breaks = unique(stretchVsUnsched$UnschedBytes)) +
    scale_y_continuous(limits = c(0, NA)) +
    aes(ymin=0, xmin=0)
dev.off()

pdf("TailStretchVsUnsched.pdf", width=60, height=90)
ggplot(tailStretchVsUnsched, aes(x=UnschedBytes, y=TailStretch)) + 
    geom_line(aes(color=LoadFactor, size = 3, alpha = 0.8)) +
    facet_wrap(MsgSizeRange~WorkLoad, scales="free_y", ncol=nCols) +
    theme(text = element_text(size=30), axis.text.x = element_text(angle=45, vjust=0.5)) + 
    scale_x_continuous(breaks = unique(stretchVsUnsched$UnschedBytes)) +
    scale_y_continuous(limits = c(0, NA)) +
    aes(ymin=0, xmin=0)
dev.off()
