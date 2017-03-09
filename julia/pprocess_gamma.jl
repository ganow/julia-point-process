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

    #Initialize parameters

    x = [0.0]; # push!(x, num)
    rs = zeros(L);

    P = 0; R = 0;

    rs[1] = lambda;

    eta = - log(rand());
    for i = 2:L
        tau = i*dt - x[end]

        p = 1.0 / gamma(k) * (k * lambda).^k * tau.^(k-1) .* exp(-k*lambda*tau); # ISI
        P = P + p*dt;

        r = p / (1.0 - P); # Intensity
        R = R + r*dt;

        if eta <= R
            push!(x,i*dt) # Spike time

            P = 0.0; R = 0.0;
            eta = - log(rand());
        end
        rs[i] = r;
    end

    return x, rs
end

