```{r housing}
load.libraries <- c('data.table', 'testthat', 'gridExtra', 'corrplot', 'GGally', 'ggplot2', 'e1071', 'dplyr')
install.lib <- load.libraries[!load.libraries %in% installed.packages()]

for(libs in install.lib) install.packages(libs, dependences = TRUE)
sapply(load.libraries, require, character = TRUE)





```


```{r, echo = FALSE}

train <- fread('train.csv',colClasses=c('MiscFeature' = "character", 'PoolQC' = 'character', 'Alley' = 'character'))
test <- fread('test.csv' ,colClasses=c('MiscFeature' = "character", 'PoolQC' = 'character', 'Alley' = 'character'))
```
names(train)

```{r}
cat_var <- names(train)[which(sapply(train, is.character))]

cat_car <- c(cat_var, 'BedroomAbvGr', 'HalfBath', ' KitchenAbvGr','BsmtFullBath', 'BsmtHalfBath', 'MSSubClass')

numeric_var <- names(train)[which(sapply(train, is.numeric))]
```

## Structure of the data
The housing data set has 1460 rows and 81 features with the target feature Sale Price.

```{r structure}
dim(train)
str(train)

```


# Summarize the missing values in the data.

Viewing the first five rows of the data indicates that there are columns which have missing values. The categorical variables with the largest number of missing values are: Alley,  FirePlaceQu, PoolQC, Fence, and MiscFeature.

* Alley: indicates the type of alley access
* FirePlaceQu: FirePlace Quality
* PoolQC: Pool Quality
* Fence: Fence Quality
* MiscFeature: Miscellaneous features not covered in other categories

The missing values indicate that majority of the houses do not have alley access, no pool, no fence and no elevator, 2nd garage, shed or tennis court that is covered by the MiscFeature.

The numeric variables do not have as many missing values but there are still some present. There are 259 values for the LotFrontage, 8 missing values for MasVnrArea and 81 missing values for GarageYrBlt.

* LotFrontage: Linear feet of street connected to property
* GarageYrBlt: Year garage was built
* MasVnrArea: Masonry veener area in square feet

Definition of Masonry Veener from google:
  Veneer masonry is a popular choice for home building and remodeling, because it gives the appearance of a solid brick or stone wall while providing better economy and insulation. It can be used as an addition to conventional wood frame structures, and can be placed on concrete block walls. 

Brick veeners are not essential to the stucture of the house but are used to chance the appearance of the wall while providing better insulation. They tend to only have one brick layer.


```{r missing data}
head(train)
colSums(sapply(train, is.na))
colSums(sapply(train[,.SD, .SDcols = cat_var], is.na))
colSums(sapply(train[,.SD, .SDcols = numeric_var], is.na))

```

.SDcols

Visualization for the missing data.

```{r missing data_2}

plot_Missing <- function(data_in, title = NULL){
  temp_df <- as.data.frame(ifelse(is.na(data_in), 0, 1))
  temp_df <- temp_df[,order(colSums(temp_df))]
  data_temp <- expand.grid(list(x = 1:nrow(temp_df), y = colnames(temp_df)))
  data_temp$m <- as.vector(as.matrix(temp_df))
  data_temp <- data.frame(x = unlist(data_temp$x), y = unlist(data_temp$y), m = unlist(data_temp$m))
  ggplot(data_temp) + geom_tile(aes(x=x, y=y, fill=factor(m))) + scale_fill_manual(values=c("white", "black"), name="Missing\n(0=Yes, 1=No)") + theme_light() + ylab("") + xlab("") + ggtitle(title)
}


plot_Missing(train[,colSums(is.na(train)) > 0, with = FALSE])
```

Let's gain some insight on the number of houses that were remodeled. According to the data dictionary, if the YearBuilt date is different from the YearRemodAdd date then the house was remodeled. Comparing these two rows indicates that 696 houses were remodeled and 764 houses were not remodeled.



