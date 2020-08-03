## Author : Simon Moulds & Jimmy O'Keeffe
## Date   : January 2018

library(ggplot2)
library(scales)
library(zoo)
library(xts)
library(dplyr)
library(tidyr)
library(magrittr)

ddir_input = file.path("data","input")
ddir_output = file.path("data","output","txt")

date  = seq(as.Date("1971-01-01"), as.Date("2013-12-31"), by="1 day")
date2 = seq(as.Date("1971-01-01"), as.Date("2005-12-31"), by="1 day")

date_year  = seq(as.Date("1971-01-01"), as.Date("2013-12-31"), by="1 year")
date2_year = seq(as.Date("1971-01-01"), as.Date("2005-12-31"), by="1 year")

dist_long = c("Hamirpur","Jalaun","Sitapur","Sultanpur")
dist_short = c("ham","jal","sit","sult")
elev = c(129, 139, 136, 103)
scenario = c("base","pol")

## income plots
## ############

data = list()
for (i in 1:length(dist_long)) {

    for (j in 1:length(scenario)) {

        income_min = read.table(file.path(ddir_output, paste0("income_min_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE)[1:35,]
        income_max = read.table(file.path(ddir_output, paste0("income_max_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE)[1:35,]
        income_med = read.table(file.path(ddir_output, paste0("income_med_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE)[1:35,]

        income_base = data.frame(date=date2_year, dist=dist_short[i], name=paste0("Historical_", scenario[j]), med=income_med, min=income_min, max=income_max)

        income_min_45 = read.table(file.path(ddir_output, paste0("income_min_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE)[1:35,]
        income_max_45 = read.table(file.path(ddir_output, paste0("income_max_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE)[1:35,]
        income_med_45 = read.table(file.path(ddir_output, paste0("income_med_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE)[1:35,]

        income_45 = data.frame(date=date2_year, dist=dist_short[i], name=paste0("RCP4.5_", scenario[j]), med=income_med_45, min=income_min_45, max=income_max_45)

        income_min_85 = read.table(file.path(ddir_output, paste0("income_min_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE)[1:35,]
        income_max_85 = read.table(file.path(ddir_output, paste0("income_max_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE)[1:35,]
        income_med_85 = read.table(file.path(ddir_output, paste0("income_med_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE)[1:35,]

        income_85 = data.frame(date=date2_year, dist=dist_short[i], name=paste0("RCP8.5_", scenario[j]), med=income_med_85, min=income_min_85, max=income_max_85)

        income = rbind(income_base, income_45, income_85) %>% arrange(date, dist, name)
        n = length(data)
        data[[n+1]] = income
    }
}

## now join plots
df = do.call(rbind, data) %>% arrange(date, dist, name)

## df = df[grep("RCP(4|8).5_base", as.character(df$name), invert=TRUE),]
## df$dist = factor(as.character(df$dist), levels=c("sit","sult","jal","ham"))
## levels(df$dist) = c("Sitapur","Sultanpur","Jalaun","Hamirpur")
## df$name = factor(as.character(df$name), levels=c("Historical_base","Historical_pol","RCP4.5_pol","RCP8.5_pol"), labels=c("Baseline","Policy","Policy (RCP4.5)","Policy (RCP8.5)"))

df$dist = factor(as.character(df$dist), levels=c("sit","sult","jal","ham"))
levels(df$dist) = c("Sitapur","Sultanpur","Jalaun","Hamirpur")
df$name = factor(as.character(df$name), levels=c("Historical_base","Historical_pol","RCP4.5_base","RCP8.5_base","RCP4.5_pol","RCP8.5_pol"), labels=c("Baseline","Policy","Baseline (RCP4.5)","Baseline (RCP8.5)","Policy (RCP4.5)","Policy (RCP8.5)"))

p = ggplot(df, aes(x=date, y=med)) +
    geom_line(aes(colour=name)) +
    geom_ribbon(aes(ymax=min, ymin=max, fill=name), alpha = 0.4) +
    ## scale_colour_manual(name="", values=c("green","blue","orange","red")) +
    ## scale_fill_manual(name="", values=c("green","blue","orange","red")) +
    scale_colour_manual(name="", values=c("#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
    scale_fill_manual(name="", values=c("#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
    theme_bw() +
    facet_wrap(~dist, ncol=2) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size=12),
          plot.title = element_text(size=12),
          aspect.ratio=1,
          plot.margin = unit(c(0.25,0.25,0.25,0.25), "cm"),
          legend.direction="vertical") +
          ## legend.position="bottom") +
    labs(x="Year", y="INR")
    ## labs(title="Farmer income (INR)", x="Year", y="INR")

p = p + theme(legend.justification=c(0,1), legend.position = c(0, 1.03), legend.background = element_rect(fill="transparent"), legend.text = element_text(size=8), legend.key.size = unit(0.6, "cm"))
p

pname = file.path("data","plots","farmer_income.pdf")
ggsave(pname, plot=p, device="pdf", width=6, height=7, units="in")

## yield-wheat plots
## #################

obs_data = list()
data = list()

for (i in 1:length(dist_long)) {

    obs_yield = read.table(file.path(ddir_input, paste0("av_crop_yield_", tolower(dist_long[i]), ".txt")), header=TRUE)
    colnames(obs_yield) = c("date","rice_th","wheat_th")
    obs_yield[["date"]] = date_year
    obs_yield %<>% dplyr::right_join(data.frame(date=date2_year)) %>% dplyr::select(-rice_th)
    obs_yield2 = data.frame(date=date2_year, dist=dist_short[i], name="Observed", med=obs_yield[["wheat_th"]], min=obs_yield[["wheat_th"]], max=obs_yield[["wheat_th"]])
    obs_data[[i]] = obs_yield2
    
    for (j in 1:length(scenario)) {

        yieldW_min = read.table(file.path(ddir_output, paste0("yieldW_min_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE)[1:35,]
        yieldW_max = read.table(file.path(ddir_output, paste0("yieldW_max_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE)[1:35,]
        yieldW_med = read.table(file.path(ddir_output, paste0("yieldW_med_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE)[1:35,]

        yieldW_base = data.frame(date=date2_year, dist=dist_short[i], name=paste0("Historical_", scenario[j]), med=yieldW_med, min=yieldW_min, max=yieldW_max)

        yieldW_min_45 = read.table(file.path(ddir_output, paste0("yieldW_min_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE)[1:35,]
        yieldW_max_45 = read.table(file.path(ddir_output, paste0("yieldW_max_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE)[1:35,]
        yieldW_med_45 = read.table(file.path(ddir_output, paste0("yieldW_med_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE)[1:35,]

        yieldW_45 = data.frame(date=date2_year, dist=dist_short[i], name=paste0("RCP4.5_", scenario[j]), med=yieldW_med_45, min=yieldW_min_45, max=yieldW_max_45)

        yieldW_min_85 = read.table(file.path(ddir_output, paste0("yieldW_min_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE)[1:35,]
        yieldW_max_85 = read.table(file.path(ddir_output, paste0("yieldW_max_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE)[1:35,]
        yieldW_med_85 = read.table(file.path(ddir_output, paste0("yieldW_med_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE)[1:35,]

        yieldW_85 = data.frame(date=date2_year, dist=dist_short[i], name=paste0("RCP8.5_", scenario[j]), med=yieldW_med_85, min=yieldW_min_85, max=yieldW_max_85)

        yieldW = rbind(yieldW_base, yieldW_45, yieldW_85) %>% arrange(date, dist, name)

        n = length(data)
        data[[n+1]] = yieldW
    }
}

## now join plots
## df_mod = do.call(rbind, data) %>% arrange(date, dist, name)
## df_mod = df_mod[grep("RCP(4|8).5_base", as.character(df_mod$name), invert=TRUE),]

## df_obs = do.call(rbind, obs_data) %>% arrange(date, dist, name)

## df = rbind(df_mod, df_obs) %>% arrange(date, dist, name)

## df$dist = factor(as.character(df$dist), levels=c("sit","sult","jal","ham"))
## levels(df$dist) = c("Sitapur","Sultanpur","Jalaun","Hamirpur")

## df$name = factor(as.character(df$name), levels=c("Observed","Historical_base","Historical_pol","RCP4.5_pol","RCP8.5_pol"), labels=c("Observed","Baseline","Policy","Policy (RCP4.5)","Policy (RCP8.5)"))

df_mod = do.call(rbind, data) %>% arrange(date, dist, name)
df_obs = do.call(rbind, obs_data) %>% arrange(date, dist, name)
df = rbind(df_mod, df_obs) %>% arrange(date, dist, name)
df$dist = factor(as.character(df$dist), levels=c("sit","sult","jal","ham"))
levels(df$dist) = c("Sitapur","Sultanpur","Jalaun","Hamirpur")
df$name = factor(as.character(df$name), levels=c("Observed","Historical_base","Historical_pol","RCP4.5_base","RCP8.5_base","RCP4.5_pol","RCP8.5_pol"), labels=c("Observed","Baseline","Policy","Baseline (RCP4.5)","Baseline (RCP8.5)","Policy (RCP4.5)","Policy (RCP8.5)"))

p = ggplot(df, aes(x=date, y=med)) +
    geom_line(aes(colour=name)) +
    geom_ribbon(aes(ymax=min, ymin=max, fill=name), alpha = 0.2) +
    ## scale_colour_manual(name="", values=c("black","green","blue","orange","red")) +
    ## scale_fill_manual(name="", values=c("transparent","green","blue","orange","red")) +
    scale_colour_manual(name="", values=c("black","#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
    scale_fill_manual(name="", values=c("transparent","#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
    theme_bw() +
    scale_y_continuous(limits = c(0.25,3.75)) +
    facet_wrap(~dist, ncol=2) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size=12),
          plot.title = element_text(size=12),
          aspect.ratio=1,
          plot.margin = unit(c(0.25,0.25,0.25,0.25), "cm"),
          legend.direction="vertical") +
          ## legend.position="bottom") +
    labs(x="Year", y="Wheat yield (t/ha)")

p = p + theme(legend.justification=c(0,1), legend.position = c(0, 1.03), legend.background = element_rect(fill="transparent"), legend.text = element_text(size=8), legend.key.size = unit(0.6, "cm"))

pname = file.path("data","plots","wheat_yield.pdf")
ggsave(pname, plot=p, device="pdf", width=6, height=7, units="in")

## yield-rice plots
## ################

obs_data = list()
data = list()

for (i in 1:length(dist_long)) {

    if (dist_long[i] %in% c("Sitapur","Sultanpur")) {
        
        obs_yield = read.table(file.path(ddir_input, paste0("av_crop_yield_", tolower(dist_long[i]), ".txt")), header=TRUE)
        colnames(obs_yield) = c("date","rice_th","wheat_th")
        obs_yield[["date"]] = date_year
        obs_yield %<>% dplyr::right_join(data.frame(date=date2_year)) %>% dplyr::select(-wheat_th)
        obs_yield2 = data.frame(date=date2_year, dist=dist_short[i], name="Observed", med=obs_yield[["rice_th"]], min=obs_yield[["rice_th"]], max=obs_yield[["rice_th"]])
        nn = length(obs_data)
        obs_data[[nn+1]] = obs_yield2
        
        for (j in 1:length(scenario)) {

            yieldR_min = read.table(file.path(ddir_output, paste0("yieldR_min_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE)[1:35,]
            yieldR_max = read.table(file.path(ddir_output, paste0("yieldR_max_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE)[1:35,]
            yieldR_med = read.table(file.path(ddir_output, paste0("yieldR_med_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE)[1:35,]

            yieldR_base = data.frame(date=date2_year, dist=dist_short[i], name=paste0("Historical_", scenario[j]), med=yieldR_med, min=yieldR_min, max=yieldR_max)

            yieldR_min_45 = read.table(file.path(ddir_output, paste0("yieldR_min_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE)[1:35,]
            yieldR_max_45 = read.table(file.path(ddir_output, paste0("yieldR_max_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE)[1:35,]
            yieldR_med_45 = read.table(file.path(ddir_output, paste0("yieldR_med_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE)[1:35,]

            yieldR_45 = data.frame(date=date2_year, dist=dist_short[i], name=paste0("RCP4.5_", scenario[j]), med=yieldR_med_45, min=yieldR_min_45, max=yieldR_max_45)

            yieldR_min_85 = read.table(file.path(ddir_output, paste0("yieldR_min_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE)[1:35,]
            yieldR_max_85 = read.table(file.path(ddir_output, paste0("yieldR_max_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE)[1:35,]
            yieldR_med_85 = read.table(file.path(ddir_output, paste0("yieldR_med_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE)[1:35,]

            yieldR_85 = data.frame(date=date2_year, dist=dist_short[i], name=paste0("RCP8.5_", scenario[j]), med=yieldR_med_85, min=yieldR_min_85, max=yieldR_max_85)

            yieldR = rbind(yieldR_base, yieldR_45, yieldR_85) %>% arrange(date, dist, name)

            n = length(data)
            data[[n+1]] = yieldR
        }
    }
}

## df_mod = do.call(rbind, data) %>% arrange(date, dist, name)
## df_mod = df_mod[grep("RCP(4|8).5_base", as.character(df_mod$name), invert=TRUE),]
## df_obs = do.call(rbind, obs_data) %>% arrange(date, dist, name)
## df = rbind(df_mod, df_obs) %>% arrange(date, dist, name)
## df$dist = factor(as.character(df$dist), levels=c("sit","sult"), labels=c("Sitapur","Sultanpur"))
## df$name = factor(as.character(df$name), levels=c("Observed","Historical_base","Historical_pol","RCP4.5_pol","RCP8.5_pol"), labels=c("Observed","Baseline","Policy","Policy (RCP4.5)","Policy (RCP8.5)"))

df_mod = do.call(rbind, data) %>% arrange(date, dist, name)
df_obs = do.call(rbind, obs_data) %>% arrange(date, dist, name)
df = rbind(df_mod, df_obs) %>% arrange(date, dist, name)
df$dist = factor(as.character(df$dist), levels=c("sit","sult","jal","ham"))
levels(df$dist) = c("Sitapur","Sultanpur","Jalaun","Hamirpur")
df$name = factor(as.character(df$name), levels=c("Observed","Historical_base","Historical_pol","RCP4.5_base","RCP8.5_base","RCP4.5_pol","RCP8.5_pol"), labels=c("Observed","Baseline","Policy","Baseline (RCP4.5)","Baseline (RCP8.5)","Policy (RCP4.5)","Policy (RCP8.5)"))

p = ggplot(df, aes(x=date, y=med)) +
    geom_line(aes(colour=name)) +
    geom_ribbon(aes(ymax=min, ymin=max, fill=name), alpha = 0.2) +
    ## scale_colour_manual(name="", values=c("black","green","blue","orange","red")) +
    ## scale_fill_manual(name="", values=c("transparent","green","blue","orange","red")) +
    scale_colour_manual(name="", values=c("black","#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
    scale_fill_manual(name="", values=c("transparent","#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
    theme_bw() +
    facet_wrap(~dist, ncol=2) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size=12),
          plot.title = element_text(size=12),
          aspect.ratio=1,
          plot.margin = unit(c(0.25,0.25,0.25,0.25), "cm"),
          legend.position="none") +
          ## legend.direction="vertical",
          ## legend.position="bottom") +
    labs(x="Year", y="Rice yield (t/ha)")

pname = file.path("data","plots","rice_yield.pdf")
ggsave(pname, plot=p, device="pdf", width=6, height=4, units="in")

## observed vs modelled groundwater
## ################################

data = list()

for (i in 1:length(dist_long)) {

    gw_med = read.table(file.path(ddir_output, paste0("gw_med_", dist_short[i], "_base.txt")))[,1]
    gw_min = read.table(file.path(ddir_output, paste0("gw_min_", dist_short[i], "_base.txt")))[,1]
    gw_max = read.table(file.path(ddir_output, paste0("gw_max_", dist_short[i], "_base.txt")))[,1]

    gw_mod = data.frame(date=date, dist=dist_short[i], name="Modelled", med=gw_med, min=gw_min, max=gw_max)

    gw_obs =
        read.table(file.path(ddir_input, paste0(dist_short[i], "_obs_gw.txt")), header=TRUE) %>%
        dplyr::select(c("date","wl")) %>%
        `[`(complete.cases(.),)
    gw_obs[["date"]] = as.Date(gw_obs[["date"]])
    gw_obs %<>% dplyr::right_join(data.frame(date=date)) 
    gw_obs[,c("wl")] = zoo::na.approx(gw_obs[,c("wl")], na.rm=FALSE)

    gw_obs2 = data.frame(date=date, dist=dist_short[i], name="Observed", med=gw_obs[["wl"]], min=gw_obs[["wl"]], max=gw_obs[["wl"]])

    df = rbind(gw_mod, gw_obs2) %>% arrange(date, dist, name)
    df$med = df$med - elev[i]
    df$min = df$min - elev[i]
    df$max = df$max - elev[i]
    
    data[[i]] = df
}

## now join plots
df = do.call(rbind, data) %>% arrange(date, dist, name)

df$dist = factor(as.character(df$dist), levels=c("sit","sult","jal","ham"), labels=c("Sitapur","Sultanpur","Jalaun","Hamirpur"))

df$name = factor(as.character(df$name), levels=c("Observed","Modelled"))

p = ggplot(df, aes(x=date, y=med)) +
    geom_line(aes(colour=name)) +
    geom_ribbon(aes(ymax=min, ymin=max, fill=name), alpha=0.3) +
    scale_colour_manual(name="", values=c("black","red")) +
    scale_fill_manual(name="", values=c("transparent","red")) +
    theme_bw() +
    facet_wrap(~dist, ncol=2) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size=12),
          plot.title = element_text(size=12),
          aspect.ratio=1,
          plot.margin = unit(c(0.25,0.25,0.25,0.25), "cm"),
          legend.direction="vertical") +
          ## legend.position="bottom")+
    labs(x="Year", y="mBGL")

p = p + theme(legend.justification=c(0,0), legend.position = c(0, 0.53), legend.background = element_rect(fill="transparent"), legend.text = element_text(size=8), legend.key.size = unit(0.6, "cm"))
## p = p + theme(legend.position = c(0.0825, 0.5975), legend.background = element_rect(fill="transparent"), legend.text = element_text(size=8), legend.key.size = unit(0.6, "cm"))

pname = file.path("data","plots","obs_vs_mod_gw_level.pdf")
ggsave(pname, plot=p, device="pdf", width=6, height=7, units="in")

## groundwater - scenarios
## #######################

data = list()
for (i in 1:length(dist_long)) {

    for (j in 1:length(scenario)) {

        gw_med  <- read.table(file.path(ddir_output, paste0("gw_med_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE) %>% zoo(order.by=date2) %>% apply.yearly("mean",na.rm=TRUE)
        gw_min  <- read.table(file.path(ddir_output, paste0("gw_min_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE) %>% zoo(order.by=date2) %>% apply.yearly("mean",na.rm=TRUE)
        gw_max  <- read.table(file.path(ddir_output, paste0("gw_max_", dist_short[i], "_", scenario[j], ".txt")), header=TRUE) %>% zoo(order.by=date2) %>% apply.yearly("mean",na.rm=TRUE)

        gw_base = data.frame(date=date2_year, dist=dist_short[i], name=paste0("Historical_", scenario[j]), med=gw_med, min=gw_min, max=gw_max) %>% `row.names<-`(NULL)

        gw_med_45 <- read.table(file.path(ddir_output, paste0("gw_med_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE) %>% zoo(order.by=date2) %>% apply.yearly("mean",na.rm=TRUE)
        gw_min_45 <- read.table(file.path(ddir_output, paste0("gw_min_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE) %>% zoo(order.by=date2) %>% apply.yearly("mean",na.rm=TRUE)
        gw_max_45 <- read.table(file.path(ddir_output, paste0("gw_max_", dist_short[i], "_rcp45_", scenario[j], ".txt")), header=TRUE) %>% zoo(order.by=date2) %>% apply.yearly("mean",na.rm=TRUE)

        gw_45 = data.frame(date=date2_year, dist=dist_short[i], name=paste0("RCP4.5_", scenario[j]), med=gw_med_45, min=gw_min_45, max=gw_max_45)

        gw_med_85 <- read.table(file.path(ddir_output, paste0("gw_med_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE) %>% zoo(order.by=date2) %>% apply.yearly("mean",na.rm=TRUE)
        gw_min_85 <- read.table(file.path(ddir_output, paste0("gw_min_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE) %>% zoo(order.by=date2) %>% apply.yearly("mean",na.rm=TRUE)
        gw_max_85 <- read.table(file.path(ddir_output, paste0("gw_max_", dist_short[i], "_rcp85_", scenario[j], ".txt")), header=TRUE) %>% zoo(order.by=date2) %>% apply.yearly("mean",na.rm=TRUE)

        gw_85 = data.frame(date=date2_year, dist=dist_short[i], name=paste0("RCP8.5_", scenario[j]), med=gw_med_85, min=gw_min_85, max=gw_max_85)

        gw = rbind(gw_base, gw_45, gw_85) %>% arrange(date, dist, name)
        gw$med = gw$med - elev[i]
        gw$min = gw$min - elev[i]
        gw$max = gw$max - elev[i]

        n = length(data)
        data[[n+1]] = gw

    }
}

## now join plots
## df = do.call(rbind, data) %>% arrange(date, dist, name)
## df = df[grep("RCP(4|8).5_base", as.character(df$name), invert=TRUE),]

## df$dist = factor(as.character(df$dist), levels=c("sit","sult","jal","ham"), labels=c("Sitapur","Sultanpur","Jalaun","Hamirpur"))

## df$name = factor(as.character(df$name), levels=c("Historical_base","Historical_pol","RCP4.5_pol","RCP8.5_pol"), labels=c("Baseline","Policy","Policy (RCP4.5)","Policy (RCP8.5)"))

df = do.call(rbind, data) %>% arrange(date, dist, name)
df$dist = factor(as.character(df$dist), levels=c("sit","sult","jal","ham"))
levels(df$dist) = c("Sitapur","Sultanpur","Jalaun","Hamirpur")
df$name = factor(as.character(df$name), levels=c("Historical_base","Historical_pol","RCP4.5_base","RCP8.5_base","RCP4.5_pol","RCP8.5_pol"), labels=c("Baseline","Policy","Baseline (RCP4.5)","Baseline (RCP8.5)","Policy (RCP4.5)","Policy (RCP8.5)"))

p = ggplot(df, aes(x=date, y=med)) +
    geom_line(aes(colour=name)) +
    geom_ribbon(aes(ymax=min, ymin=max, fill=name), alpha = 0.2) +
    ## scale_colour_manual(name="", values=c("green","blue","orange","red")) +
    ## scale_fill_manual(name="", values=c("green","blue","orange","red")) +
    scale_colour_manual(name="", values=c("#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
    scale_fill_manual(name="", values=c("#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
    theme_bw() +
    facet_wrap(~dist, ncol=2) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size=12),
          plot.title = element_text(size=12),
          aspect.ratio=1,
          plot.margin = unit(c(0.25,0.25,0.25,0.25), "cm"),
          legend.direction="vertical") +
          ## legend.position="bottom")+
    labs(x="Year", y="mBGL")

## p = p + theme(legend.position = c(0.125, 0.65), legend.background = element_rect(fill="transparent"))
p = p + theme(legend.justification=c(0,0), legend.position = c(0, 0.53), legend.background = element_rect(fill="transparent"), legend.text = element_text(size=8), legend.key.size = unit(0.6, "cm"))

pname = file.path("data","plots","mod_gw_level.pdf")
ggsave(pname, plot=p, device="pdf", width=6, height=7, units="in")
