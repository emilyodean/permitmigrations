#matricize
library(dplyr)

setwd("/Users/datateam/Downloads/permit_migration_subsets/MV")

index <- read.csv("Matrices/index.csv", stringsAsFactors = FALSE)

permits85 <- read.csv("Matrices/inter75_85.csv", stringsAsFactors = FALSE)
diagonal85 <- read.csv("Matrices/intra85.csv", stringsAsFactors = FALSE)

permits95 <- read.csv("Matrices/inter85_95.csv", stringsAsFactors = FALSE)
diagonal95 <- read.csv("Matrices/intra95.csv", stringsAsFactors = FALSE)

permits05 <- read.csv("Matrices/inter95_05.csv", stringsAsFactors = FALSE)
diagonal05 <- read.csv("Matrices/intra05.csv", stringsAsFactors = FALSE)

permits16 <- read.csv("Matrices/inter05_16.csv", stringsAsFactors = FALSE)
diagonal16 <- read.csv("Matrices/intra16.csv", stringsAsFactors = FALSE)

permits_join <- function(index, permits, diagonal) {
  data <- left_join(permits, index, by = c("Orig" = "ID"))
  data <- left_join(data, index, by = c("Dest" = "ID"))
  
  colnames(diagonal) <- c("ID", "changed")
  diagonal <- left_join(diagonal, index, by = c("ID" = "ID"))
  
  sub <- data.frame(Origin = data$Mig_status.x, Destination = data$Mig_status.y, stringsAsFactors = FALSE)
  sub <- sub[complete.cases(sub),]
  
  levs <- unique(unlist(sub, use.names = FALSE))
  m <- table(lapply(sub, factor, levs))
  
  region_order <- c("Other countries", "Other US states", "Oregon", "Washington", "Southeast", "Copper River", "Prince William Sound", "Cook Inlet", "Kodiak", "Chignik", "Alaska Peninsula and Aleutian Islands", "Bristol Bay", "Kuskokwim", "Yukon", "Norton Sound", "Kotzebue", "Arctic", "CFEC")
  
  region_order <- subset(region_order, region_order %in% levs)
  
  m <- m[region_order, region_order]
  
  regions_ordered <- left_join(data.frame(Mig_status = region_order, stringsAsFactors = FALSE), diagonal, by=c("Mig_status" = "Mig_status"))
  regions_ordered[is.na(regions_ordered)] <- 0
  diag(m) <- regions_ordered$changed
  
  m <- set_quantile(m, 0.5)
  
  m
}

set_quantile <- function(m, q) 
{
  min_count <- quantile(m[m!=0], probs = q)
  m[m<=min_count] <- 0
  m
}

df_1985 <- permits_join(index, permits85, diagonal85)
df_1995 <- permits_join(index, permits95, diagonal95)
df_2005 <- permits_join(index, permits05, diagonal05)
df_2015 <- permits_join(index, permits16, diagonal16)

#Need to remove rownames for reading back in later
rownames(df_1985) <- NULL; rownames(df_1995) <- NULL; rownames(df_2005) <- NULL; rownames(df_2015) <- NULL;

write.csv(df_1985, "Matrices/matrix_1985.csv", row.names = FALSE)
write.csv(df_1995, "Matrices/matrix_1995.csv", row.names = FALSE)
write.csv(df_2005, "Matrices/matrix_2005.csv", row.names = FALSE)
write.csv(df_2015, "Matrices/matrix_2015.csv", row.names = FALSE)

