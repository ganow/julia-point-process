include("./params.jl")
include("./utils.jl")

function compute_optimal_bw{T<:Real}(C::Function, ws::AbstractArray{T,1})::T

    # Select the optimal bandwidth
    cs = C.(ws);
    cmin, idx = findmin(cs);
    wopt = ws[idx];
    wopt

end

function get_costfunc(data)
    # Cost function
    C(w) = sum(
        [
            sum(gauss(x-data,sqrt(2)*w)) - 2.0*sum(gauss(x-data,w)) + 2.0*gauss(0,w) for x in data
        ]
    );
    C
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

    # Bandwidths searched
    if typeof(ws) == Void
        ws = linspace(minimum(diff(data)) / 5.0, maximum(data), 300)
    end

    # Cost function
    C = get_costfunc(data);

    # Optimal bandwidth
    w = compute_optimal_bw(C, ws);

    density(ts) = [mean(gauss(t - data, w)) for t in ts];
    rs = density(ts) * length(data);

    rs
end
