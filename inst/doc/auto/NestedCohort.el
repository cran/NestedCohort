(TeX-add-style-hook "NestedCohort"
 (function
  (lambda ()
    (LaTeX-add-environments
     '("changemargin" 2))
    (LaTeX-add-bibitems
     "Abnet:05"
     "Katki:Mark:08"
     "Mark:Katki:06")
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
     "sec:other-topics"
     "sec:how-use-auxiliary"
     "sec:how-fit-multiple"
     "sec:full-cohort-analysis"
     "sec:importing-data-into")
    (TeX-add-symbols
     "bex"
     "eex")
    (TeX-run-style-hooks
     "psfig"
     "fullpage"
     "latex2e"
     "art10"
     "article"
     "10pt"))))

