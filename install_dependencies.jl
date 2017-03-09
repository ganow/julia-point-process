#!/usr/bin/env julia

packages = [
    "Plots",
    "PyPlot",
    "PlotlyJS",
    "IJulia"
]

Pkg.update()

for p in packages
    @printf "... Install %s\n" p
    Pkg.add(p)
end

withenv("PYTHON" => "") do
    Pkg.build("PyPlot")
    Pkg.build("PlotlyJS")
end

try
    @printf "... Install AtomShell\n"
    using Blink
    Blink.AtomShell.install()
catch e
    @printf "Install failed: AtomShell\n"
    rethrow(e)
end
