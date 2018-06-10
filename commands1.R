superpopulations <- function(chrIBDfile, ver = "new"){

	###Main function: Load Beagle Result and split result by population
	
	
	require(ggplot2)
	require(gridExtra)

	#Load Beagle result
	chr <- read.table(chrIBDfile)


	#load indiv to superpopulation mapping
	africans <- read.table("afr.list")
	europeans <- read.table("eur.list")
	eastAsians <- read.table("eas.list")
	americans <- read.table("amr.list")
	southasians <- read.table("sas.list")
	CHB <- read.table("CHB.list")
	JPT <- read.table("JPT.list")
	CHS <- read.table("CHS.list")
	CDX <- read.table("CDX.list")
	KHV <- read.table("KHV.list")
	CEU <- read.table("CEU.list")
	TSI <- read.table("TSI.list")
	FIN <- read.table("FIN.list")
	GBR <- read.table("GBR.list")
	IBS <- read.table("IBS.list")
	YRI <- read.table("YRI.list")
	LWK <- read.table("LWK.list")
	GWD <- read.table("GWD.list")
	MSL <- read.table("MSL.list")
	ESN <- read.table("ESN.list")
	ASW <- read.table("ASW.list")
	ACB <- read.table("ACB.list")
	MXL <- read.table("MXL.list")
	PUR <- read.table("PUR.list")
	CLM <- read.table("CLM.list")
	PEL <- read.table("PEL.list")
	GIH <- read.table("GIH.list")
	PJL <- read.table("PJL.list")
	BEB <- read.table("BEB.list")
	STU <- read.table("STU.list")
	ITU <- read.table("ITU.list")

	if (ver == "noanc"){
  	#europeans
  	ibdeur <- chr[chr$V1 %in% europeans$V1 | chr$V3 %in% europeans$V1,]
  	ibdeur$Length <- ibdeur$V7 - ibdeur$V6 + 1
  
  	ibdeur$Population[ibdeur$V1 %in% africans$V1 | ibdeur$V3 %in% africans$V1] <- "AFR"
  	ibdeur$Population[ibdeur$V1 %in% europeans$V1 & ibdeur$V3 %in% europeans$V1] <- "EUR"
  	ibdeur$Population[ibdeur$V1 %in% eastAsians$V1 | ibdeur$V3 %in% eastAsians$V1] <- "EAS"
  	ibdeur$Population[ibdeur$V1 %in% americans$V1 | ibdeur$V3 %in% americans$V1] <- "AMR"
  	ibdeur$Population[ibdeur$V1 %in% southasians$V1 | ibdeur$V3 %in% southasians$V1] <- "SAS"
  	ibdeur$Population[ibdeur$V1 == "AltaiNea" | ibdeur$V3 == "AltaiNea"] <- "Neandertal"
  	ibdeur$Population[ibdeur$V1 == "Chimpanzee" | ibdeur$V3 == "Chimpanzee"] <- "Chimpanzee"
  	ibdeur$Population[ibdeur$V1 == "DenisovaPinky" | ibdeur$V1 == "DNK02"] <- "Denisovan"
  
  	#africans
  	ibdafr <- chr[chr$V1 %in% africans$V1 | chr$V3 %in% africans$V1,]
  	ibdafr$Length <- ibdafr$V7 - ibdafr$V6 + 1
  
  	ibdafr$Population[ibdafr$V1 %in% africans$V1 & ibdafr$V3 %in% africans$V1] <- "AFR"
  	ibdafr$Population[ibdafr$V1 %in% europeans$V1 | ibdafr$V3 %in% europeans$V1] <- "EUR"
  	ibdafr$Population[ibdafr$V1 %in% eastAsians$V1 | ibdafr$V3 %in% eastAsians$V1] <- "EAS"
  	ibdafr$Population[ibdafr$V1 %in% americans$V1 | ibdafr$V3 %in% americans$V1] <- "AMR"
  	ibdafr$Population[ibdafr$V1 %in% southasians$V1 | ibdafr$V3 %in% southasians$V1] <- "SAS"
  	ibdafr$Population[ibdafr$V1 == "AltaiNea" | ibdafr$V3 == "AltaiNea"] <- "Neandertal"
  	ibdafr$Population[ibdafr$V1 == "Chimpanzee" | ibdafr$V3 == "Chimpanzee"] <- "Chimpanzee"
  	ibdafr$Population[ibdafr$V1 == "DenisovaPinky" | ibdafr$V1 == "DNK02"] <- "Denisovan"
  
  	#south asians
  	ibdsas <- chr[chr$V1 %in% southasians$V1 | chr$V3 %in% southasians$V1,]
  	ibdsas$Length <- ibdsas$V7 - ibdsas$V6 + 1
  
  	ibdsas$Population[ibdsas$V1 %in% africans$V1 | ibdsas$V3 %in% africans$V1] <- "AFR"
  	ibdsas$Population[ibdsas$V1 %in% europeans$V1 | ibdsas$V3 %in% europeans$V1] <- "EUR"
  	ibdsas$Population[ibdsas$V1 %in% eastAsians$V1 | ibdsas$V3 %in% eastAsians$V1] <- "EAS"
  	ibdsas$Population[ibdsas$V1 %in% americans$V1 | ibdsas$V3 %in% americans$V1] <- "AMR"
  	ibdsas$Population[ibdsas$V1 %in% southasians$V1 & ibdsas$V3 %in% southasians$V1] <- "SAS"
  	ibdsas$Population[ibdsas$V1 == "AltaiNea" | ibdsas$V3 == "AltaiNea"] <- "Neandertal"
  	ibdsas$Population[ibdsas$V1 == "Chimpanzee" | ibdsas$V3 == "Chimpanzee"] <- "Chimpanzee"
  	ibdsas$Population[ibdsas$V1 == "DenisovaPinky" | ibdsas$V1 == "DNK02"] <- "Denisovan"
  
  	#east asians
  	ibdeas <- chr[chr$V1 %in% eastAsians$V1 | chr$V3 %in% eastAsians$V1,]
  	ibdeas$Length <- ibdeas$V7 - ibdeas$V6 + 1
  
  	ibdeas$Population[ibdeas$V1 %in% africans$V1 | ibdeas$V3 %in% africans$V1] <- "AFR"
  	ibdeas$Population[ibdeas$V1 %in% europeans$V1 | ibdeas$V3 %in% europeans$V1] <- "EUR"
  	ibdeas$Population[ibdeas$V1 %in% eastAsians$V1 & ibdeas$V3 %in% eastAsians$V1] <- "EAS"
  	ibdeas$Population[ibdeas$V1 %in% americans$V1 | ibdeas$V3 %in% americans$V1] <- "AMR"
  	ibdeas$Population[ibdeas$V1 %in% southasians$V1 | ibdeas$V3 %in% southasians$V1] <- "SAS"
  	ibdeas$Population[ibdeas$V1 == "AltaiNea" | ibdeas$V3 == "AltaiNea"] <- "Neandertal"
  	ibdeas$Population[ibdeas$V1 == "Chimpanzee" | ibdeas$V3 == "Chimpanzee"] <- "Chimpanzee"
  	ibdeas$Population[ibdeas$V1 == "DenisovaPinky" | ibdeas$V1 == "DNK02"] <- "Denisovan"
  
  	#americans
  	ibdamr <- chr[chr$V1 %in% americans$V1 | chr$V3 %in% americans$V1,]
  	ibdamr$Length <- ibdamr$V7 - ibdamr$V6 + 1
  
  	ibdamr$Population[ibdamr$V1 %in% africans$V1 | ibdamr$V3 %in% africans$V1] <- "AFR"
  	ibdamr$Population[ibdamr$V1 %in% europeans$V1 | ibdamr$V3 %in% europeans$V1] <- "EUR"
  	ibdamr$Population[ibdamr$V1 %in% eastAsians$V1 | ibdamr$V3 %in% eastAsians$V1] <- "EAS"
  	ibdamr$Population[ibdamr$V1 %in% americans$V1 & ibdamr$V3 %in% americans$V1] <- "AMR"
  	ibdamr$Population[ibdamr$V1 %in% southasians$V1 | ibdamr$V3 %in% southasians$V1] <- "SAS"
  	ibdamr$Population[ibdamr$V1 == "AltaiNea" | ibdamr$V3 == "AltaiNea"] <- "Neandertal"
  	ibdamr$Population[ibdamr$V1 == "Chimpanzee" | ibdamr$V3 == "Chimpanzee"] <- "Chimpanzee"
  	ibdamr$Population[ibdamr$V1 == "DenisovaPinky" | ibdamr$V1 == "DNK02"] <- "Denisovan"
	}
	
	##Denisovans
	ibdden <- chr[chr$V1 == "DenisovaPinky" | chr$V3 == "DenisovaPinky" | chr$V1 == "DNK02" | chr$V3 == "DNK02",]
	ibdden$Length <- ibdden$V7 - ibdden$V6 + 1

	ibdden$Population[ibdden$V1 %in% africans$V1 | ibdden$V3 %in% africans$V1] <- "AFR"
	ibdden$Population[ibdden$V1 %in% europeans$V1 | ibdden$V3 %in% europeans$V1] <- "EUR"
	ibdden$Population[ibdden$V1 %in% eastAsians$V1 | ibdden$V3 %in% eastAsians$V1] <- "EAS"
	ibdden$Population[ibdden$V1 %in% americans$V1 | ibdden$V3 %in% americans$V1] <- "AMR"
	ibdden$Population[ibdden$V1 %in% southasians$V1 | ibdden$V3 %in% southasians$V1] <- "SAS"
	ibdden$Population[ibdden$V1 == "AltaiNea" | ibdden$V3 == "AltaiNea"] <- "Neandertal"
	ibdden$Population[ibdden$V1 == "Chimpanzee" | ibdden$V3 == "Chimpanzee"] <- "Chimpanzee"
	ibdden$Population[(ibdden$V1 == "DenisovaPinky" & ibdden$V3 == "DenisovaPinky") | (ibdden$V1 == "DNK02" & ibdden$V3 == "DNK02")] <- "Denisovan"
	##subpops
	ibdden$Subpopulation[ibdden$V1 %in% CHB$V1 | ibdden$V3 %in% CHB$V1] <- "CHB"
	ibdden$Subpopulation[ibdden$V1 %in% JPT$V1 | ibdden$V3 %in% JPT$V1] <- "JPT"
	ibdden$Subpopulation[ibdden$V1 %in% CHS$V1 | ibdden$V3 %in% CHS$V1] <- "CHS"
	ibdden$Subpopulation[ibdden$V1 %in% CDX$V1 | ibdden$V3 %in% CDX$V1] <- "CDX"
	ibdden$Subpopulation[ibdden$V1 %in% KHV$V1 | ibdden$V3 %in% KHV$V1] <- "KHV"
	ibdden$Subpopulation[ibdden$V1 %in% CEU$V1 | ibdden$V3 %in% CEU$V1] <- "CEU"
	ibdden$Subpopulation[ibdden$V1 %in% TSI$V1 | ibdden$V3 %in% TSI$V1] <- "TSI"
	ibdden$Subpopulation[ibdden$V1 %in% FIN$V1 | ibdden$V3 %in% FIN$V1] <- "FIN"
	ibdden$Subpopulation[ibdden$V1 %in% GBR$V1 | ibdden$V3 %in% GBR$V1] <- "GBR"
	ibdden$Subpopulation[ibdden$V1 %in% IBS$V1 | ibdden$V3 %in% IBS$V1] <- "IBS"
	ibdden$Subpopulation[ibdden$V1 %in% YRI$V1 | ibdden$V3 %in% YRI$V1] <- "YRI"
	ibdden$Subpopulation[ibdden$V1 %in% LWK$V1 | ibdden$V3 %in% LWK$V1] <- "LWK"
	ibdden$Subpopulation[ibdden$V1 %in% GWD$V1 | ibdden$V3 %in% GWD$V1] <- "GWD"
	ibdden$Subpopulation[ibdden$V1 %in% MSL$V1 | ibdden$V3 %in% MSL$V1] <- "MSL"
	ibdden$Subpopulation[ibdden$V1 %in% ESN$V1 | ibdden$V3 %in% ESN$V1] <- "ESN"
	ibdden$Subpopulation[ibdden$V1 %in% ASW$V1 | ibdden$V3 %in% ASW$V1] <- "ASW"
	ibdden$Subpopulation[ibdden$V1 %in% ACB$V1 | ibdden$V3 %in% ACB$V1] <- "ACB"
	ibdden$Subpopulation[ibdden$V1 %in% MXL$V1 | ibdden$V3 %in% MXL$V1] <- "MXL"
	ibdden$Subpopulation[ibdden$V1 %in% PUR$V1 | ibdden$V3 %in% PUR$V1] <- "PUR"
	ibdden$Subpopulation[ibdden$V1 %in% CLM$V1 | ibdden$V3 %in% CLM$V1] <- "CLM"
	ibdden$Subpopulation[ibdden$V1 %in% PEL$V1 | ibdden$V3 %in% PEL$V1] <- "PEL"
	ibdden$Subpopulation[ibdden$V1 %in% GIH$V1 | ibdden$V3 %in% GIH$V1] <- "GIH"
	ibdden$Subpopulation[ibdden$V1 %in% PJL$V1 | ibdden$V3 %in% PJL$V1] <- "PJL"
	ibdden$Subpopulation[ibdden$V1 %in% BEB$V1 | ibdden$V3 %in% BEB$V1] <- "BEB"
	ibdden$Subpopulation[ibdden$V1 %in% STU$V1 | ibdden$V3 %in% STU$V1] <- "STU"
	ibdden$Subpopulation[ibdden$V1 %in% ITU$V1 | ibdden$V3 %in% ITU$V1] <- "ITU"
	#patch ancients
	ibdden$Subpopulation[ibdden$V1 == "AltaiNea" | ibdden$V3 == "AltaiNea"] <- "Neandertal"
	ibdden$Subpopulation[ibdden$V1 == "Hybrid" | ibdden$V3 == "Hybrid"] <- "Hybrid"
	ibdden$Subpopulation[(grepl("Pan", ibdden$V1, ignore.case	= TRUE) | grepl("Pan", ibdden$V3, ignore.case	= TRUE))] <- "Chimpanzee"
	#random
	ibdden$Subpopulation[(grepl("rNA", ibdden$V1) | grepl("rNA", ibdden$V3))] <- "RYRI"
	ibdden$Population[(grepl("rNA", ibdden$V1) | grepl("rNA", ibdden$V3))] <- "AFR"
	ibdden$Subpopulation[(grepl("Random", ibdden$V1) | grepl("Random", ibdden$V3))] <- "Random"
	ibdden$Population[(grepl("Random", ibdden$V1) | grepl("Random", ibdden$V3))] <- "Random"

	##Neandertals
	ibdnea <- chr[chr$V1 == "AltaiNea" | chr$V3 == "AltaiNea",]
	ibdnea$Length <- ibdnea$V7 - ibdnea$V6 + 1

	ibdnea$Population[ibdnea$V1 %in% africans$V1 | ibdnea$V3 %in% africans$V1] <- "AFR"
	ibdnea$Population[ibdnea$V1 %in% europeans$V1 | ibdnea$V3 %in% europeans$V1] <- "EUR"
	ibdnea$Population[ibdnea$V1 %in% eastAsians$V1 | ibdnea$V3 %in% eastAsians$V1] <- "EAS"
	ibdnea$Population[ibdnea$V1 %in% americans$V1 | ibdnea$V3 %in% americans$V1] <- "AMR"
	ibdnea$Population[ibdnea$V1 %in% southasians$V1 | ibdnea$V3 %in% southasians$V1] <- "SAS"
	ibdnea$Population[ibdnea$V1 == "AltaiNea" & ibdnea$V3 == "AltaiNea"] <- "Neandertal"
	ibdnea$Population[ibdnea$V1 == "DenisovaPinky" | ibdnea$V3 == "DenisovaPinky"| ibdnea$V1 == "DNK02" | ibdnea$V3 == "DNK02"] <- "Denisovan"
	ibdnea$Population[ibdnea$V1 == "Chimpanzee" | ibdnea$V3 == "Chimpanzee"] <- "Chimpanzee"
	##subpops
	ibdnea$Subpopulation[ibdnea$V1 %in% CHB$V1 | ibdnea$V3 %in% CHB$V1] <- "CHB"
	ibdnea$Subpopulation[ibdnea$V1 %in% JPT$V1 | ibdnea$V3 %in% JPT$V1] <- "JPT"
	ibdnea$Subpopulation[ibdnea$V1 %in% CHS$V1 | ibdnea$V3 %in% CHS$V1] <- "CHS"
	ibdnea$Subpopulation[ibdnea$V1 %in% CDX$V1 | ibdnea$V3 %in% CDX$V1] <- "CDX"
	ibdnea$Subpopulation[ibdnea$V1 %in% KHV$V1 | ibdnea$V3 %in% KHV$V1] <- "KHV"
	ibdnea$Subpopulation[ibdnea$V1 %in% CEU$V1 | ibdnea$V3 %in% CEU$V1] <- "CEU"
	ibdnea$Subpopulation[ibdnea$V1 %in% TSI$V1 | ibdnea$V3 %in% TSI$V1] <- "TSI"
	ibdnea$Subpopulation[ibdnea$V1 %in% FIN$V1 | ibdnea$V3 %in% FIN$V1] <- "FIN"
	ibdnea$Subpopulation[ibdnea$V1 %in% GBR$V1 | ibdnea$V3 %in% GBR$V1] <- "GBR"
	ibdnea$Subpopulation[ibdnea$V1 %in% IBS$V1 | ibdnea$V3 %in% IBS$V1] <- "IBS"
	ibdnea$Subpopulation[ibdnea$V1 %in% YRI$V1 | ibdnea$V3 %in% YRI$V1] <- "YRI"
	ibdnea$Subpopulation[ibdnea$V1 %in% LWK$V1 | ibdnea$V3 %in% LWK$V1] <- "LWK"
	ibdnea$Subpopulation[ibdnea$V1 %in% GWD$V1 | ibdnea$V3 %in% GWD$V1] <- "GWD"
	ibdnea$Subpopulation[ibdnea$V1 %in% MSL$V1 | ibdnea$V3 %in% MSL$V1] <- "MSL"
	ibdnea$Subpopulation[ibdnea$V1 %in% ESN$V1 | ibdnea$V3 %in% ESN$V1] <- "ESN"
	ibdnea$Subpopulation[ibdnea$V1 %in% ASW$V1 | ibdnea$V3 %in% ASW$V1] <- "ASW"
	ibdnea$Subpopulation[ibdnea$V1 %in% ACB$V1 | ibdnea$V3 %in% ACB$V1] <- "ACB"
	ibdnea$Subpopulation[ibdnea$V1 %in% MXL$V1 | ibdnea$V3 %in% MXL$V1] <- "MXL"
	ibdnea$Subpopulation[ibdnea$V1 %in% PUR$V1 | ibdnea$V3 %in% PUR$V1] <- "PUR"
	ibdnea$Subpopulation[ibdnea$V1 %in% CLM$V1 | ibdnea$V3 %in% CLM$V1] <- "CLM"
	ibdnea$Subpopulation[ibdnea$V1 %in% PEL$V1 | ibdnea$V3 %in% PEL$V1] <- "PEL"
	ibdnea$Subpopulation[ibdnea$V1 %in% GIH$V1 | ibdnea$V3 %in% GIH$V1] <- "GIH"
	ibdnea$Subpopulation[ibdnea$V1 %in% PJL$V1 | ibdnea$V3 %in% PJL$V1] <- "PJL"
	ibdnea$Subpopulation[ibdnea$V1 %in% BEB$V1 | ibdnea$V3 %in% BEB$V1] <- "BEB"
	ibdnea$Subpopulation[ibdnea$V1 %in% STU$V1 | ibdnea$V3 %in% STU$V1] <- "STU"
	ibdnea$Subpopulation[ibdnea$V1 %in% ITU$V1 | ibdnea$V3 %in% ITU$V1] <- "ITU"
	#patch ancients
	ibdnea$Subpopulation[ibdnea$V1 == "DenisovaPinky" | ibdnea$V3 == "DenisovaPinky" | ibdnea$V1 == "DNK02" | ibdnea$V3 == "DNK02"] <- "Denisovan"
	ibdnea$Subpopulation[(grepl("Pan", ibdnea$V1, ignore.case	= TRUE) | grepl("Pan", ibdnea$V3, ignore.case	= TRUE))] <- "Chimpanzee"
	#random
	ibdnea$Subpopulation[(grepl("rNA", ibdnea$V1) | grepl("rNA", ibdnea$V3))] <- "RLWK"
	ibdnea$Population[(grepl("rNA", ibdnea$V1) | grepl("rNA", ibdnea$V3))] <- "AFR"
	ibdnea$Subpopulation[(grepl("Random", ibdnea$V1) | grepl("Random", ibdnea$V3))] <- "Random"
	ibdnea$Population[(grepl("Random", ibdnea$V1) | grepl("Random", ibdnea$V3))] <- "Random"
	
	##Hybrid
	ibdhyb <- chr[chr$V1 == "Hybrid" | chr$V3 == "Hybrid",]
	ibdhyb$Length <- ibdhyb$V7 - ibdhyb$V6 + 1

	ibdhyb$Population[ibdhyb$V1 %in% africans$V1 | ibdhyb$V3 %in% africans$V1] <- "AFR"
	ibdhyb$Population[ibdhyb$V1 %in% europeans$V1 | ibdhyb$V3 %in% europeans$V1] <- "EUR"
	ibdhyb$Population[ibdhyb$V1 %in% eastAsians$V1 | ibdhyb$V3 %in% eastAsians$V1] <- "EAS"
	ibdhyb$Population[ibdhyb$V1 %in% americans$V1 | ibdhyb$V3 %in% americans$V1] <- "AMR"
	ibdhyb$Population[ibdhyb$V1 %in% southasians$V1 | ibdhyb$V3 %in% southasians$V1] <- "SAS"
	ibdhyb$Population[ibdhyb$V1 == "Hybrid" & ibdhyb$V3 == "Hybrid"] <- "Hybrid"
	ibdhyb$Population[ibdhyb$V1 == "AltaiNea" | ibdhyb$V3 == "AltaiNea"] <- "Neandertal"
	ibdhyb$Population[ibdhyb$V1 == "DenisovaPinky" | ibdhyb$V3 == "DenisovaPinky"| ibdhyb$V1 == "DNK02" | ibdhyb$V3 == "DNK02"] <- "Denisovan"
	ibdhyb$Population[ibdhyb$V1 == "Chimpanzee" | ibdhyb$V3 == "Chimpanzee"] <- "Chimpanzee"
	##subpops
	ibdhyb$Subpopulation[ibdhyb$V1 %in% CHB$V1 | ibdhyb$V3 %in% CHB$V1] <- "CHB"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% JPT$V1 | ibdhyb$V3 %in% JPT$V1] <- "JPT"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% CHS$V1 | ibdhyb$V3 %in% CHS$V1] <- "CHS"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% CDX$V1 | ibdhyb$V3 %in% CDX$V1] <- "CDX"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% KHV$V1 | ibdhyb$V3 %in% KHV$V1] <- "KHV"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% CEU$V1 | ibdhyb$V3 %in% CEU$V1] <- "CEU"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% TSI$V1 | ibdhyb$V3 %in% TSI$V1] <- "TSI"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% FIN$V1 | ibdhyb$V3 %in% FIN$V1] <- "FIN"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% GBR$V1 | ibdhyb$V3 %in% GBR$V1] <- "GBR"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% IBS$V1 | ibdhyb$V3 %in% IBS$V1] <- "IBS"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% YRI$V1 | ibdhyb$V3 %in% YRI$V1] <- "YRI"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% LWK$V1 | ibdhyb$V3 %in% LWK$V1] <- "LWK"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% GWD$V1 | ibdhyb$V3 %in% GWD$V1] <- "GWD"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% MSL$V1 | ibdhyb$V3 %in% MSL$V1] <- "MSL"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% ESN$V1 | ibdhyb$V3 %in% ESN$V1] <- "ESN"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% ASW$V1 | ibdhyb$V3 %in% ASW$V1] <- "ASW"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% ACB$V1 | ibdhyb$V3 %in% ACB$V1] <- "ACB"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% MXL$V1 | ibdhyb$V3 %in% MXL$V1] <- "MXL"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% PUR$V1 | ibdhyb$V3 %in% PUR$V1] <- "PUR"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% CLM$V1 | ibdhyb$V3 %in% CLM$V1] <- "CLM"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% PEL$V1 | ibdhyb$V3 %in% PEL$V1] <- "PEL"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% GIH$V1 | ibdhyb$V3 %in% GIH$V1] <- "GIH"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% PJL$V1 | ibdhyb$V3 %in% PJL$V1] <- "PJL"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% BEB$V1 | ibdhyb$V3 %in% BEB$V1] <- "BEB"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% STU$V1 | ibdhyb$V3 %in% STU$V1] <- "STU"
	ibdhyb$Subpopulation[ibdhyb$V1 %in% ITU$V1 | ibdhyb$V3 %in% ITU$V1] <- "ITU"
	#patch ancients
	ibdhyb$Subpopulation[ibdhyb$V1 == "AltaiNea" | ibdhyb$V3 == "AltaiNea"] <- "Neandertal"
	ibdhyb$Subpopulation[ibdhyb$V1 == "DenisovaPinky" | ibdhyb$V3 == "DenisovaPinky" | ibdhyb$V1 == "DNK02" | ibdhyb$V3 == "DNK02"] <- "Denisovan"
	ibdhyb$Subpopulation[(grepl("Pan", ibdhyb$V1, ignore.case	= TRUE) | grepl("Pan", ibdhyb$V3, ignore.case	= TRUE))] <- "Chimpanzee"

	##Chimpanzee
	
	#one chimp results
	if (ver == "old"){
		ibdchimp <- chr[chr$V1 == "Chimpanzee" | chr$V3 == "Chimpanzee",]
		ibdchimp$Length <- ibdchimp$V7 - ibdchimp$V6 + 1

		ibdchimp$Population[ibdchimp$V1 %in% africans$V1 | ibdchimp$V3 %in% africans$V1] <- "AFR"
		ibdchimp$Population[ibdchimp$V1 %in% europeans$V1 | ibdchimp$V3 %in% europeans$V1] <- "EUR"
		ibdchimp$Population[ibdchimp$V1 %in% eastAsians$V1 | ibdchimp$V3 %in% eastAsians$V1] <- "EAS"
		ibdchimp$Population[ibdchimp$V1 %in% americans$V1 | ibdchimp$V3 %in% americans$V1] <- "AMR"
		ibdchimp$Population[ibdchimp$V1 %in% southasians$V1 | ibdchimp$V3 %in% southasians$V1] <- "SAS"
		ibdchimp$Population[ibdchimp$V1 == "Chimpanzee" & ibdchimp$V3 == "Chimpanzee"] <- "Chimpanzee"
		ibdchimp$Population[ibdchimp$V1 == "DenisovaPinky" | ibdchimp$V3 == "DenisovaPinky" | ibdchimp$V1 == "DNK02" | ibdchimp$V3 == "DNK02"] <- "Denisovan"
		ibdchimp$Population[ibdchimp$V1 == "AltaiNea" | ibdchimp$V3 == "AltaiNea"] <- "Neandertal"
		return(list("ibdeur" = ibdeur, "ibdafr" = ibdafr, "ibdeas" = ibdeas, "ibdsas" = ibdsas, "ibdamr" = ibdamr, "ibdden" = ibdden, "ibdnea" = ibdnea, "ibdchimp" = ibdchimp))
	}
	#many chimps results
	else {
		ibdchimp <- chr[(grepl("Pan", chr$V1, ignore.case	= TRUE) | grepl("Pan", chr$V3, ignore.case	= TRUE)),]
		ibdchimp$Length <- ibdchimp$V7 - ibdchimp$V6 + 1

		ibdchimp$Population[ibdchimp$V1 %in% africans$V1 | ibdchimp$V3 %in% africans$V1] <- "AFR"
		ibdchimp$Population[ibdchimp$V1 %in% europeans$V1 | ibdchimp$V3 %in% europeans$V1] <- "EUR"
		ibdchimp$Population[ibdchimp$V1 %in% eastAsians$V1 | ibdchimp$V3 %in% eastAsians$V1] <- "EAS"
		ibdchimp$Population[ibdchimp$V1 %in% americans$V1 | ibdchimp$V3 %in% americans$V1] <- "AMR"
		ibdchimp$Population[ibdchimp$V1 %in% southasians$V1 | ibdchimp$V3 %in% southasians$V1] <- "SAS"
		ibdchimp$Population[(grepl("Pan", ibdchimp$V1, ignore.case	= TRUE) & grepl("Pan", ibdchimp$V3, ignore.case	= TRUE))] <- "Chimpanzee"
		ibdchimp$Population[ibdchimp$V1 == "DenisovaPinky" | ibdchimp$V3 == "DenisovaPinky" | ibdchimp$V1 == "DNK02" | ibdchimp$V3 == "DNK02"] <- "Denisovan"
		ibdchimp$Population[ibdchimp$V1 == "AltaiNea" | ibdchimp$V3 == "AltaiNea"] <- "Neandertal"
		
		#patch the others
		#ibdeur$Population[(grepl("Pan", ibdeur$V1, ignore.case	= TRUE) | grepl("Pan", ibdeur$V3, ignore.case	= TRUE))] <- "Chimpanzee"
		#ibdafr$Population[(grepl("Pan", ibdafr$V1, ignore.case	= TRUE) | grepl("Pan", ibdafr$V3, ignore.case	= TRUE))] <- "Chimpanzee"
		#ibdamr$Population[(grepl("Pan", ibdamr$V1, ignore.case	= TRUE) | grepl("Pan", ibdamr$V3, ignore.case	= TRUE))] <- "Chimpanzee"
		#ibdeas$Population[(grepl("Pan", ibdeas$V1, ignore.case	= TRUE) | grepl("Pan", ibdeas$V3, ignore.case	= TRUE))] <- "Chimpanzee"
		#ibdsas$Population[(grepl("Pan", ibdsas$V1, ignore.case	= TRUE) | grepl("Pan", ibdsas$V3, ignore.case	= TRUE))] <- "Chimpanzee"
		ibdnea$Population[(grepl("Pan", ibdnea$V1, ignore.case	= TRUE) | grepl("Pan", ibdnea$V3, ignore.case	= TRUE))] <- "Chimpanzee"
		ibdden$Population[(grepl("Pan", ibdden$V1, ignore.case	= TRUE) | grepl("Pan", ibdden$V3, ignore.case	= TRUE))] <- "Chimpanzee"
		##subpops
		ibdchimp$Subpopulation[ibdchimp$V1 %in% CHB$V1 | ibdchimp$V3 %in% CHB$V1] <- "CHB"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% JPT$V1 | ibdchimp$V3 %in% JPT$V1] <- "JPT"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% CHS$V1 | ibdchimp$V3 %in% CHS$V1] <- "CHS"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% CDX$V1 | ibdchimp$V3 %in% CDX$V1] <- "CDX"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% KHV$V1 | ibdchimp$V3 %in% KHV$V1] <- "KHV"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% CEU$V1 | ibdchimp$V3 %in% CEU$V1] <- "CEU"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% TSI$V1 | ibdchimp$V3 %in% TSI$V1] <- "TSI"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% FIN$V1 | ibdchimp$V3 %in% FIN$V1] <- "FIN"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% GBR$V1 | ibdchimp$V3 %in% GBR$V1] <- "GBR"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% IBS$V1 | ibdchimp$V3 %in% IBS$V1] <- "IBS"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% YRI$V1 | ibdchimp$V3 %in% YRI$V1] <- "YRI"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% LWK$V1 | ibdchimp$V3 %in% LWK$V1] <- "LWK"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% GWD$V1 | ibdchimp$V3 %in% GWD$V1] <- "GWD"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% MSL$V1 | ibdchimp$V3 %in% MSL$V1] <- "MSL"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% ESN$V1 | ibdchimp$V3 %in% ESN$V1] <- "ESN"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% ASW$V1 | ibdchimp$V3 %in% ASW$V1] <- "ASW"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% ACB$V1 | ibdchimp$V3 %in% ACB$V1] <- "ACB"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% MXL$V1 | ibdchimp$V3 %in% MXL$V1] <- "MXL"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% PUR$V1 | ibdchimp$V3 %in% PUR$V1] <- "PUR"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% CLM$V1 | ibdchimp$V3 %in% CLM$V1] <- "CLM"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% PEL$V1 | ibdchimp$V3 %in% PEL$V1] <- "PEL"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% GIH$V1 | ibdchimp$V3 %in% GIH$V1] <- "GIH"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% PJL$V1 | ibdchimp$V3 %in% PJL$V1] <- "PJL"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% BEB$V1 | ibdchimp$V3 %in% BEB$V1] <- "BEB"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% STU$V1 | ibdchimp$V3 %in% STU$V1] <- "STU"
		ibdchimp$Subpopulation[ibdchimp$V1 %in% ITU$V1 | ibdchimp$V3 %in% ITU$V1] <- "ITU"
		#patch ancients
		ibdchimp$Subpopulation[ibdchimp$V1 == "DenisovaPinky" | ibdchimp$V3 == "DenisovaPinky" | ibdchimp$V1 == "DNK02" | ibdchimp$V3 == "DNK02"] <- "Denisovan"
		ibdchimp$Subpopulation[ibdchimp$V1 == "AltaiNea" | ibdchimp$V3 == "AltaiNea"] <- "Neandertal"
		ibdchimp$Subpopulation[ibdchimp$V1 == "Hybrid" | ibdchimp$V3 == "Hybrid"] <- "Hybrid"
		ibdchimp$Subpopulation[(grepl("Pan", ibdchimp$V1, ignore.case	= TRUE) & grepl("Pan", ibdchimp$V3, ignore.case	= TRUE))] <- "Chimpanzee"
		#random
		ibdchimp$Subpopulation[(grepl("rNA", ibdchimp$V1) | grepl("rNA", ibdchimp$V3))] <- "RLWK"
		ibdchimp$Population[(grepl("rNA", ibdchimp$V1) | grepl("rNA", ibdchimp$V3))] <- "AFR"
		ibdchimp$Subpopulation[(grepl("Random", ibdchimp$V1) | grepl("Random", ibdchimp$V3))] <- "Random"
		ibdchimp$Population[(grepl("Random", ibdchimp$V1) | grepl("Random", ibdchimp$V3))] <- "Random"
		
		if (ver == "noanc"){
		  return(list("ibdeur" = ibdeur, "ibdafr" = ibdafr, "ibdeas" = ibdeas, "ibdsas" = ibdsas, "ibdamr" = ibdamr, "ibdden" = ibdden, "ibdnea" = ibdnea, "ibdhyb" = ibdhyb, "ibdchimp" = ibdchimp))
		}
		else{
		  return(list("ibdden" = ibdden, "ibdnea" = ibdnea, "ibdhyb" = ibdhyb, "ibdchimp" = ibdchimp))
		}
	}
}

