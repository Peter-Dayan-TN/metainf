function mi=emp(nR_S1,nR_S2)
nr=length(nR_S1)/2;
total=sum(nR_S1+nR_S2);
tacc=sum(nR_S1(1:nr)+nR_S2(nr+(1:nr)))/total;      % accurate according to generated pos/neg
mi=ent(tacc);
pacc=zeros(1,nr);
rprb=zeros(1,nr);
for i=1:nr
    rprb(i)=(nR_S1(i)+nR_S2(2*nr+1-i)+nR_S2(i)+nR_S1(2*nr+1-i))/total;
    pacc(i)=(nR_S1(i)+nR_S2(2*nr+1-i))/(rprb(i)*total);
    if (rprb(i)*total>20)
       mi = mi - rprb(i)*ent(pacc(i));
    else
       mi = mi - rprb(i)*betaent(pacc(i)*rprb(i)*total+5,(1-pacc(i))*rprb(i)*total+51);
    end
end
