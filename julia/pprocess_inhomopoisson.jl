include("./params.jl")

function pprocess_inhomopoisson(lambda)
    # Example usage:
    # L = 100000;
    # ts = linspace(0, 10, L);
    # f = 1.0;
    # lambda = 20*(1+sin(2.0 * pi * f * ts));
    # x, rs = pprocess_inhomopoisson(lambda)
    #
    # Input argument
    # lambda: A vector that specifies a time-dependent spike-rate.
    #
    # Output argument
    # x:    Spike time.
    # rs:   Intensity function.

    #Initialize parameters

    x = [0.0]; # push!(x, num)
    rs = zeros(L);

    R = 0;

    rs[1] = lambda[1];

    eta = - log(rand());
    for i = 2:L
        tau = i*dt - x[end]

        r = lambda[i]; # Intensity
        R = R + r*dt;

        if eta <= R
            push!(x,i*dt) # Spike time

            R = 0.0;
            eta = - log(rand());
        end
        rs[i] = r;
    end

    return x, rs
end
