function mi=midpm(dp)
mi=dp;
for i=1:length(dp(:))
    mi(i)=midp(dp(i));
end