```{r}
sum(train[,'YearRemodAdd', with = FALSE] != train[,'YearBuilt', with = FALSE])

cat('Percentage of houses remodeled',sum(train[,'YearRemodAdd', with = FALSE] != train[,'YearBuilt', with = FALSE])/ dim(train)[1])


train %>% select(YearBuilt, YearRemodAdd) %>%    mutate(Remodeled = as.integer(YearBuilt != YearRemodAdd)) %>% ggplot(aes(x= factor(x = Remodeled, labels = c( 'No','Yes')))) + geom_bar() + xlab('Remodeled') + theme_light()




```

## Summarize the numeric values and the structure of the data.

```{r traistructures}

summary(train[,.SD, .SDcols =numeric_var])

cat('Train has', dim(train)[1], 'rows and', dim(train)[2], 'columns.')
cat('Test has', dim(test)[1], 'rows and', dim(test)[2], ' columns.')

```


```{r}
# The percentage of data missing in train.
sum(is.na(train)) / (nrow(train) *ncol(train))

# The percentage of data missing in test.
sum(is.na(test)) / (nrow(test) * ncol(test))


```






```{r}
# Check for duplicated rows.

cat("The number of duplicated rows are", nrow(train) - nrow(unique(train)))

####Convert character to factors 

train[,(cat_var) := lapply(.SD, as.factor), .SDcols = cat_var]




```

```{r}
train_cat <- train[,.SD, .SDcols = cat_var]
train_cont <- train[,.SD,.SDcols = numeric_var]

plotHist <- function(data_in, i) {
  data <- data.frame(x=data_in[[i]])
  p <- ggplot(data=data, aes(x=factor(x))) + stat_count() + xlab(colnames(data_in)[i]) + theme_light() + 
    theme(axis.text.x = element_text(angle = 90, hjust =1))
  return (p)
}

doPlots <- function(data_in, fun, ii, ncol=3) {
  pp <- list()
  for (i in ii) {
    p <- fun(data_in=data_in, i=i)
    pp <- c(pp, list(p))
  }
  do.call("grid.arrange", c(pp, ncol=ncol))
}


plotDen <- function(data_in, i){
  data <- data.frame(x=data_in[[i]], SalePrice = data_in$SalePrice)
  p <- ggplot(data= data) + geom_line(aes(x = x), stat = 'density', size = 1,alpha = 1.0) +
    xlab(paste0((colnames(data_in)[i]), '\n', 'Skewness: ',round(skewness(data_in[[i]], na.rm = TRUE), 2))) + theme_light() 
  return(p)
   
}


```


## Barplots for the categorical features

The bar plots below offer more insight into the data.
MSZoning: bar plot indicates that majority of the houses are located in low density residential areas and medium density residential area. 

The type of road access to the property tends to be paved and the houses do not have alleys.

* Landcontour: the houses are built on flat properties
* Utilities: Almost all homes have all public utilities (E,G,W, & S)
* LandSlope: most of the properties have a gentle slope

```{r categorical}
doPlots(train_cat, fun = plotHist, ii = 1:4, ncol = 2)
doPlots(train_cat, fun = plotHist, ii  = 4:8, ncol = 2)
doPlots(train_cat, fun = plotHist, ii = 8:12, ncol = 2)
doPlots(train_cat, fun = plotHist, ii = 13:18, ncol = 2)
doPlots(train_cat, fun = plotHist, ii = 18:22, ncol = 2)

```


The houses that have sever landslope are located in the Clear Creek and Timberland. The houses with moderate landslope are present in more neighborhood. The Clear Creek and the Crawford neighborhoods seem to have high slopes. 





```{r}
train %>% select(LandSlope, Neighborhood, SalePrice) %>% filter(LandSlope == c('Sev', 'Mod')) %>% arrange(Neighborhood) %>% group_by(Neighborhood, LandSlope) %>% summarize(Count = n()) %>% ggplot(aes(Neighborhood, Count)) + geom_bar(aes(fill = LandSlope), position = 'dodge', stat = 'identity') + theme_light() +theme(axis.text.x = element_text(angle = 90, hjust =1))

```



