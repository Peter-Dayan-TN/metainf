load new_all_data;
betab=2;
clf;
subplot(2,3,1);
imagesc(1:4,log(gamma2s)/log(10),squeeze(metads(2,:,betab,end:-1:1))')
c=colorbar;
set(gca,'ColorScale','log')
%title('meta-d''');
%xlabel('log_1_0 G^2');
%ylabel('log_1_0 G^2');
set(gca,'xtick',1:4,'xticklabel',['0.5' ; '1.0' ; '2.0' ; '4.0']);
set(gca,'ytick',-1:1,'yticklabel',[' 1' ; ' 0' ; '-1']);
axis square

subplot(2,3,4);
imagesc(1:4,log(gamma2s)/log(10),squeeze(mis(2,:,betab,end:-1:1))')
c=colorbar;
set(gca,'ColorScale','log');
c.Ticks=[.1 .4 .8];
%title('meta-I');
%ylabel('log_1_0 G^2');
%xlabel('d''');
set(gca,'xtick',1:4,'xticklabel',['0.5' ; '1.0' ; '2.0' ; '4.0']);
set(gca,'ytick',-1:1,'yticklabel',[' 1' ; ' 0' ; '-1']);
axis square

subplot(2,3,5);
imagesc(1:4,log(gamma2s)/log(10),(squeeze(mis(2,:,betab,end:-1:1))./midpm(dprimes)')');
c=colorbar;
set(gca,'ColorScale','log')
c.Ticks=[1 20 40];
%t=title('meta-I-ratio');
%set(t,'color','b');
%xlabel('d''');
set(gca,'xtick',1:4,'xticklabel',['0.5' ; '1.0' ; '2.0' ; '4.0']);
set(gca,'ytick',-1:1,'yticklabel',[' 1' ; ' 0' ; '-1']);
axis square

subplot(2,3,2);
imagesc(1:4,log(gamma2s)/log(10),(squeeze(metads(2,:,betab,end:-1:1))./dprimes')');
c=colorbar;
set(gca,'ColorScale','log')
c.Ticks=[1 8 16];
%title('M-ratio');
%xlabel('log_1_0 G^2');
%ylabel('d''');
set(gca,'xtick',1:4,'xticklabel',['0.5' ; '1.0' ; '2.0' ; '4.0']);
set(gca,'ytick',-1:1,'yticklabel',[' 1' ; ' 0' ; '-1']);
axis square

subplot(2,3,6);
imagesc(1:4,log(gamma2s)/log(10),(squeeze(mis(2,:,betab,end:-1:1))./ent(normcdf(1,0,2./dprimes')))');
c=colorbar;
c.Ticks=[.1 .4 .8];
%t=title('meta-I-ratio_2');
%set(t,'color','r');
%xlabel('log_1_0 G^2');
%xlabel('d''');
set(gca,'xtick',1:4,'xticklabel',['0.5' ; '1.0' ; '2.0' ; '4.0']);
set(gca,'ytick',-1:1,'yticklabel',[' 1' ; ' 0' ; '-1']);
axis square


set(gcf,'Position',[78.6000 502.6000 643.2000 331.2000]);

print -depsc ../fig5
