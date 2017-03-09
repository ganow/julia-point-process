include("./params.jl")

function pprocess_gamma(lambda,k)
    # Example usage:
    # lambda = 20.0; # Spike-rate (Hz).
    # k = 2.3;       # Shape parameter.
    # x, rs = pprocess_gamma(lambda, k)
    #
    # Input argument
    # y:    Spike-rate.
    # k:    The shape parameter of the ISI distribution.
    #       * To use small k << 1, use small sampling time dt.
    #       * Maximum k allowed is ~10.
    #
    # Output argument
    # x:    Spike time.
    # rs:   Intensity function.

    ################# WRITE SOMETHING #################

    return x, rs
end

