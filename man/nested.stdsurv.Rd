\name{nested.stdsurv}
\alias{nested.stdsurv}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Estimate Standardized Survivals and Attributable Risks for
  covariates with missing data }
\description{
  The function \code{nested.stdsurv} fits the Cox model to estimate
  standardized survival curves and attributable risks for covariates
  that are missing data on some cohort members.  All covariates must be
  factor variables.
  \code{nested.stdsurv} requires knowledge of the variables that
  missingness depends on, with missingness probability modeled through a
  \code{\link{glm}} sampling model.  Often, the data is in the form of a
  case-control sample taken within a cohort.  \code{nested.stdsurv} allows
  cases to have missing data, and can extract efficiency from auxiliary
  variables by including them in the sampling model.  \code{nested.stdsurv}
  requires \code{\link{coxph}} from the survival package.
}

\usage{
nested.stdsurv(outcome, exposures, confounders, samplingmod, data,
               exposureofinterest = "", timeofinterest = Inf,cuminc=FALSE,
               plot = FALSE, plotfilename = "", glmlink = binomial(link = "logit"),
               glmcontrol = glm.control(epsilon = 1e-10, maxit = 10, trace = FALSE),
               coxphcontrol = coxph.control(eps = 1e-10, iter.max = 50),
               missvarwarn = TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.

\arguments{

  Required arguments:
  \item{outcome}{ Survival outcome of interest, must be a
	 \code{\link{Surv}} object }
  \item{exposures}{ The part of the right side of the Cox model that parameterizes the
	 exposures.  Never use '*' for interaction, use
	 \code{\link{interaction}}.  Survival probabilities will be computed
	 for each level of the exposures.  }
  \item{confounders}{ The part of the right side of the Cox model that
	 parameterizes the confounders.  Never use '*' for interaction, use
	 \code{\link{interaction}}. }
  \item{samplingmod}{ Right side of the formula for the \code{glm}
	 sampling model that models the probability of missingness }
  \item{data}{ Data Frame that all variables are in }

  Optional arguments:
  \item{exposureofinterest}{ The name of the level of the exposures for which
	 attributable risk is desired.  Default is the first level of the exposure. }
  \item{timeofinterest}{ The time at which survival probabilities and
	 attributable risks are desired.  Default is the last event time. }
  \item{cuminc}{ Set to T if you want output as cumulative incidence, F
	 for survival }
  \item{plot}{ If T, plot the standardized survivals.  Default is F. }
  \item{plotfilename}{ A string for the filename to save the plot as }
  \item{glmlink}{ Sampling model link function, default is logistic regression }
  \item{glmcontrol}{ See \code{\link{glm.control}} }
  \item{coxphcontrol}{ See \code{\link{coxph.control}} }
  \item{missvarwarn}{ Warn if there is missing data in the sampling
	 variable. Default is TRUE }
  \item{\dots}{ Any additional arguments to be passed on to \code{glm}
	 or \code{coxph} }
}
\details{

  If \code{nested.stdsurv} reports that the sampling model "failed to converge",
  the sampling model will be returned for your inspection.  Note that if
  some sampling probabilities are estimated at 1, the model technically
  cannot converge, but you get very close to 1, and \code{nested.stdsurv}
  will not report non-convergence for this situation.

  Note the following issues.  

  The data must be in a dataframe and specified in the data statement. 
  No variable can be named 'o.b.s.e.r.v.e.d.' or 'p.i.h.a.t.'.
  Cases and controls cannot be finely matched on time, but
  matching on time within large strata is allowed. 
  strata(), cluster() or offset() statements in
  or confounders are not allowed.
  Everyone must enter the cohort at the same time on the
  vival time scale.
  Must use Breslow Tie-Breaking.
  All covariates must be factor variables, even if binary.
  Do not use '*' to mean interaction in exposures or
  confounders, use \code{\link{interaction}}.
}

\value{
  A List with the following components:
  \item{coxmod }{The fitted Cox model}
  \item{samplingmod }{The fitted glm sampling model}
  \item{survtable }{Standardized survival (and inference) for each
	 exposure level}
  \item{riskdifftable }{Standardized survival (risk) differences (and
	 inference) for each exposure level, relative to the exposure of
	 interest. }
  \item{PARtable }{Population Attributable Risk (and inference) for the
	 exposure of interest}

  If plot=T, then the additional component is included:
  \item{plotdata }{A matrix with data needed to plot the survivals:
	 time, standardized survival for each exposure level, and crude
	 survival.  Name of each exposure level is converted to a proper R
	 variable name (these are the column labels).}
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
  by X-ray fluorescence and cancer risk. Journal of the National Cancer
  Institute, 2005; 97(4) 301-306

}

\author{ Hormuzd A. Katki }

\note{

  Requires the MASS library from the VR bundle that is available from
  the CRAN website.
}

% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{ See Also: \code{\link{nested.coxph}}, \code{\link{zinc}},
  \code{\link{nested.km}}, \code{\link{coxph}}, \code{\link{glm}}
}

\examples{
## Simple analysis of zinc and esophageal cancer data:
## We sampled zinc (variable znquartiles) on a fraction of the subjects, with
## sampling fractions depending on cancer status and baseline histology.
## We observed the confounding variables on almost all subjects.
data(zinc)
mod <- nested.stdsurv(outcome="Surv(futime01,ec01==1)",
                      exposures="znquartiles",
                      confounders="sex+agestr+smoke+drink+mildysp+moddysp+sevdysp+anyhist",
                      samplingmod="ec01*basehist",exposureofinterest="Q4",data=zinc)

# This is the output:
#  Standardized Survival for znquartiles by time 5893 
#        Survival  StdErr 95% CI Left 95% CI Right
#  Q1      0.5443 0.07232      0.3932       0.6727
#  Q2      0.7595 0.07286      0.5799       0.8703
#  Q3      0.7045 0.07174      0.5383       0.8203
#  Q4      0.8911 0.06203      0.6863       0.9653
#  Crude   0.7784 0.02491      0.7249       0.8228

#  Standardized Risk Differences vs. znquartiles = Q4 by time 5893 
#             Risk Difference  StdErr 95% CI Left 95% CI Right
#  Q4 - Q1             0.3468 0.10376    0.143412       0.5502
#  Q4 - Q2             0.1316 0.09605   -0.056694       0.3198
#  Q4 - Q3             0.1866 0.09355    0.003196       0.3699
#  Q4 - Crude          0.1126 0.06353   -0.011871       0.2372

#  PAR if everyone had znquartiles = Q4 
#             Estimate StdErr 95% PAR CI Left 95% PAR CI Right
#  PAR          0.5084 0.2777        -0.03585           1.0526
#  log(1-PAR)  -0.7100 0.5648        -0.48723           0.8375
}

 
\keyword{ models }% at least one, from doc/KEYWORDS

