"""
    sweep(x, MARGIN, STATS, FUN)

Return an array obtained from an input array `x` by sweeping out a (lower dimension) summary statistic `STATS` along dimension `MARGIN`.

```
A = reshape(1:24, (4,3,2))
sweep(A, 1, 1:4)

Amedian=mapslices(median, A, 3)
sweep(A, 1:2, Amedian)
```
"""
function sweep(x::AbstractArray, MARGIN::AbstractVector, STATS::AbstractArray, FUN::Function=.-; kwargs...)
    sz = collect(size(x))
    dimmargin = sz[MARGIN]
    dimstats = size(STATS)
    lstats = length(STATS)
    lmargin = prod(dimmargin)
    if lstats > lmargin
        error("STATS is longer than extent of dimension $(sz[MARGIN])")
    else
        if mod(lmargin, lstats) != 0
            error("STATS does not recycle exactly across MARGIN")
        elseif lmargin != lstats
            warn("STATS is recycled to match the extend of dimension $(sz[MARGIN])")
            STATS=reshape(rep(vec(STATS), times=div(lmargin, lstats)), (sz[MARGIN]...))
        end
    end
    dimorder=seq_along(sz)
    pe = [MARGIN, setdiff(dimorder, MARGIN);]
    outer = sz[pe]
    outer[1:length(MARGIN)]=1
    xstat=Compat.repeat(STATS, outer=outer)
    xstat=permutedims(xstat, (sortperm(pe)...))
    FUN(x, xstat; kwargs...)
end

function sweep(x::AbstractArray, MARGIN::Integer, STATS::AbstractArray, FUN::Function=.-; kwargs...)
    sweep(x, [MARGIN], STATS, FUN; kwargs...)
end
sweep(x::AbstractArray, MARGIN::Tuple, STATS::AbstractArray, FUN::Function=.-; kwargs...)=sweep(x, [MARGIN...], STATS, FUN; kwargs...)
