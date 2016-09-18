"""
    lapply(d, f, args...; kwargs)

Apply a function on List `d`. `args` and `kwargs` will be passed to `f`.

#Example
```
d=as_list(Any[rand(i) for i in 1:10])
lapply(d, mean)
```
"""
function lapply(d::AbstractList, f::Function, args...; kwargs...)
    map(x->f(x, args...; kwargs...), d)
end


"""
    sapply(d, f, args...; kwargs)

A user-friendly version and wrapper of `lapply` by default returning an array.

#Example

```
x = list(a=1:10, beta=exp(-3:3), logic = [true,false, false, true])
y = list(a = 1:5, b = log(1:5), c = rand(5))
z = list(a = ["a", "b", "c"], b = ["d", "e", "f"])
sapply(x, mean)
sapply(y, x->outer(x, x))
sapply(z, x->outer(x, x))
```
"""
function sapply(d::AbstractList, f::Function, args...;simplify = true, kwargs...)
    l = lapply(d, f, args...; kwargs...)
    if simplify && length(l) > 0
        n = length(l)
        ## chceck whether types of all list elements are the same or not
        tp = lapply(l, typeof)
        for i in 2:n
            is(tp[1], tp[i]) || return l
        end
        ## check whether lengths of all list elements are the same or not
        len = lapply(l, length)
        for i in 2:n
            is(len[1], len[i]) || return l
        end
        ## if type and length are the same for all the list elements, convert to array
        list_el_size = size(l[1])
        list_el_len = prod(list_el_size)
        list_el_len > 1 || return unlist(l)
        v = Array(eltype(l[1]), list_el_len*n)
        for i in 1:n
            v[(list_el_len*(i-1) +1):list_el_len*i] = l[i][:]
        end
        return reshape(v, list_el_size..., n)
    else
        return l
    end
end