drawMSL <- function(populations){
	#draws histogram's polygon plots
	
	frqeur <- ggplot(data=populations$ibdeur, aes(Length, color=Population)) + geom_freqpoly(binwidth = 10000) + ggtitle("Europeans") + 
	  guides(colour = guide_legend(override.aes = list(size = 5))) +
	  theme(legend.key=element_rect(fill=NA)) + scale_color_brewer(palette="Dark2")
	frqafr <- ggplot(data=populations$ibdafr, aes(Length, color=Population)) + geom_freqpoly(binwidth = 10000) + ggtitle("Africans") + 
	  guides(colour = guide_legend(override.aes = list(size = 5))) +
	  theme(legend.key=element_rect(fill=NA)) + scale_color_brewer(palette="Dark2")
	frqamr <- ggplot(data=populations$ibdamr, aes(Length, color=Population)) + geom_freqpoly(binwidth = 10000) + ggtitle("Americans") + 
	  guides(colour = guide_legend(override.aes = list(size = 5))) +
	  theme(legend.key=element_rect(fill=NA)) + scale_color_brewer(palette="Dark2")
	frqeas <- ggplot(data=populations$ibdeas, aes(Length, color=Population)) + geom_freqpoly(binwidth = 10000) + ggtitle("East Asians") + 
	  guides(colour = guide_legend(override.aes = list(size = 5))) +
	  theme(legend.key=element_rect(fill=NA)) + scale_color_brewer(palette="Dark2")
	frqsas <- ggplot(data=populations$ibdsas, aes(Length, color=Population)) + geom_freqpoly(binwidth = 10000) + ggtitle("South Asians") + 
	  guides(colour = guide_legend(override.aes = list(size = 5))) +
	  theme(legend.key=element_rect(fill=NA)) + scale_color_brewer(palette="Dark2")

	grid.arrange(frqeur, frqafr, frqamr, frqeas, frqsas, ncol=2)
}

