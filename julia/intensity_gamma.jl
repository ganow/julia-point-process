include("./params.jl")
include("./fitgamma.jl")

function intensity_gamma(data)
    # Example usage:
    # x = 0.5-0.5*log(rand(1,1e3));
    # rs = intensity_gamma(x);
    #
    # Input argument
    # data: Spike-rate.
    #
    # Output argument
    # rs:   Estimated intensity function

    isi = data[2:end] - data[1:end-1]
    lambda, k = fitgamma(isi)

    Nspike = length(data)

    P = 0;
    prev_flg = 0;
    rs = zeros(L)
    for i=1:L

        if prev_flg == 0
            tau = i*dt
        else
            tau = i*dt - data[prev_flg]
        end

        p = 1.0 / gamma(k) * (k * lambda).^k * tau.^(k-1) .* exp(-k*lambda*tau); # ISI
        P = P + p*dt;

        rs[i] = p / (1.0 - P); # Intensity

        if prev_flg+1 < Nspike && data[prev_flg+1] <= i*dt

            P = 0;
            prev_flg += 1;

        end

    end

    rs
end
