\name{nested.km}
\alias{nested.km}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Estimate non-parametric survival curves for each level of
  categorical variables with missing data. }
\description{
  The function \code{nested.km} gives non-parametric survival curve estimates
  (like Kaplan-Meier) for each level of categorical variables that have
  missing data on some cohort members.  These variables must be factor variables. 
  \code{nested.km} requires knowledge of the variables that missingness depends
  on, with missingness probability modeled through a \code{\link{glm}}
  sampling model.  Often, the data is in the form of a case-control
  sample taken within a cohort.  \code{nested.km} allows cases to have
  missing data, and can extract efficiency from auxiliary variables by
  including them in the sampling model.  \code{nested.km} makes heavy
  use of the \code{\link{survfit}} function in the survival package.  
}

\usage{
nested.km(survfitformula, samplingmod, data, outputsamplingmod=FALSE,
          outputriskdiff = FALSE, exposureofinterest = "",
          timeofinterest = Inf, glmlink = binomial(link = "logit"),
          glmcontrol = glm.control(epsilon = 1e-10, maxit = 10, trace = FALSE),
          missvarwarn = TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.

\arguments{

  Required arguments:
  \item{survfitformula}{ Legal formula for a \code{\link{survfit}} object }
  \item{samplingmod}{ Right side of the formula for the \code{glm}
	 sampling model that models the probability of missingness }
  \item{data}{ Data Frame that all variables are in }

  Optional arguments:
  \item{outputsamplingmod}{ Output the sampling model, default is false}
  \item{outputriskdiff}{ Output risk differences, default is false }
  \item{exposureofinterest} { Exposure level to make risk differences with
respect to }
  \item{timeofinterest} { Time at which to report risk differenes,
default is end of followup }
  \item{glmlink}{ Sampling model link function, default is logistic regression }
  \item{glmcontrol}{ See \code{\link{glm.control}} }
  \item{missvarwarn} { Warn if there is missing data in the sampling
	 variable. default is true }
  \item{\dots}{ Any additional arguments to be passed on to \code{\link{survfit}} }
}

\details{

  \code{nested.km} provides survival estimates that are not
  standardized for confounders nor account for competing risks.
  
  If \code{nested.km} reports that the sampling model "failed to converge",
  the sampling model will be returned for your inspection.  Note that if
  some sampling probabilities are estimated at 1, the model technically
  cannot converge, but you get very close to 1, and \code{nested.km}
  will not report non-convergence for this situation.
  
  Some caveats:
  \item{1. }{ The data must be in a dataframe and specified in the data statement}
  \item{2. }{ No variable in the dataframe can be named 'o.b.s.e.r.v.e.d.' or 'p.i.h.a.t.'}
  \item{3. }{ Cases and controls cannot be finely matched on time, but
	 frequency matching on time within large strata is allowed }
  \item{4. }{ Everyone must enter the cohort at the same time on the
	 chosen survival time scale.}
  \item{5. }{ All covariates in the survfitformula must be factor
	 variables, even if binary}
  \item{6. }{ Never use '*' to mean interaction in the survfitformula,
	 instead use \code{\link{interaction}}} 
}

\value{
  
  If outputpropmod=F, the output is the survival curves in the
  \code{survfit} model.  Any
  method that works for \code{survfit} objects will work for this so long
  as the method only requires consistent estimates of the parameters and
  their standard errors.
  If outputpropmod=T, then the sampling model is also returned, and the output
  is a list with components:
  \item{survmod}{The survfit model of class \code{survfit}}
  \item{propmod}{The sampling model of class \code{glm}}
  
}

\references{ 

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
  \code{\link{nested.coxph}}, \code{\link{coxph}}, \code{\link{glm}}
}

\examples{
## Simple analysis of zinc and esophageal cancer data:
## We sampled zinc (variable znquartiles) on a fraction of the subjects, with
## sampling fractions depending on cancer status and baseline histology.
## We observed the confounding variables on almost all subjects.
data(zinc)
mod <- nested.km(survfitformula="Surv(futime01,ec01==1)~znquartiles",
                 samplingmod="ec01*basehist",data=zinc)

# This is the output
#  Risk Differences vs. znquartiles=Q1 by time Inf 
#          Risk Difference StdErr 95% CI Left 95% CI Right
#  Q1 - Q2         -0.2262 0.1100     -0.4419     -0.01060
#  Q1 - Q3         -0.1749 0.1145     -0.3993      0.04945
#  Q1 - Q4         -0.2818 0.1042     -0.4859     -0.07760

plot(mod,ymin=.6,xlab="Time (Days)",ylab="Survival",main="Survival by Quartile of Zinc",
     legend.text=c("Q1","Q2","Q3","Q4"),lty=1:4,legend.pos=c(2000,.7))
}

\keyword{ models }% at least one, from doc/KEYWORDS

