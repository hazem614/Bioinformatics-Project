#Hazem Elansary
#11/6/23
#Frederic Chain
#Bioinformatic Tools in Seq. Analysis

#RESEARCH PROJECT DRAFT

#Goal: To explore the KEGGREST command in the Bioconductor Package

setwd("/Users/hazem/Desktop/AssignmentR")
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

#Functions used:
#keggList
#keggGet
#keggLink
#keggFind

if (!requireNamespace("KEGGREST", quietly = TRUE)) {
  BiocManager::install("KEGGREST")
}
library(KEGGREST)
# Script 1: lists pathways for E. coli, gets detailed information on the 
# glycolysis/gluconeogenesis pathway,identifies related KEGG Orthology terms,
# and searches for compounds related to glucose. The information on the 
# glycolysis/gluconeogenesis pathway is also saved to a text file.

#Retrieve information about the KEGG pathway for Glycolysis / Gluconeogenesis in E. coli
#ADD KEGGCONV

#List all databases available 
listDatabases()
organisms <- data.frame(keggList("organism"))
head(organisms)
head(keggFind("genes", "eco"))
writeLines(capture.output(organisms), "listOrganisms.txt")
keggInfo("ko")
ecoli_pathways <- keggList("pathway", "eco") 
#keggList(database, organism)
print(ecoli_pathways)



# KeggFind : Searching through R Studio
compounds <- keggFind("compound", "glucose")
print(compounds)
head(keggFind("genes", c("human" , "mitochondria")))
head(keggFind("genes", c("eco", "mitochondria")))
#keggFind(database, query, option = "")
message("BREAK")

# Using keggLink to find the KEGG pathways linked from a human gene and an E.coli gene.
pathways_humanEco <- keggLink("pathway", c("hsa:55168", "pmuc:ING2E5A_1062"))
keggGet("hsa03010")
print(pathways_humanEco)
sharedPathwayInfo <- keggGet("path:hsa03010")
head(sharedPathwayInfo)
keggGet("hsa03010", "image") 
t <- tempfile()
library(png)
writePNG(png, t)
png(t, file="/Users/hazem/Desktop/AssignmentR/SharedPath.png")
dev.off
if (interactive()) browseURL(t)
message("BREAK")

#Converting Accession codes with keggConv
keggConv("ncbi-proteinid", "hsa:55168")

# Get details about the Glycolysis/Gluconeogenesis pathway
glycolysis_pathway_info <- keggGet("path:eco00010")
#keggGet(databaseentries, option = "a" (a returns all information))
print(glycolysis_pathway_info)
# Save the Glycolysis/Gluconeogenesis pathway as a list to a file
writeLines(capture.output(glycolysis_pathway_info), "glycolysis_pathway_info.txt")

message("Done.")

#EXAMPLE
#Find the 
keggFind("compounds", "C7H10", "formula")
pathways_humanEco <- keggLink("pathway", c("hsa:55168", "pmuc:ING2E5A_1062"))
head(keggFind("genes", "eco"))

