
"""
# Description
‘duplicated()’ determines which elements of a vector or data frame
are duplicates of elements with smaller subscripts, and returns a
logical vector indicating which elements (rows) are duplicates.

# Arguments
* `x`: a vector or a data frame
        
Example:
duplicated([1,2,2,3,4,1])
duplicated(['a', 'b', 'c', 'c', 'd'])
x=[1 2; 2 3; 1 2; 3 4; 1 2]
duplicated(x)
df = DataFrame(x=[1,2,1,2,3], y =[2,1,2,1,2])
duplicated(df)
"""

function duplicated(x::Vector)
    n = length(x)
    if n > 1
        out = similar(x, Bool)
        seen = Set{eltype(x)}()
        @inbounds for i in 1:n
            if !in(x[i], seen)
                push!(seen, x[i])
                out[i] = false
            else
                out[i] = true
            end
        end
        return out
    else
        return false
    end
end

function duplicated(x::Matrix)
    n = size(x, 1)
    if n > 1
        out = similar(x, Bool, n)
        seen = Set{typeof(x[1,:])}()
        @inbounds for i in 1:n
            if !in(x[i, :], seen)
                push!(seen, x[i, :])
                out[i] = false
            else
                out[i] = true
            end
        end
        return out
    else
        return false
    end
end

function duplicated(x::DataFrame)
    duplicated(convert(Array, x))
end
