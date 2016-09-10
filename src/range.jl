datarange{T<:AbstractFloat}(x::AbstractArray{T})=extrema(x)
#What is the right range for integer?
datarange{T<:Integer}(x::AbstractArray{T})=unique(x)
datarange{T<:Bool}(x::AbstractArray{T})=unique(x)
datarange{T<:Dates.TimeType}(x::AbstractArray{T})=extrema(x)
datarange{T<:AbstractString}(x::AbstractArray{T})=unique(x)
datarange(x::DataArray)=datarange(x.data)
datarange(x::PooledDataArray)=x.pool
