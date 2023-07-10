function hent=ent(p)
hent = -p.*log(p+1e-20) - (1-p) .* log(1-p + 1e-20);
hent=hent/log(2);
