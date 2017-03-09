#!/usr/bin/env julia

@printf "Make data/spikes.csv...\n"
include("julia/pprocess_gamma.jl")
x_gamma, rs_gamma = pprocess_gamma(15.0, 3.5);
writecsv("data/spikes.csv", x_gamma)

@printf "Make data/firing_rate_[true|estimated].csv...\n"
# データとモデルで両方作る．
# データはx_gamma使う．モデルはssgamma使う
include("julia/intensity_gamma.jl")
rs_mle_gamma = intensity_gamma(x_gamma);
writecsv("data/firing_rate_true.csv", rs_gamma);
writecsv("data/firing_rate_estimated.csv", rs_mle_gamma);
