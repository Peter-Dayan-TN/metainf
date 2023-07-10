function ent=betaent(a,b)
ent=a*(harmonic(a)-harmonic(a+b));
ent=ent+b*(harmonic(b)-harmonic(a+b));
ent=-ent/(a+b)/log(2);
