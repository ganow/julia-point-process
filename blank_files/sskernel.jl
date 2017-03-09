include("./params.jl")
include("./utils.jl")

function compute_optimal_bw{T<:Real}(C::Function, ws::AbstractArray{T,1})::T

    ################# WRITE SOMETHING #################

    return wopt

end

function get_costfunc(data)
    # Cost function

    return C
end

function sskernel(data; ws=nothing)
    # Example usage:
    # x = 0.5-0.5*log(rand(1,1e3));
    # ws = linspace(0.0001, 1.0, 100);
    # rs = sskernel(x, ws=ws); # or simply sskernel(x)
    #
    # Input argument
    # data: Spike-rate.
    # w:    Bandwidth for radial basis function
    #
    # Output argument
    # rs:   Estimated intensity function

    ################# WRITE SOMETHING #################

    return rs
end
