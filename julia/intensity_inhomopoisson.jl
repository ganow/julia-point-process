include("./params.jl")
include("./utils.jl")

function intensity_inhomopoisson(data, w)
    # Example usage:
    # x = 0.5-0.5*log(rand(1,1e3));
    # w = 0.001;
    # rs = intensity_inhomopoisson(x, w);
    #
    # Input argument
    # data: Spike-rate.
    # w:    Bandwidth for radial basis function
    #
    # Output argument
    # rs:   Estimated intensity function

    density(ts) = [mean(gauss(t - data, w)) for t in ts];
    rs = density(ts) * length(data);

    rs
end

