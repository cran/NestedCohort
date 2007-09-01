\name{zinc}
\alias{zinc}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Example Study Nested within a Cohort: Zinc and Esophageal Cancer }
\description{
  \code{zinc} is a data frame, with some variables observed on all
  subjects, and some variables not.  The outcome variable is ec01,
  indicating esophageal cancer or not at time futime01.  The zinc
  variables are in zncent (continuous), znqt (ordinal zinc quartiles),
  or znquartiles (factor variable notating quartiles of zinc)
}

\usage{ data(zinc) }

\format{
  See \link{nested.coxph} for example of using this dataset.
}

\references{ 

  Christian C. Abnet, Barry Lai, You-Lin Qiao, Stefan Vogt,
  Xian-Mao Luo, Philip R. Taylor, Zhi-Wei Dong, Steven D. Mark,
  Sanford M. Dawsey.  Zinc concentration in esophageal biopsies measured
  by X-ray fluorescence and cancer risk. Journal of the National Cancer
  Institute, 2005; 97(4) 301-306
  
}

\source{ Steven D. Mark }

\keyword{ datasets }% at least one, from doc/KEYWORDS
