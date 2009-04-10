\name{nested.coxph}
\alias{nested.coxph}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Estimate Cox model hazard ratios for covariates with missing data}
\description{
  \code{nested.coxph} fits the Cox model to estimate hazard ratios
  for covariates that are missing data on some cohort members.  All
  covariates may be continous or categorical.
  \code{nested.coxph} requires knowledge of the variables that
  missingness depends on, with missingness probability modeled through a
  \code{\link{glm}} sampling model.  Often, the data is in the form of a
  case-control sample taken within a cohort.  \code{nested.coxph} allows
  cases to have missing data, and can extract efficiency from auxiliary
  variables by including them in the sampling model.  \code{nested.coxph}
  requires \code{\link{coxph}} from the survival package.
}
\usage{
nested.coxph(coxformula, samplingmod, data, outputsamplingmod = FALSE,
             glmlink = binomial(link = "logit"),
             glmcontrol = glm.control(epsilon = 1e-10, maxit = 10, trace = FALSE),
             coxphcontrol = coxph.control(eps = 1e-10, iter.max = 50),
             missvarwarn = TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{

  Required arguments:
  
  \item{coxformula}{ Standard \code{coxph} formula }
  \item{samplingmod}{ Right side of the formula for the \code{glm}
	 sampling model that models the probability of missingness } 
  \item{data}{ Data Frame that all variables are in }

  Optional arguments:
  \item{outputsamplingmod}{ Output the sampling model, default is false  }
  \item{glmlink}{ Sampling model link function, default is logistic regression }
  \item{glmcontrol}{ See \code{\link{glm.control}} }
  \item{coxphcontrol}{ See \code{\link{coxph.control}} }
  \item{missvarwarn}{ Warn if there is missing data in the sampling
	 variable. Default is TRUE }
  \item{\dots}{ Any additional arguments to be passed on to \code{glm}
	 or \code{coxph} }
}
\details{

  If \code{nested.coxph} reports that the sampling model "failed to converge",
  the sampling model will be returned for your inspection.  Note that if
  some sampling probabilities are estimated at 1, the model technically
  cannot converge, but you get very close to 1, and \code{nested.coxph}
  will not report non-convergence for this situation.

  Note these issues.
  The data must be in a dataframe and specified in the data statement.
  No variable can be named 'o.b.s.e.r.v.e.d.' or 'p.i.h.a.t.'.
  Cases and controls cannot be finely matched on time, but
  matching on time within large strata is allowed.
  cluster() statements are not allowed in coxformula.
  Allows left truncation, staggered entry, open cohorts, and stratified
  baseline hazards.
  Must use Breslow Tie-Breaking.
}
\value{
  If outputsamplingmod=FALSE, the output are the hazard ratios and the
  \code{coxph} model.  Any
  method for \code{coxph} objects will work for this so long
  as that method only requires consistent estimates of the parameters and
  their standard errors.
  If outputsamplingmod=TRUE, then the sampling model is also returned, and
  the output is a list with components:
  \item{coxmod}{The Cox model of class \code{coxph}}
  \item{samplingmod}{The sampling model of class \code{glm}}
}

\references{ 

  Katki HA, Mark SD.  Survival Analysis for Cohorts with Missing
  Covariate Information.  R-News, 8(1) 14-9, 2008.
  http://www.r-project.org/doc/Rnews/Rnews_2008-1.pdf
  
  Mark, S.D. and Katki, H.A. Specifying and Implementing Nonparametric and
  Semiparametric Survival Estimators in Two-Stage (sampled) Cohort Studies with
  Missing Case Data. Journal of the American Statistical Association, 2006, 101,
  460-471.

  Mark SD, Katki H. Influence function based variance estimation and
  missing data issues in case-cohort studies. Lifetime Data Analysis,
  2001; 7; 329-342

  Christian C. Abnet, Barry Lai, You-Lin Qiao, Stefan Vogt,
  Xian-Mao Luo, Philip R. Taylor, Zhi-Wei Dong, Steven D. Mark,
  Sanford M. Dawsey.  Zinc concentration in esophageal biopsies measured
  by X-ray fluorescence and cancer risk.  To Appear in Journal of the
  National Cancer Institute.

}

\author{ Hormuzd A. Katki }

\note{

  Requires the MASS library from the VR bundle that is available from
  the CRAN website. 
  
}

% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{ See Also: \code{\link{nested.stdsurv}}, \code{\link{zinc}},
  \code{\link{nested.km}}, \code{\link{coxph}}, \code{\link{glm}}
}

\examples{
## Simple analysis of zinc and esophageal cancer data:
## We sampled zinc (variable zncent) on a fraction of the subjects, with
## sampling fractions depending on cancer status and baseline histology.
## We observed the confounding variables on almost all subjects.
data(zinc)
coxmod <- nested.coxph(coxformula="Surv(futime01,ec01==1)~
          sex+agepill+smoke+drink+mildysp+moddysp+sevdysp+anyhist+zncent",
          samplingmod="ec01*basehist",data=zinc)
summary(coxmod)

# This is the output:
#  Call:
#  coxph(formula = as.formula(coxformula), data = data, weights = 1/p.i.h.a.t., 
#      na.action = na.omit, control = coxphcontrol, method = "breslow", 
#      x = T)

#    n=123 (308 observations deleted due to missing)
#                               coef exp(coef) se(coef)       z       p
#  sexMale                    0.2953     1.344   0.5558  0.5313 6.0e-01
#  agepill                    0.0539     1.055   0.0275  1.9612 5.0e-02
#  smokeEver                  0.0145     1.015   0.5870  0.0248 9.8e-01
#  drinkEver                 -0.8548     0.425   0.5896 -1.4497 1.5e-01
#  mildyspMild Dysplasia      0.9023     2.465   0.3937  2.2921 2.2e-02
#  moddyspModerate Dysplasia  1.3309     3.784   0.4212  3.1600 1.6e-03
#  sevdyspSevere Dysplasia    2.1334     8.444   0.4615  4.6224 3.8e-06
#  anyhistFamily History      0.0904     1.095   0.3896  0.2321 8.2e-01
#  zncent                    -0.2498     0.779   0.1351 -1.8487 6.4e-02

#                            exp(coef) exp(-coef) lower .95 upper .95
#  sexMale                       1.344      0.744     0.452      3.99
#  agepill                       1.055      0.948     1.000      1.11
#  smokeEver                     1.015      0.986     0.321      3.21
#  drinkEver                     0.425      2.351     0.134      1.35
#  mildyspMild Dysplasia         2.465      0.406     1.140      5.33
#  moddyspModerate Dysplasia     3.784      0.264     1.658      8.64
#  sevdyspSevere Dysplasia       8.444      0.118     3.417     20.86
#  anyhistFamily History         1.095      0.914     0.510      2.35
#  zncent                        0.779      1.284     0.598      1.02

#  Rsquare= NA   (max possible= NA )
#  Likelihood ratio test= NA  on 9 df,   p=NA
#  Wald test            = 66.5  on 9 df,   p=7.32e-11
#  Score (logrank) test = NA  on 9 df,   p=NA
}

\keyword{ models }% at least one, from doc/KEYWORDS
