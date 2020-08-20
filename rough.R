library(Gviz)
data(cpgIslands)
class(cpgIslands)
chr <- as.character(unique(seqnames(cpgIslands)))
gen <- genome(cpgIslands)
atrack <- AnnotationTrack(cpgIslands, name = "CpG")
plotTracks(atrack)
gtrack <- GenomeAxisTrack()
plotTracks(list(gtrack, atrack))
itrack <- IdeogramTrack(genome = gen, chromosome = chr)
plotTracks(list(itrack, gtrack, atrack))


data(geneModels)
grtrack <- GeneRegionTrack(geneModels, genome = gen,
                           chromosome = chr, name = "Gene Model")
plotTracks(list(itrack, gtrack, atrack, grtrack))
plotTracks(list(itrack, gtrack, atrack, grtrack),
           from = 26700000, to = 26750000)
plotTracks(list(itrack, gtrack, atrack, grtrack),
           extend.left = 0.5, extend.right = 1000000)
plotTracks(list(itrack, gtrack, atrack, grtrack), 
           extend.left = 0.5, extend.right = 1000000, col = NULL)


library(BSgenome.Hsapiens.UCSC.hg19)
strack <- SequenceTrack(Hsapiens, chromosome = chr)
plotTracks(list(itrack, gtrack, atrack, grtrack, strack), 
           from = 26591822, to = 26591852, cex = 0.8)



set.seed(255)
lim <- c(26700000, 26750000)
coords <- sort(c(lim[1], 
                 sample(seq(from = lim[1], to = lim[2]), 99), 
                 lim[2]))
dat <- runif(100, min = -10, max = 10)
dtrack <- DataTrack(data = dat, start = coords[-length(coords)],
                    end = coords[-1], chromosome = chr, genome = gen, 
                    name = "Uniform")
plotTracks(list(itrack, gtrack, atrack, grtrack, dtrack), 
           from = lim[1], to = lim[2])



plotTracks(list(itrack, gtrack, atrack, grtrack, dtrack), 
           from = lim[1], to = lim[2], type = "histogram")





######### how to create a genomic Range object

gdata <- read.csv("targets.csv", header = TRUE, stringsAsFactors = FALSE)



dd = makeGRangesFromDataFrame(gdata,)





########### biomartr#########
library("biomaRt")
listMarts()


ensembl <- useMart("ensembl")
datasets <- listDatasets(ensembl)



ensembl = useDataset("hsapiens_gene_ensembl",mart=ensembl)


#############
library(GenomicRanges); library(rtracklayer)
gff <- import.gff("Pseudomonas_aeroginosa_PA01.gff") 

as.data.frame(gff)[1:4,1:7]

gff[1:4]
gff[1:4, c("type", "ID")] 

seqnames(gff)
strand(gff)
seqlengths(gff) 


chr <- as.character(unique(seqnames(gff)))
gen <- genome(gff)
atrack <- AnnotationTrack(gff, ucscChromosomeNames=FALSE)
plotTracks(atrack)
gtrack <- GenomeAxisTrack()


########
gffdata <- read.csv("Pseudomonas_aeroginosa_PA01.csv", header = TRUE, stringsAsFactors = FALSE)
gr <- makeGRangesFromDataFrame(genes, keep.extra.columns=TRUE)
itrack <- GenomeAxisTrack(gr)


targets <- read.csv("targets.csv", header = TRUE, stringsAsFactors = FALSE)
tt <- targets %>%
  select(Accession,Guide.start,Guide.end,Guide.strand,PAM)


dtrack <- DataTrack(data = tt$start, start = min(tt$start),
                    end = max(tt$start), chromosome = chr, genome = gen, 
                    name = "Uniform")

colnames(tt) <- c("chr", "start","end","strand","PAM")
pamtrack <- makeGRangesFromDataFrame(tt, keep.extra.columns=TRUE)

grtrack <- GeneRegionTrack(pamtrack, genome = gen,
                           chromosome = chr, name = "PAM")

atrack <- AnnotationTrack(pamtrack, name = "PAM")

plotTracks(list(itrack, gtrack, atrack))






plotTracks(list(itrack, gtrack))

pamtrack <- makeGRangesFromDataFrame(tt, keep.extra.columns=TRUE)

genes <- gffdata %>%
  filter(feature=="gene")

gr <- makeGRangesFromDataFrame(genes, keep.extra.columns=TRUE)
chr <- as.character(unique(seqnames(gr)))
gtrack <- GenomeAxisTrack(gr)


dTrack <- DataTrack(pamtrack)



plotTracks(list(gtrack, pamtrack))



gen <- genome(gr)
atrack <- AnnotationTrack(gr)
plotTracks(atrack)
gtrack <- GenomeAxisTrack(gr)


plotTracks(list(gtrack,))

plotTracks(list(itrack, gtrack, atrack))










data(twoGroups)
dTrack <- DataTrack(twoGroups, name = "uniform")
plotTracks(dTrack)
############
require(Gviz)
# if we mock up some data
grObj <- GRanges(seqnames=Rle(rep("7",4)),
                 ranges=IRanges(start=c(2000000, 2070000, 2100000, 2160000),
                                end=c(2050000, 2130000, 2150000, 2170000)),
                 strand=c("-", "+", "-", "-"),
                 group=c("Group1","Group2","Group1", "Group3"))
# make and annotation track
annTrack <- AnnotationTrack(grObj, genome="hg19", feature="test",
                            id=paste("annTrack item", 1:4),
                            name="annotation track",
                            stacking="squish")
# make and axis track
axis <- GenomeAxisTrack()
# and an ideogram (chromosome map track)
ideo <- IdeogramTrack(genome="hg19",chromosome=7)
## Now plot the tracks
res <- plotTracks(list(ideo, axis, annTrack))
########







lim <- c(min(tt$start), max(tt$start))
coords <- sort(c(lim[1], sample(seq(from = lim[1], 
                                    to = lim[2]), 99), lim[2]))

dat <- tt$start

dtrack <- DataTrack(data = dat, start = coords[-length(coords)],
                    end = coords[-1], chromosome = chr, genome = gen,
                    name = "Uniform")





