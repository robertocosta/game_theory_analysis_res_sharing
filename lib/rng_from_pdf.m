function [ realization ] = rng_from_pdf( pdf, n )
%RNG_FROM_PDF( pdf, n ) gives n realizations of a r.v. with specified pdf
    cdf = cumsum(pdf);
    [y, x] = unique(cdf);
    realization = interp1([0;y],[0; x]+0.5,rand(1,n));
end