MeanSegLen <- function(populations){
	#Calculating mean segment length between pairs of populations
	eurmeanlen <- as.list(by(populations$ibdeur$Length, populations$ibdeur$Population, FUN = mean))
	amrmeanlen <- as.list(by(populations$ibdamr$Length, populations$ibdamr$Population, FUN = mean))
	afrmeanlen <- as.list(by(populations$ibdafr$Length, populations$ibdafr$Population, FUN = mean))
	sasmeanlen <- as.list(by(populations$ibdsas$Length, populations$ibdsas$Population, FUN = mean))
	easmeanlen <- as.list(by(populations$ibdeas$Length, populations$ibdeas$Population, FUN = mean))
	meanLengths <- do.call(rbind, Map(data.frame, AFR=afrmeanlen, AMR=amrmeanlen, EAS=easmeanlen, EUR=eurmeanlen, SAS=sasmeanlen))
	return(meanLengths)
}

TotalPairwiseLen <- function(populations){
	#adding the lenths of the segments for each pair of individuals
	byTotalPairwiseEUR <- aggregate(populations$ibdeur[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdeur[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdeur[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdeur[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseAFR <- aggregate(populations$ibdafr[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdafr[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdafr[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdafr[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseAMR <- aggregate(populations$ibdamr[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdamr[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdamr[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdamr[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseEAS <- aggregate(populations$ibdeas[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdeas[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdeas[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdeas[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseSAS <- aggregate(populations$ibdsas[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdsas[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdsas[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdsas[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseCHIMP <- aggregate(populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	
	#calculating mean total pairwise length for each population pair
	eurmeanlen <- as.list(by(byTotalPairwiseEUR$x, byTotalPairwiseEUR$Group.3, FUN = mean))
	amrmeanlen <- as.list(by(byTotalPairwiseAMR$x, byTotalPairwiseAMR$Group.3, FUN = mean))
	afrmeanlen <- as.list(by(byTotalPairwiseAFR$x, byTotalPairwiseAFR$Group.3, FUN = mean))
	sasmeanlen <- as.list(by(byTotalPairwiseSAS$x, byTotalPairwiseSAS$Group.3, FUN = mean))
	easmeanlen <- as.list(by(byTotalPairwiseEAS$x, byTotalPairwiseEAS$Group.3, FUN = mean))
	chimpmeanlen <- as.list(by(byTotalPairwiseCHIMP$x, byTotalPairwiseCHIMP$Group.3, FUN = mean))
	
	#plots
	eur <- ggplot(data = byTotalPairwiseEUR[byTotalPairwiseEUR$Group.3 != "EUR",], aes(x=Group.3, y=x, color=Group.3)) + geom_violin(trim = FALSE) + ggtitle("Europeans") + theme(legend.position="none")
	afr <- ggplot(data = byTotalPairwiseAFR[byTotalPairwiseAFR$Group.3 != "AFR",], aes(x=Group.3, y=x, color=Group.3)) + geom_violin(trim = FALSE) + ggtitle("Africans") + theme(legend.position="none")
	amr <- ggplot(data = byTotalPairwiseAMR[byTotalPairwiseAMR$Group.3 != "AMR",], aes(x=Group.3, y=x, color=Group.3)) + geom_violin(trim = FALSE) + ggtitle("Americans") + theme(legend.position="none")
	eas <- ggplot(data = byTotalPairwiseEAS[byTotalPairwiseEAS$Group.3 != "EAS",], aes(x=Group.3, y=x, color=Group.3)) + geom_violin(trim = FALSE) + ggtitle("East Asians") + theme(legend.position="none")
	sas <- ggplot(data = byTotalPairwiseSAS[byTotalPairwiseSAS$Group.3 != "SAS",], aes(x=Group.3, y=x, color=Group.3)) + geom_violin(trim = FALSE) + ggtitle("South Asians") + theme(legend.position="none")
	chimp <- ggplot(data = byTotalPairwiseCHIMP[byTotalPairwiseCHIMP$Group.3 != "CHIMP",], aes(x=Group.3, y=x, color=Group.3)) + geom_violin(trim = FALSE) + ggtitle("Chimpanzees") + theme(legend.position="none")
	
	grid.arrange(eur, afr, amr, eas, sas, ncol=2)
	#output
	meanLengths <- do.call(rbind, Map(data.frame, AFR=afrmeanlen, AMR=amrmeanlen, EAS=easmeanlen, EUR=eurmeanlen, SAS=sasmeanlen, CHIMP=chimpmeanlen))
	return(meanLengths)
}

SegCount <- function(populations){
	#Total number of segments shared between pairs of populations
	eurcount <- table(populations$ibdeur$Population)
	eascount <- table(populations$ibdeas$Population)
	afrcount <- table(populations$ibdafr$Population)
	dencount <- table(populations$ibdden$Population)
	neacount <- table(populations$ibdnea$Population)
	chimpcount <- table(populations$ibdchimp$Population)

	segCounts <- do.call(rbind, Map(data.frame, AFR=afrcount, EAS=eascount, EUR=eurcount, DEN=dencount, NEA=neacount, CHIMP=chimpcount))
	return(segCounts)
}

SegCountv2 <- function(populations){
  #Total number of segments shared between pairs of populations
  dencount <- table(populations$ibdden$Population)
  neacount <- table(populations$ibdnea$Population)
  chimpcount <- table(populations$ibdchimp$Population)
  
  segCounts <- do.call(rbind, Map(data.frame, DEN=dencount, NEA=neacount, CHIMP=chimpcount))
  return(segCounts)
}

DrawTotalPairwise <- function(populations){
	#TO BE MODIFIED
	
	byTotalPairwiseDEN <- aggregate(populations$ibdden[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdden[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdden[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdden[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseNEA <- aggregate(populations$ibdnea[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdnea[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdnea[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdnea[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseCHIMP <- aggregate(populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	
	totpairden <- ggplot(data=byTotalPairwiseDEN, aes(x, color=Group.3)) + geom_freqpoly(binwidth = 100000) + ggtitle("Denisovan") + 
	guides(colour = guide_legend(override.aes = list(size = 5))) +
	theme(legend.key=element_rect(fill=NA)) + scale_color_brewer(palette="Dark2") +
	labs(x="Length", y="Count") + scale_x_continuous(limits = c(0, 5000000))
	totpairnea <- ggplot(data=byTotalPairwiseNEA, aes(x, color=Group.3)) + geom_freqpoly(binwidth = 100000) + ggtitle("Neandertal") + 
	guides(colour = guide_legend(override.aes = list(size = 5))) +
	theme(legend.key=element_rect(fill=NA)) + scale_color_brewer(palette="Dark2") +
	labs(x="Length", y="Count") + scale_x_continuous(limits = c(0, 5000000))
	totpairchimp <- ggplot(data=byTotalPairwiseCHIMP, aes(x, color=Group.3)) + geom_freqpoly(binwidth = 100000) + ggtitle("Chimpanzee") + 
	guides(colour = guide_legend(override.aes = list(size = 5))) +
	theme(legend.key=element_rect(fill=NA)) + scale_color_brewer(palette="Dark2") +
	labs(x="Length", y="Count") + scale_x_continuous(limits = c(0, 5000000))
	
	grid.arrange(totpairden, totpairnea, totpairchimp, ncol = 2)
}

DrawTotalPairwiseDensity <- function(populations){
	#TO BE MODIFIED
	
	byTotalPairwiseDEN <- aggregate(populations$ibdden[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdden[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdden[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdden[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseNEA <- aggregate(populations$ibdnea[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdnea[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdnea[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdnea[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseCHIMP <- aggregate(populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	
	
	# totpairden <- ggplot(data=byTotalPairwiseDEN, aes(x, color = Group.3)) + 
    # geom_density() + 
    # labs(title="Denisovan Total Pairwise") +
    # labs(x="Length", y="Count") +
	# guides(colour = guide_legend(override.aes = list(size = 8))) +
	# theme(legend.key=element_rect(fill=NA)) +
	# scale_fill_discrete(name="Population") + scale_x_continuous(limits = c(0, 5000000))
	
	# totpairnea <- ggplot(data=byTotalPairwiseNEA, aes(x, color = Group.3)) + 
    # geom_density() + 
    # labs(title="Neandertal Total Pairwise") +
    # labs(x="Length", y="Count") +
	# guides(colour = guide_legend(override.aes = list(size = 8))) +
	# theme(legend.key=element_rect(fill=NA)) +
	# scale_fill_discrete(name="Population") + scale_x_continuous(limits = c(0, 5000000))
	
	# totpairchimp <- ggplot(data=byTotalPairwiseCHIMP, aes(x, color = Group.3)) + 
    # geom_density() + 
    # labs(title="Chimpanzee Total Pairwise") +
    # labs(x="Length", y="Count") +
	# guides(colour = guide_legend(override.aes = list(size = 8))) +
	# theme(legend.key=element_rect(fill=NA)) +
	# scale_fill_discrete(name="Population") + scale_x_continuous(limits = c(0, 5000000))
	
	# grid.arrange(totpairden, totpairnea, totpairchimp, ncol = 2)
	
	den <- ggplot(data = byTotalPairwiseDEN, aes(x=Group.3, y=x, color=Group.3)) + geom_violin(trim = FALSE) + ggtitle("Denisovan") + theme(legend.position="none")
	nea <- ggplot(data = byTotalPairwiseNEA, aes(x=Group.3, y=x, color=Group.3)) + geom_violin(trim = FALSE) + ggtitle("Neandertal") + theme(legend.position="none")
	chimp <- ggplot(data = byTotalPairwiseCHIMP, aes(x=Group.3, y=x, color=Group.3)) + geom_violin(trim = FALSE) + ggtitle("Chimpanzee") + theme(legend.position="none")
	
	grid.arrange(den, nea, chimp, ncol = 2)
	
	#chimpmeanlen <- 
	as.list(by(byTotalPairwiseCHIMP$x, byTotalPairwiseCHIMP$Group.3, FUN = mean))
	as.list(by(byTotalPairwiseDEN$x, byTotalPairwiseDEN$Group.3, FUN = mean))
	as.list(by(byTotalPairwiseNEA$x, byTotalPairwiseNEA$Group.3, FUN = mean))
}


ancientDrawDens <- function(populations, pop){
	denplot <- ggplot(data=populations$ibdden, aes(Length, color = Population)) + 
    geom_density() + 
    labs(title="Denisovan IBD Segment Density") +
    labs(x="Length", y="Count") + scale_x_continuous(limits = c(0, 500000))
	
	neaplot <- ggplot(data=populations$ibdnea, aes(Length, color = Population)) + 
    geom_density() + 
    labs(title="Neandertal IBD Segment Density") +
    labs(x="Length", y="Count") + scale_x_continuous(limits = c(0, 500000))
	
	chimpplot <- ggplot(data=populations$ibdchimp, aes(Length, color = Population)) + 
    geom_density() + 
    labs(title="Chimpanzee IBD Segment Density") +
    labs(x="Length", y="Count") + scale_x_continuous(limits = c(0, 500000))
	
	grid.arrange(denplot, neaplot, chimpplot, ncol = 2)
	
}

lengthPeaks <- function(populations){
	
	dendens <- as.list(by(populations$ibdden$Length, populations$ibdden$Population, FUN = density))
	#amrdens <- as.list(by(populations$ibdamr$Length, populations$ibdamr$Population, FUN = density))
	neadens <- as.list(by(populations$ibdnea$Length, populations$ibdnea$Population, FUN = density))
	#sasdens <- as.list(by(populations$ibdsas$Length, populations$ibdsas$Population, FUN = density))
	chimpdens <- as.list(by(populations$ibdchimp$Length, populations$ibdchimp$Population, FUN = density))
	#meanLengths <- do.call(rbind, Map(data.frame, AFR=afrmeanlen, AMR=amrmeanlen, EAS=easmeanlen, EUR=eurmeanlen, SAS=sasmeanlen))
	denlist <- list()
	for (i in dendens) {
		denlist <- c(denlist, i$x[which.max(i$y)])
	}
	names(denlist) <- names(dendens)
	#amrlist <- list()
	#for (i in amrdens) {
	#	amrlist <- c(amrlist, i$x[which.max(i$y)])
	#}
	#names(amrlist) <- names(amrdens)
	nealist <- list()
	for (i in neadens) {
		nealist <- c(nealist, i$x[which.max(i$y)])
	}
	names(nealist) <- names(neadens)
	#saslist <- list()
	#for (i in sasdens) {
	#	saslist <- c(saslist, i$x[which.max(i$y)])
	#}
	#names(saslist) <- names(sasdens)
	chimplist <- list()
	for (i in chimpdens) {
		chimplist <- c(chimplist, i$x[which.max(i$y)])
	}
	names(chimplist) <- names(chimpdens)
	densitiesMax <- do.call(rbind, Map(data.frame, DEN=denlist, NEA=nealist, CHIMP=chimplist))
	#colnames(desitiesMax) <- c("AFR", "AMR", "Chimpanzee", "Denisova", 
	return(list(chimplist = chimplist, nealist = nealist, denlist = denlist))
	#return(eurlist)
}

lengthPeaksTotalPairwise <- function(populations){
	
	byTotalPairwiseEUR <- aggregate(populations$ibdeur[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdeur[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdeur[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdeur[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseAFR <- aggregate(populations$ibdafr[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdafr[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdafr[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdafr[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseAMR <- aggregate(populations$ibdamr[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdamr[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdamr[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdamr[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseEAS <- aggregate(populations$ibdeas[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdeas[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdeas[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdeas[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseSAS <- aggregate(populations$ibdsas[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdsas[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdsas[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdsas[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	byTotalPairwiseCHIMP <- aggregate(populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$Length, 
	by=list(populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$V1, populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$V3, populations$ibdchimp[, c("V1", "V3", "Length", "Population")]$Population), "sum")
	
	eurdens <- by(byTotalPairwiseEUR$x, byTotalPairwiseEUR$Group.3, FUN = density)
	amrdens <- as.list(by(byTotalPairwiseAMR$x, byTotalPairwiseAMR$Group.3, FUN = density))
	afrdens <- as.list(by(byTotalPairwiseAFR$x, byTotalPairwiseAFR$Group.3, FUN = density))
	sasdens <- as.list(by(byTotalPairwiseSAS$x, byTotalPairwiseSAS$Group.3, FUN = density))
	easdens <- as.list(by(byTotalPairwiseEAS$x, byTotalPairwiseEAS$Group.3, FUN = density))
	chimpdens <- as.list(by(byTotalPairwiseCHIMP$x, byTotalPairwiseCHIMP$Group.3, FUN = density))
	#meanLengths <- do.call(rbind, Map(data.frame, AFR=afrmeanlen, AMR=amrmeanlen, EAS=easmeanlen, EUR=eurmeanlen, SAS=sasmeanlen))
	eurlist <- list()
	for (i in eurdens) {
		eurlist <- c(eurlist, i$x[which.max(i$y)])
	}
	names(eurlist) <- names(eurdens)
	
	amrlist <- list()
	for (i in amrdens) {
		amrlist <- c(amrlist, i$x[which.max(i$y)])
	}
	names(amrlist) <- names(amrdens)
	
	afrlist <- list()
	for (i in afrdens) {
		afrlist <- c(afrlist, i$x[which.max(i$y)])
	}
	names(afrlist) <- names(afrdens)
	
	saslist <- list()
	for (i in sasdens) {
		saslist <- c(saslist, i$x[which.max(i$y)])
	}
	names(saslist) <- names(sasdens)
	
	easlist <- list()
	for (i in easdens) {
		easlist <- c(easlist, i$x[which.max(i$y)])
	}
	names(easlist) <- names(easdens)
	
	chimplist <- list()
	for (i in chimpdens) {
		chimplist <- c(chimplist, i$x[which.max(i$y)])
	}
	names(chimplist) <- names(chimpdens)
	densitiesMax <- do.call(rbind, Map(data.frame, AFR=afrlist, AMR=amrlist, EAS=easlist, EUR=eurlist, SAS=saslist, CHIMP=chimplist))
	#colnames(desitiesMax) <- c("AFR", "AMR", "Chimpanzee", "Denisova", 
	return(densitiesMax)
	#return(eurlist)
}

#DrawAncientsRef <- function(populations, ancientGroup = "den", title = "Title"){
DrawAncientsRef <- function(populations, ancientGroup = "den", title = ""){
	if ("RLWK" %in% populations$ibdden$Subpopulation){
		populations$ibdden$Subpopulation <- factor(populations$ibdden$Subpopulation, levels = c("LWK", "MSL", "GWD", "ESN", "YRI", "KHV", "JPT", "CHB", "CDX", "CHS", "TSI", "CEU", "FIN", "GBR", "IBS", "RLWK"), ordered = TRUE)
		populations$ibdnea$Subpopulation <- factor(populations$ibdnea$Subpopulation, levels = c("LWK", "MSL", "GWD", "ESN", "YRI", "KHV", "JPT", "CHB", "CDX", "CHS", "TSI", "CEU", "FIN", "GBR", "IBS", "RLWK"), ordered = TRUE)
		populations$ibdchimp$Subpopulation <- factor(populations$ibdchimp$Subpopulation, levels = c("LWK", "MSL", "GWD", "ESN", "YRI", "KHV", "JPT", "CHB", "CDX", "CHS", "TSI", "CEU", "FIN", "GBR", "IBS", "RLWK"), ordered = TRUE)
	}
	if ("RYRI" %in% populations$ibdden$Subpopulation){
		populations$ibdden$Subpopulation <- factor(populations$ibdden$Subpopulation, levels = c("LWK", "MSL", "GWD", "ESN", "YRI", "KHV", "JPT", "CHB", "CDX", "CHS", "TSI", "CEU", "FIN", "GBR", "IBS", "RYRI"), ordered = TRUE)
		populations$ibdnea$Subpopulation <- factor(populations$ibdnea$Subpopulation, levels = c("LWK", "MSL", "GWD", "ESN", "YRI", "KHV", "JPT", "CHB", "CDX", "CHS", "TSI", "CEU", "FIN", "GBR", "IBS", "RYRI"), ordered = TRUE)
		populations$ibdchimp$Subpopulation <- factor(populations$ibdchimp$Subpopulation, levels = c("LWK", "MSL", "GWD", "ESN", "YRI", "KHV", "JPT", "CHB", "CDX", "CHS", "TSI", "CEU", "FIN", "GBR", "IBS", "RYRI"), ordered = TRUE)
	}
	else {
		populations$ibdden$Subpopulation <- factor(populations$ibdden$Subpopulation, levels = c("LWK", "MSL", "GWD", "ESN", "YRI", "KHV", "JPT", "CHB", "CDX", "CHS", "TSI", "CEU", "FIN", "GBR", "IBS"), ordered = TRUE)
		populations$ibdnea$Subpopulation <- factor(populations$ibdnea$Subpopulation, levels = c("LWK", "MSL", "GWD", "ESN", "YRI", "KHV", "JPT", "CHB", "CDX", "CHS", "TSI", "CEU", "FIN", "GBR", "IBS"), ordered = TRUE)
		populations$ibdchimp$Subpopulation <- factor(populations$ibdchimp$Subpopulation, levels = c("LWK", "MSL", "GWD", "ESN", "YRI", "KHV", "JPT", "CHB", "CDX", "CHS", "TSI", "CEU", "FIN", "GBR", "IBS"), ordered = TRUE)
	}

	if (ancientGroup == "den"){
		byTotalPairwiseDEN <- aggregate(populations$ibdden[, c("V1", "V3", "Length", "Population", "Subpopulation")]$Length, 
		by=list(populations$ibdden[, c("V1", "V3", "Length", "Population", "Subpopulation")]$V1, populations$ibdden[, c("V1", "V3", "Length", "Population", "Subpopulation")]$V3, populations$ibdden[, c("V1", "V3", "Length", "Population", "Subpopulation")]$Population, populations$ibdden[, c("V1", "V3", "Length", "Population", "Subpopulation")]$Subpopulation), "sum")
		 p = ggplot(data = byTotalPairwiseDEN[byTotalPairwiseDEN$Group.4 != "Chimpanzee",], aes(x=Group.4, y=x, fill=Group.3)) + theme_bw() +
		#geom_point(data=byTotalPairwiseDEN[byTotalPairwiseDEN$Group.3 == "Hybrid",], aes(Group.3, x)) + geom_point(data=byTotalPairwiseDEN[byTotalPairwiseDEN$Group.3 == "Neandertal",], aes(Group.3, x)) +
		geom_violin(trim = FALSE) +
		  labs(x="Population", y="Total Shared IBD Length", fill="Population") + scale_fill_brewer(palette="Set2") + theme(legend.title=element_blank())
	}
	else if (ancientGroup == "nea"){
		byTotalPairwiseNEA <- aggregate(populations$ibdnea[, c("V1", "V3", "Length", "Population", "Subpopulation")]$Length, 
		by=list(populations$ibdnea[, c("V1", "V3", "Length", "Population", "Subpopulation")]$V1, populations$ibdnea[, c("V1", "V3", "Length", "Population", "Subpopulation")]$V3, populations$ibdnea[, c("V1", "V3", "Length", "Population", "Subpopulation")]$Population, populations$ibdnea[, c("V1", "V3", "Length", "Population", "Subpopulation")]$Subpopulation), "sum")
		#erm <- subset(byTotalPairwiseNEA, (!is.na(byTotalPairwiseNEA[,1]))) 
		p = ggplot(data = byTotalPairwiseNEA[byTotalPairwiseNEA$Group.4 != "Chimpanzee",], aes(x=Group.4, y=x, fill=Group.3)) + geom_violin(trim = FALSE) + theme(legend.position="none") + theme_bw() +
		  labs(x="Population", y="Total Shared IBD Length", fill="Population") + scale_fill_brewer(palette="Set2") + theme(legend.title=element_blank())
	}
	else if (ancientGroup == "chimp"){
		byTotalPairwiseCHIMP <- aggregate(populations$ibdchimp[, c("V1", "V3", "Length", "Population", "Subpopulation")]$Length, 
		by=list(populations$ibdchimp[, c("V1", "V3", "Length", "Population", "Subpopulation")]$V1, populations$ibdchimp[, c("V1", "V3", "Length", "Population", "Subpopulation")]$V3,  populations$ibdchimp[, c("V1", "V3", "Length", "Population", "Subpopulation")]$Population, populations$ibdchimp[, c("V1", "V3", "Length", "Population", "Subpopulation")]$Subpopulation), "sum")
		p = ggplot(data = byTotalPairwiseCHIMP[byTotalPairwiseCHIMP$Group.4 != "Chimpanzee" & byTotalPairwiseCHIMP$Group.4 != "Neandertal" & byTotalPairwiseCHIMP$Group.1 != "Pan_troglodytes_troglodytes-10964_Cindy",], aes(x=Group.4, y=x, fill=Group.3)) + geom_violin(trim = FALSE) + theme(legend.position="none") + theme_bw() +
		  labs(x="Population", y="Total Shared IBD Length", fill="Population") + scale_fill_brewer(palette="Set2")
	}
	else if (ancientGroup == "hybrid"){
		byTotalPairwiseHYB <- aggregate(populations$ibdhyb[, c("V1", "V3", "Length", "Subpopulation")]$Length, 
		by=list(populations$ibdhyb[, c("V1", "V3", "Length", "Subpopulation")]$V1, populations$ibdhyb[, c("V1", "V3", "Length", "Subpopulation")]$V3, populations$ibdhyb[, c("V1", "V3", "Length", "Subpopulation")]$Subpopulation), "sum")
		p = ggplot(data = byTotalPairwiseHYB[byTotalPairwiseHYB$Group.1 != "Pan_troglodytes_troglodytes-10964_Cindy" & byTotalPairwiseHYB$Group.1 != "HG03052" ,], aes(x=Group.3, y=x, fill=Group.3)) + theme_bw() +
		geom_violin(trim = FALSE) + theme(legend.position="none")  + geom_point(data=byTotalPairwiseHYB[byTotalPairwiseHYB$Group.3 == "Denisovan",], aes(Group.3, x)) +
		geom_point(data=byTotalPairwiseHYB[byTotalPairwiseHYB$Group.3 == "Neandertal",], aes(Group.3, x)) +
		labs(x="Population", y="Total Shared IBD Length")
	}
	if (title == ""){
		p
	}
	else{
		p + ggtitle(title)
	}
}

DrawAncientMeanSegLen <- function(populations, ancientGroup = "den"){
	if (ancientGroup == "den"){
	ggplot(data = populations$ibdden[populations$ibdden$Subpopulation != "Chimpanzee" & populations$ibdden$Subpopulation != "Neandertal",], aes(x=Subpopulation, y=Length, color=Subpopulation)) + 
	geom_violin(trim = FALSE) + ggtitle("Denisovan") + theme(legend.position="none") + labs(x="Population", y="Length")
	}
	else if (ancientGroup == "nea"){
	ggplot(data = populations$ibdnea[populations$ibdnea$Subpopulation != "Chimpanzee" & populations$ibdnea$Subpopulation != "Neandertal",], aes(x=Subpopulation, y=Length, color=Subpopulation)) + 
	geom_violin(trim = FALSE) + ggtitle("Neandertal") + theme(legend.position="none") + labs(x="Population", y="Length")
	}
	else if (ancientGroup == "chimp"){
	ggplot(data = populations$ibdchimp[populations$ibdchimp$Subpopulation != "Chimpanzee" & populations$ibdchimp$Subpopulation != "Neandertal",], aes(x=Subpopulation, y=Length, color=Subpopulation)) + 
	geom_violin(trim = FALSE) + ggtitle("Chimpanzee") + theme(legend.position="none") + labs(x="Population", y="Length")
	}
}

DrawAncientMeanSegLenv2 <- function(populations, ancientGroup = "den", title = ""){
	if (ancientGroup == "den"){
	  ggplot() +
	  theme_bw() +
	  geom_density(data = populations$ibdden[populations$ibdden$Subpopulation == "MSL" | populations$ibdden$Subpopulation == "YRI" | populations$ibdden$Subpopulation == "ESN" | populations$ibdden$Subpopulation == "LWK" | populations$ibdden$Subpopulation == "GWD",], aes(Length, fill=Population), alpha=0.2) +
	  geom_density(data = populations$ibdden[populations$ibdden$Population == "EUR" | populations$ibdden$Population == "EAS",], aes(Length, fill=Population), alpha=0.2) +
	  geom_density(data = populations$ibdden[populations$ibdden$Subpopulation == "RLWK",], aes(Length, fill=Subpopulation), alpha=0.2) +
	  geom_density(data = populations$ibdden[populations$ibdden$Subpopulation == "RYRI",], aes(Length, fill=Subpopulation), alpha=0.2) +
	  scale_fill_brewer(palette="Set2") +
	  ggtitle(title) + labs(x="Segment Length", y="Density") + scale_x_continuous(limits = c(0, 40000)) + theme(legend.title=element_blank())
	}
	else if (ancientGroup == "nea"){
	  ggplot() +
	  theme_bw() +
	  geom_density(data = populations$ibdnea[populations$ibdnea$Subpopulation == "MSL" | populations$ibdnea$Subpopulation == "YRI" | populations$ibdnea$Subpopulation == "ESN" | populations$ibdnea$Subpopulation == "LWK" | populations$ibdnea$Subpopulation == "GWD",], aes(Length, fill=Population), alpha=0.2) +
	  geom_density(data = populations$ibdnea[populations$ibdnea$Population == "EUR" | populations$ibdnea$Population == "EAS",], aes(Length, fill=Population), alpha=0.2) + 
	  geom_density(data = populations$ibdnea[populations$ibdnea$Subpopulation == "RLWK",], aes(Length, fill=Subpopulation), alpha=0.2) +
	  scale_fill_brewer(palette="Set2") +
	  ggtitle(title) + labs(x="Segment Length", y="Density") + scale_x_continuous(limits = c(0, 40000))
	}
  else if (ancientGroup == "chimp"){
    ggplot() + 
    theme_bw() +
    geom_density(data = populations$ibdchimp[populations$ibdchimp$Subpopulation == "MSL" | populations$ibdchimp$Subpopulation == "YRI" | populations$ibdchimp$Subpopulation == "ESN" | populations$ibdchimp$Subpopulation == "LWK" | populations$ibdchimp$Subpopulation == "GWD",], aes(Length, fill=Population), alpha=0.2) +
    geom_density(data = populations$ibdchimp[populations$ibdchimp$Population == "EUR" | populations$ibdchimp$Population == "EAS",], aes(Length, fill=Population), alpha=0.2) +
    geom_density(data = populations$ibdchimp[populations$ibdchimp$Subpopulation == "RLWK",], aes(Length, fill=Subpopulation), alpha=0.2) +
	scale_fill_brewer(palette="Set2") +
    ggtitle(title) + labs(x="Segment Length", y="Density") + scale_x_continuous(limits = c(0, 40000))
  }
}