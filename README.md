# Critical branching process on stochatic SIR model

Code for critical branching process on stochastic SIR model with power-law infective duration. 

Link to the paper: https://iopscience.iop.org/article/10.1088/1751-8121/ac65c3/pdf

This repository contains:

- 'size_vs_duration.jl': The codes produce the duration of the avalanche $$T$$ and corresponding avalanche size $$n$$.

# How to use
The Julia code is implemented in Julia 1.7. Packages used are `DelimitedFiles`, `StatsBase`, `SpecialFunctions` and `PoissonRandom`.

# Citing
If you find the code useful in your research, please cite the following paper:

```latex

@article{10.1088/1751-8121/ac65c3,
	author={Sun, Hanlin and Kryven, Ivan and Bianconi, Ginestra},
	title={Critical time-dependent branching process modelling epidemic spreading with containment measures},
	journal={Journal of Physics A: Mathematical and Theoretical},
	url={http://iopscience.iop.org/article/10.1088/1751-8121/ac65c3},
	year={2022},
}
```
# License
This code can be redistributed and/or modified under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
  
This program is distributed by the authors in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
