using Plots
plotlyjs();

include("../julia/fitgamma.jl");
include("../julia/utils.jl");

x_true = readcsv("../data/spikes.csv")[:];
isi = diff(x_true);

lambda, k = fitgamma(isi);

@printf "Estimated parameters:\n"
@printf "lambda: %.4f, k: %.4f\n" lambda k
