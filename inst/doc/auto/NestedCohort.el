(TeX-add-style-hook "NestedCohort"
 (function
  (lambda ()
    (LaTeX-add-bibliographies
     "e:/hkatki/Bibliographies/RiskPrediction"
     "e:/hkatki/Bibliographies/statbib"
     "e:/hkatki/Bibliographies/genetics")
    (LaTeX-add-environments
     '("changemargin" 2))
    (LaTeX-add-labels
     "sec:overview"
     "sec:case-study:-zinc"
     "sec:sampling-model"
     "sec:kaplan-meier-curves"
     "sec:plott-kapl-meier"
     "fig:PlotKM"
     "sec:texttts-with-weights"
     "sec:relat-risks-hazard"
     "sec:stand-surv-attr"
     "fig:PlotStdSurv"
     "sec:notes")
    (TeX-add-symbols
     "bex"
     "eex")
    (TeX-run-style-hooks
     "apalike"
     "S"
     "psfig"
     "fullpage"
     "latex2e"
     "art10"
     "article"
     "10pt"))))

