library(rgdal)
library(sp)
library(raster)
library(magrittr)
library(tidyr)
library(dplyr)

gaul_india_2001 = readOGR(dsn="data-raw/india_adm2_2001/data", layer="g2008_2_India")

## Level 2 administrative boundaries, 1990
## =======================================

system("unzip -o data-raw/g2015_1990_2.zip -d data")

gaul = readOGR(dsn="data/g2015_1990_2", layer="g2015_1990_2")
gaul_india = gaul[gaul[["ADM0_NAME"]] %in% "India",]
gaul_india@data =
    gaul_india@data %>%
    mutate_each(funs(as.integer),
                ADM2_CODE,
                ADM0_CODE,
                ADM1_CODE,
                STR2_YEAR,
                EXP2_YEAR)

## deal with each state in turn
get_ix = function(sp, adm2_code, adm1_name) {
    (sp$ADM2_CODE %in% adm2_code) & (sp$ADM1_NAME %in% adm1_name)
}

## punjab
ix1 = get_ix(gaul_india, 17826, "Punjab")
ix2 = get_ix(gaul_india_2001, 457, "Punjab")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## HP
ix1 = get_ix(gaul_india, c(17667,17670,17672), "Himachal Pradesh")
ix2 = get_ix(gaul_india_2001, c(188,191,193), "Himachal Pradesh")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Uttarakhand
ix1 = get_ix(gaul_india, c(70289,72597,72606), c("Uttarakhand","Uttar Pradesh"))
ix2 = get_ix(gaul_india_2001, c(636,642,646,70283,70286), c("Uttarakhand","Uttar Pradesh"))
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Arunachal Pradesh
ix1 = get_ix(gaul_india, c(17571,17572,17573,17574,17575,70083,70084,70085), "Arunachal Pradesh")
ix2 = get_ix(gaul_india_2001, c(18,19,20,21,23,26,28,29,30,31,32,33,34), "Arunachal Pradesh")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Assam
ix1 = get_ix(gaul_india, c(17578,17590,17593,70087,70091), "Assam")
ix2 = get_ix(gaul_india_2001, c(40,41,54,59,17590), "Assam")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Gujarat
ix1 = get_ix(gaul_india, c(390,427,17643), "Gujarat")
ix2 = get_ix(gaul_india_2001, c(17637,17643,17645,70129), "Gujarat")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Jammu & Kashmir
ix = get_ix(gaul_india_2001, c(199,200,202,203,205,206,207,210,211,212,213,214,219,220), "Jammu & Kashmir")
gaul_india = bind(gaul_india, gaul_india_2001[ix,])

writeOGR(gaul_india,
         dsn="data",
         layer="g1990_2_India",
         driver="ESRI Shapefile", overwrite_layer = TRUE)

unlink("data/g2015_1990_2", recursive=TRUE)

## Level 2 administrative boundaries, 2010
## =======================================

system("unzip -o data-raw/g2015_2010_2.zip -d data")

gaul = readOGR(dsn="data/g2015_2010_2", layer="g2015_2010_2")
gaul_india = gaul[gaul[["ADM0_NAME"]] %in% "India",]
gaul_india@data =
    gaul_india@data %>%
    mutate_each(funs(as.integer),
                ADM2_CODE,
                ADM0_CODE,
                ADM1_CODE,
                STR2_YEAR,
                EXP2_YEAR)

## deal with each state in turn

## punjab
ix1 = get_ix(gaul_india, 17826, "Punjab")
ix2 = get_ix(gaul_india_2001, 457, "Punjab")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## HP
ix1 = get_ix(gaul_india, c(17667,17670,17672), "Himachal Pradesh")
ix2 = get_ix(gaul_india_2001, c(188,191,193), "Himachal Pradesh")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Uttarakhand
ix1 = get_ix(gaul_india, c(17932,70282,70289), c("Uttarakhand","Uttar Pradesh"))
ix2 = get_ix(gaul_india_2001, c(636,642,646), c("Uttarakhand","Uttar Pradesh"))
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Arunachal Pradesh
ix1 = get_ix(gaul_india, c(17571,17572,17573,17574,17575,70083,70084,70085), "Arunachal Pradesh")
ix2 = get_ix(gaul_india_2001, c(18,19,20,21,23,26,28,29,30,31,32,33,34), "Arunachal Pradesh")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Assam
ix1 = get_ix(gaul_india, c(17578,17590,17593,70087,70091), "Assam")
ix2 = get_ix(gaul_india_2001, c(40,41,54,59,17590), "Assam")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Gujarat
ix1 = get_ix(gaul_india, c(17643), "Gujarat")
ix2 = get_ix(gaul_india_2001, c(17643), "Gujarat")
gaul_india = bind(gaul_india[!ix1,], gaul_india_2001[ix2,])

## Jammu & Kashmir
ix = get_ix(gaul_india_2001, c(199,200,202,203,205,206,207,210,211,212,213,214,219,220), "Jammu & Kashmir")
gaul_india = bind(gaul_india, gaul_india_2001[ix,])

writeOGR(gaul_india,
         dsn="data",
         layer="g2010_2_India",
         driver="ESRI Shapefile", overwrite_layer = TRUE)

unlink("data/g2015_2010_2", recursive=TRUE)
