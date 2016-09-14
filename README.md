# RFlavor

[![Build Status](https://travis-ci.org/panlanfeng/RFlavor.jl.svg?branch=master)](https://travis-ci.org/panlanfeng/RFlavor.jl)

[![Coverage Status](https://coveralls.io/repos/panlanfeng/RFlavor.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/panlanfeng/RFlavor.jl?branch=master)

[![codecov.io](http://codecov.io/github/panlanfeng/RFlavor.jl/coverage.svg?branch=master)](http://codecov.io/github/panlanfeng/RFlavor.jl?branch=master)


This package adds some R flavors to Julia. Many functions have been used by statisticians for a long time and are just "right" for statistics.

This package provides
* `list`, which is more flexible than `Dict`. Its elements can be accessed by either names or numbers;
* R-like array construction functions: `seq`,`rep`, `matrix`, `array`, `outer`, `expand_grid`;
* `table`. The difference with `counts` from StatsBase is it can print out levels as well as counts;
* Handy functions such as `duplicated`, `findinterval`, `setequal`, `head`, `tail` and `sweep`
* \*apply series functions
* More to come...

Download this package by
```Julia
Pkg.clone("https://github.com/panlanfeng/RFlavor.jl")
```

See help by typing
```Julia
?functionname
```

## Naming tradition

* The dot "." in R functions will be replaced by underscore "\_"
* Functions will be lower cases to follow Julia tradition (debatable)

This package is still under development. All feature requests and comments are welcome.
