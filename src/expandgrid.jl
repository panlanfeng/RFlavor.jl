"""
Generate a long DataFrames containing all combinations of keywords arguments.

#Example
```
expand_grid(; x=1:4, y=["a","b"])
```
"""
function expand_grid(;args...)
    p = length(args)
    if p == 0
        DataFrame()
    end
    vtype = Array(DataType, p)
    cnames = Array(Symbol, p)
    n = 1
    i = 1
    for arg in args
        n*=length(arg[2])
        vtype[i] = eltype(arg[2])
        cnames[i] = arg[1]
        i+=1
    end
    res = Any[DataArray(vtype[nj], n) for nj in 1:p]
    n1=1
    i = 1
    for arg in args
        n = div(n, length(arg[2]))
        res[i]=DataArray(rep(arg[2], n1, n))
        n1 *= length(arg[2])
        i += 1
    end
    DataFrame(res, Index(cnames))
end
