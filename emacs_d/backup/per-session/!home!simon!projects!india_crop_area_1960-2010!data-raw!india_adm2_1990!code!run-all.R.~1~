library(rgdal)
library(sp)
library(magrittr)
library(tidyr)
library(dplyr)

system("unzip -o data/rawdata/FAO_GAUL_boundary_levels.zip -d data/FAO_GAUL_boundary_levels")

gaul = readOGR(dsn="data/FAO_GAUL_boundary_levels", layer="g2008_2")
gaul_india = gaul[gaul[["ADM0_NAME"]] %in% "India",]
gaul_india@data =
    gaul_india@data %>%
    mutate_each(funs(as.integer),
                G2008_2_,
                G2008_2_ID,
                ADM2_CODE,
                ADM0_CODE,
                ADM1_CODE,
                LAST_UPDAT,
                STR_YEAR0,
                STR_YEAR1,
                STR_YEAR2,
                EXP_YEAR0,
                EXP_YEAR1,
                EXP_YEAR2)

writeOGR(gaul_india,
         dsn="data",
         layer="g2008_2_India_init",
         driver="ESRI Shapefile", overwrite_layer = TRUE)

unlink("data/FAO_GAUL_boundary_levels", recursive=TRUE)

## now copy g2008_2_India_init to g2008_2_India and make edits in
## QGIS by hand (perhaps one day we will migrate to R sf, so that
## all editing can be made in a script)

