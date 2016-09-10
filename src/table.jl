"""
    as_string(x)

Convert any array `x` into a `String` Matrix.
"""
function as_string(x)
    sprint(showcompact, x)
end
function as_string(x::AbstractArray)
    #broadcast(as_string, x)
    [sprint(showcompact, ix) for ix in x]
end

"""
    FreqVector(freq, names)

A type `FreqVector` is to show keys and freqeuncies together for a frequency table.
"""
type FreqVector
    freq::IntegerVector
    names::Vector{AbstractString}
    function FreqVector(freq, names)
        if length(freq) != length(names)
            throw(DimensionMismatch("vector lengths must match"))
        end
        new(freq, names)
    end
end
function show(io::IO, x::FreqVector)
    freq = x.freq; names = x.names;
    nr = length(freq)

    rnwidth = max(4,maximum([length(nm) for nm in names]) + 1)
    rownms = [rpad(nm,rnwidth) for nm in names]
    width = 4
    str = [sprint(showcompact,freq[i]) for i in 1:nr]

    for i in 1:nr
        li = length(str[i])
        if li > width
            width = li
        end
    end
    width += 1
    print(io, rpad("Keys", rnwidth)*lpad("Freq", width))
    println(io)
    for i = 1:nr
        print(io, rownms[i])
        print(io, lpad(str[i],width))
        println(io)
    end
end

"""
    FreqMatrix(freq, rownames, colnames)

A FreqMatrix is to show cross frequency table.
"""
type FreqMatrix
    freq::IntegerMatrix
    rownames::Vector{AbstractString}
    colnames::Vector{AbstractString}
    function FreqMatrix(freq, rownames, colnames)
        n, p = size(freq)
        if n != length(rownames) || p != length(colnames)
            throw(DimensionMismatch("vector lengths must match"))
        end
        new(freq, rownames, colnames)
    end
end

function show(io::IO, x::FreqMatrix)
    freq = x.freq; rownms = x.rownames; colnms = x.colnames;
    nr, nc = size(freq)
    if length(rownms) == 0
        rownms = [lpad("[$i]",floor(Integer, log10(nr))+3) for i in 1:nr]
    end
    rnwidth = max(4,maximum([length(nm) for nm in rownms]) + 1)
    rownms = [rpad(nm,rnwidth) for nm in rownms]
    widths = [length(cn)::Int for cn in colnms]
    str = String[sprint(showcompact,freq[i,j]) for i in 1:nr, j in 1:nc]
    for j in 1:nc
     for i in 1:nr
         lij = length(str[i,j])
         if lij > widths[j]
             widths[j] = lij
         end
     end
    end
    widths .+= 1
    println(io," " ^ rnwidth *
         join([lpad(string(colnms[i]), widths[i]) for i = 1:nc], ""))
    for i = 1:nr
     print(io, rownms[i])
     for j in 1:nc
         print(io, lpad(str[i,j],widths[j]))
     end
     println(io)
    end
end

"""
    table(x)

Show the counts of `x`.
"""
function table{T}(x::AbstractArray{T})
    res=StatsBase.countmap(x)
    names=collect(keys(res))

    FreqVector(collect(values(res)), as_string(names))
end

"""
    table(x, y)

Show the cross counts of `x` and `y`.
"""
function table{T,S}(x::AbstractArray{T}, y::AbstractArray{S})
    xf=DataFrames.pool(x)
    yf=DataFrames.pool(y)
    res=StatsBase.counts(xf.refs, yf.refs)
    FreqMatrix(res, as_string(xf.pool), as_string(yf.pool))
end
