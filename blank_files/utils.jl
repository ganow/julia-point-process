function gauss(x, w)
    1/sqrt(2.0*pi)./w.*exp(-x.^2/2.0./w.^2)
end
