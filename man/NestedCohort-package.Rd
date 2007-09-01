\name{NestedCohort-package}
\alias{NestedCohort-package}
\alias{NestedCohort}
\docType{package}
\title{
  Survival Analysis of Cohort Studies With Missing Covariate Information
  ~~ NestedCohort ~~
}
\description{
  NestedCohort fits Kaplan-Meier and Cox Models to estimate standardized
  survival and attributable risks for studies where covariates of
  interest are observed on only a sample of the cohort.  Missingness can
  be either by happenstance or by design (for example, the case-cohort
  and case-control within cohort designs). 
}
\details{
\tabular{ll}{
Package: \tab NestedCohort\cr
Type: \tab Package\cr
Version: \tab 1.0-1\cr
Date: \tab 2007-09-01\cr
License: \tab Unlimited\cr
}

To fit Kaplan-Meier, use nested.km().  If you only want hazard ratios
from a Cox model, used nested.coxph().  If you want standardized
survival and attributable risk estimates, used nested.stdsurv().

}
\author{

  Author: Hormuzd A. Katki

  Maintainer: Hormuzd A. Katki <katkih@mail.nih.gov>
}
\references{
  Mark, S.D. and Katki, H.A. Specifying and Implementing Nonparametric and
  Semiparametric Survival Estimators in Two-Stage (sampled) Cohort Studies with
  Missing Case Data. Journal of the American Statistical Association, 2006, 101,
  460-471.
}
\keyword{ survival }
\keyword{ survey }

\seealso{
~~ \code{\link[survival:survival-package]{survival}} ~~
}
\examples{

# Get zinc dataset
data(zinc)

# Fit and plot Kaplan-Meier
mod <- nested.km(survfitformula="Surv(futime01,ec01==1)~znquartiles",
                 samplingmod="ec01*basehist",data=zinc)
plot(mod,ymin=.6,xlab="Time (Days)",ylab="Survival",main="Survival by Quartile of Zinc",
     legend.text=c("Q1","Q2","Q3","Q4"),lty=1:4,legend.pos=c(2000,.7))

# Fit Cox model, get hazard ratios
coxmod <- nested.coxph(coxformula="Surv(futime01,ec01==1)~
          sex+agepill+smoke+drink+mildysp+moddysp+sevdysp+anyhist+zncent",
          samplingmod="ec01*basehist",data=zinc)
summary(coxmod)

# Fit Cox model, get standardized survivals and attributable risks
mod <- nested.stdsurv(outcome="Surv(futime01,ec01==1)",
                      exposures="znquartiles",
                      confounders="sex+agestr+smoke+drink+mildysp+moddysp+sevdysp+anyhist",
                      samplingmod="ec01*basehist",exposureofinterest="Q4",plot=TRUE,
                      main="Time to Esophageal Cancer by Quartiles of Zinc",data=zinc)

}