Plotting a boxplot between the neighboorhoods and sale price shows that BrookSide and South & West of Iowa State University have cheap houses. While Northridge and Northridge Heights are rich neighborhoods with several outliers in terms of price. 

```{r}
train %>% select(Neighborhood, SalePrice) %>% ggplot(aes(factor(Neighborhood), SalePrice)) + geom_boxplot() + theme(axis.text.x = element_text(angle = 90, hjust =1)) + xlab('Neighborhoods')

```




## Density plots for numeric variables.

Density plots of the features indicates that the features are skewed. The denisty plot for YearBuilt shows that the data set contains a mix of new and old houses. It shows a downturn in the number of houses in recent years, possibily due to the housing crisis. 
```{r numeric}

doPlots(train_cont, fun = plotDen, ii = 2:6, ncol = 2)
doPlots(train_cont, fun = plotDen, ii = 7:12, ncol = 2)
doPlots(train_cont, fun = plotDen, ii = 13:17, ncol = 2)

```


The histograms below show that majority of the houses have 2 full baths, 0 half baths, and have an average of 3 bedrooms.

```{r}
doPlots(train_cont, fun = plotHist, ii = 18:23, ncol = 2)

```

## Explore the correlation
```{r, fig.height= 10, fig.width= 10}
correlations <- cor(na.omit(train_cont[,-1, with = FALSE]))

# correlations
row_indic <- apply(correlations, 1, function(x) sum(x > 0.3 | x < -0.3) > 1)

correlations<- correlations[row_indic ,row_indic ]
corrplot(correlations, method="square")




```



## Plot scatter plot for variables that have high correlation.
The correlation matrix below shows that there are several variables that are strongly and positively correlated with housing price.

High positive correlation:

* OverallQual
* YearBuilt
* YearRemodAdd
* MasvnrArea
* BsmtFinSF1
* TotalBsmtSF
* 1stFlrSF
* GrLiveArea
* FullBath
* TotRmsAbvGrd
* FirePlaces
* GarageYrBlt
* GarageCars
* GarageArea
* WoodDeskSF
* OpenPorchSF

The number of enclosed porches are negatively correlated with year built. It seems that potential housebuyers do not want an enclosed porch and house developers have been building less enclosed porches in recent years. It is also negatively correlated with SalePrice, which makes sense. 

There is some slight negative correlation between OverallCond and SalePrice. There is also strong negative correlation between Yearbuilt and OverallCond. It seems to be that recently built houses tend to been in worse Overall Condition. 



```{r}
train %>% select(OverallCond, YearBuilt) %>% ggplot(aes(factor(OverallCond),YearBuilt)) + geom_boxplot() + xlab('Overall Condition')

```



```{r}

plotCorr <- function(data_in, i){
  data <- data.frame(x = data_in[[i]], SalePrice = data_in$SalePrice)
  p <- ggplot(data, aes(x = x, y = SalePrice)) + geom_point(shape = 1, na.rm = TRUE) + geom_smooth(method = lm ) + xlab(paste0(colnames(data_in)[i], '\n', 'R-Squared: ', round(cor(data_in[[i]], data$SalePrice, use = 'complete.obs'), 2))) + theme_light()
  return(suppressWarnings(p))
}


highcorr <- c(names(correlations[,'SalePrice'])[which(correlations[,'SalePrice'] > 0.5)], names(correlations[,'SalePrice'])[which(correlations[,'SalePrice'] < -0.2)])
 
data_corr <- train[,highcorr, with = FALSE]


doPlots(data_corr, fun = plotCorr, ii = 1:6)

doPlots(data_corr, fun = plotCorr, ii = 6:11)


```


The histogram for the response variable SalePrice shows that it is skewed. Taking the log of the variable normalizes it. 

```{r}
library(scales)
ggplot(train, aes(x=SalePrice)) + geom_histogram(col = 'white') + theme_light() +scale_x_continuous(labels = comma)
summary(train[,.(SalePrice)])
#Normalize distribution
ggplot(train, aes(x=log(SalePrice+1))) + geom_histogram(col = 'white') + theme_light()

```



