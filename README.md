# Reproducing the Manuscript Figures — *Economic Impact of Biomarker-Based Aging Interventions*

This repository reproduces the figures and headline numbers (Tables 3–5, Figures 2–9) from
the manuscript *"Economic impact of biomarker-based aging interventions on healthcare costs
and individual value"*, using the notebook `Reproduce_Manuscript_Figures_9.ipynb`.

## Data files

The notebook reads from two Excel workbooks, which must be placed in the same folder as
the notebook (see the `DATA_DIR` path set in the setup cell):

- **`Frailty_model_excel.xlsx`** — contains the series of pre-calculations on the evolution
  of the Frailty Index based on the DunedinPACE epigenetic clock. This includes, per age and
  per scenario (`base`, `CR0`, `CR1`, `CR2`), the Clock trajectory, the Frailty Index, and
  the resulting proportion of the population classified as frail (Equations 1–3 of the
  manuscript).

- **`Data_Soruce_File_1.xlsx`** — contains the background mortality data (Swiss life tables)
  underlying the survival modelling (Equations 4–5), which is combined with the
  frailty-dependent hazard ratio to derive the survival curves and life-expectancy gains
  reported in Table 3 and Figure 6.

Without these two files present alongside the notebook, the cells that load and process the
data will fail.

## Underlying economic framework

The value-of-life / willingness-to-pay component of this analysis (Section 2.6 and Equation
10 of the manuscript, Figures 7–9) rests entirely on the modelling framework and codebase
developed by Julian Ashwin, available at:

**https://github.com/julianashwin/international-gains-to-healthy-longevity**

That repository contains a series of Julia scripts which, for a given set of macroeconomic
parameters, extract the two weighting functions used throughout this notebook:

- `v(t)` — the value of a life year, used to convert changes in survival into the lifespan
  component of willingness-to-pay.
- `u(t)/u_c(t)` — the ratio of utility to the marginal utility of consumption, used to
  convert changes in health quality into the healthspan component of willingness-to-pay.

This notebook does not re-derive `v(t)` or `u(t)/u_c(t)` from macroeconomic first principles;
it consumes the pre-computed values produced by Ashwin's Julia codebase (as stored in the
`v` sheet of `Frailty_model_excel.xlsx` and referenced elsewhere in the notebook) and applies
them to the frailty and survival trajectories modelled here.

## The macroeconomic model behind v(t) and u(t)/u_c(t)

Ashwin's Julia codebase implements the life-cycle model set out in Scott, Ashwin, Ellison &
Sinclair, *"International Gains to Achieving Healthy Longevity"* (working paper), itself
building on Murphy and Topel (2006). In that framework, agents choose consumption and
leisure over the life cycle to maximise discounted lifetime utility subject to a standard
budget constraint; `v(t)` (the value of a life year) and the ratio of utility to the
marginal utility of consumption `u(t)/u_c(t)` fall out of this optimisation, calibrated to
match macroeconomic parameters such as wages, interest rates, and consumption/leisure
preferences.

This notebook does not implement or depend on that underlying life-cycle optimisation, or
on the specific functional forms (frailty, mortality, or health) used within it — it simply
takes `v(t)` and `u(t)/u_c(t)` as given, pre-computed outputs of Ashwin's codebase (read
from the `v` sheet of `Frailty_model_excel.xlsx`, and from the recovered `u_over_uc`
values respectively), and applies them to the DunedinPACE-derived frailty and survival
trajectories described above.

## Running the notebook

1. Place `Frailty_model_excel.xlsx` and `Data_Soruce_File_1.xlsx` in the same directory as
   `Reproduce_Manuscript_Figures_9.ipynb` (or update `DATA_DIR` at the top of the notebook to
   point to their location).
2. Run all cells in order. The notebook proceeds section by section through the manuscript's
   figures and tables, printing a comparison against the manuscript's published values at
   each step, with a full summary table near the end.

