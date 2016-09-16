typealias Factor PooledDataArray

function factor(x::AbstractVector; kwargs...)
    kwdict=Dict(kwargs)
    levels = get(kwdict, :levels, myunique(x))
    if haskey(kwdict, :exclude)
        exclude = get(kwdict, :exclude, [])
        levels = setdiff(levels, exclude)
    end

    res = PooledDataArray(x, levels)
    if haskey(kwdict, :labels)
        labels = get(kwdict, :labels, levels)
        res=setlevels(res, labels)
    end
    res
end
