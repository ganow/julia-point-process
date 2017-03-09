include("./params.jl")

function fitgamma(isi)

    epsilon = 1e-6;

    n = length(isi);
    T = sum(isi);

    lambda = n / T;

    alpha = 0.2
    beta = 1.0

    eta = 0.001

    dll_dalpha = epsilon * 10
    dll_dbeta = epsilon * 10

    while max(abs(dll_dalpha), abs(dll_dbeta)) > epsilon

        dll_dalpha = - n / alpha + n * log(beta) + sum(log(isi)) - n * digamma(alpha);
        dll_dbeta = n * (1+alpha) / beta - T;

        alpha = alpha + eta*dll_dalpha;
        beta = beta + eta*dll_dbeta;

    end

    k = alpha + 1
    lambda = beta / k

    lambda, k

end
