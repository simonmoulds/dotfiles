## Author : Simon Moulds & Jimmy O'Keeffe
## Date   : 10 January 2018

## NB use set.seed() during calibration

## ======================================
## Hamipur
## ======================================

hamirpur_config_fs = c("hamirpur_baseline_config.R",
                       "hamirpur_baseline_policy_config.R",
                       "hamirpur_rcp45_config.R",
                       "hamirpur_rcp45_policy_config.R",
                       "hamirpur_rcp85_config.R",
                       "hamirpur_rcp85_policy_config.R")

for (i in 1:length(hamirpur_config_fs)) {
    set.seed(9537)
    source(file.path("code", "config", hamirpur_config_fs[i]))
    print(paste0("Running scenario ", run_id))
    source(file.path("code", "model.R"))
}

## ======================================
## Jalaun
## ======================================

jalaun_config_fs = c("jalaun_baseline_config.R",
                     "jalaun_baseline_policy_config.R",
                     "jalaun_rcp45_config.R",
                     "jalaun_rcp45_policy_config.R",
                     "jalaun_rcp85_config.R",
                     "jalaun_rcp85_policy_config.R")

for (i in 1:length(jalaun_config_fs)) {
    set.seed(30364)
    source(file.path("code", "config", jalaun_config_fs[i]))
    print(paste0("Running scenario ", run_id))
    source(file.path("code", "model.R"))
}

## ======================================
## Sitapur
## ======================================

sitapur_config_fs = c("sitapur_baseline_config.R",
                      "sitapur_baseline_policy_config.R",
                      "sitapur_rcp45_config.R",
                      "sitapur_rcp45_policy_config.R",
                      "sitapur_rcp85_config.R",
                      "sitapur_rcp85_policy_config.R")

for (i in 1:length(sitapur_config_fs)) {
    set.seed(808)
    source(file.path("code", "config", sitapur_config_fs[i]))
    print(paste0("Running scenario ", run_id))
    source(file.path("code", "model.R"))
}

## ======================================
## Sultanpur
## ======================================

sultanpur_config_fs = c("sultanpur_baseline_config.R",
                        "sultanpur_baseline_policy_config.R",
                        "sultanpur_rcp45_config.R",
                        "sultanpur_rcp45_policy_config.R",
                        "sultanpur_rcp85_config.R",
                        "sultanpur_rcp85_policy_config.R")

for (i in 1:length(sultanpur_config_fs)) {
    set.seed(31257)
    source(file.path("code", "config", sultanpur_config_fs[i]))
    print(paste0("Running scenario ", run_id))
    source(file.path("code", "model.R"))
}

## make plots
## ##########

source("code/plots.R")
