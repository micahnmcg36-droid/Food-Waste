library(MASS)
library(brant)

## Running the ordered logit and Brant Test on the first specification

df <- read.csv("C:/Users/micah/Downloads/Food_Waste/brant_model1_scaled.csv")


df$X3M_ACT_TRIED_YN <- factor(df$X3M_ACT_TRIED_YN, ordered = TRUE)

model <- polr(X3M_ACT_TRIED_YN ~ VIDEO_AVG_NCT,
              data = df,
              Hess = TRUE)

summary(model)

brant(model)

## Running the ordered logit and Brant Test on the second specification

df <- read.csv("C:/Users/micah/Downloads/Food_Waste/brant_model2_scaled.csv")

df$X <- NULL

df$X3M_ACT_TRIED_YN <- factor(df$X3M_ACT_TRIED_YN, ordered = TRUE)

model <- polr(X3M_ACT_TRIED_YN ~ .,
              data = df,
              Hess = TRUE)

summary(model)

brant(model)
