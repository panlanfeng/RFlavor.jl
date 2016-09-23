function recyletimes(long::Integer, short::Integer)
    if short == 1
        return long
    elseif short == long
        return 1
    else
        throw(DimensionMismatch("Dimension Mismatch and the size of the short one is not 1!"))
    end
end

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
function sweep(x::AbstractArray, MARGIN::Union{AbstractVector, Integer}, STATS::AbstractArray, FUN::Function=.-; kwargs...)
    sz = size(x)
    dimmargin = sz[MARGIN]
    dimstats = size(STATS)
    if length(dimstats) == length(sz)
        outertimes = Int[recyletimes(sz[i], dimstats[i]) for i in 1:length(dimstats)]
    elseif length(dimstats) <= length(dimmargin)
        outertimes = collect(sz)
        for i in 1:length(dimstats)
            outertimes[MARGIN[i]] = recyletimes(dimmargin[i], dimstats[i])
        end
    else
        throw(DimensionMismatch("Dimension of STATS should match the MARGIN dimension $(dimmargin)"))
    end
    xstat = repeat(STATS, outer=outertimes)
    return FUN(x, xstat; kwargs...)
end

sweep(x::AbstractArray, MARGIN::Union{AbstractVector, Integer}, STATS::Real, FUN::Function=.-; kwargs...)=sweep(x, MARGIN, [STATS], FUN; kwargs...)

sweep(x::AbstractArray, MARGIN::Tuple, STATS::Union{AbstractArray, Real}, FUN::Function=.-; kwargs...)=sweep(x, [MARGIN...], STATS, FUN; kwargs...)
