load alldata
figure;
clf;
% [odp,dpo]=sort(-mean(metadp,2));
[odp,dpo]=sort(-metadp(:,1));
subplot(2,4,1);
plot(metadp(dpo,:),'linewidth',2);
axis square
set(gca,'fontsize',12);

subplot(2,4,5);
cols=['b' 'r' 'y'];
hold all;
for i=1:3
    plot(squeeze(metai(dpo,i,2)));
    plot(squeeze(metai(dpo,i,1)));
    p(i)=patch([1:20 fliplr(1:20)],[squeeze(metai(dpo,i,2))' fliplr(squeeze(metai(dpo,i,1))')],cols(i));
    plot(squeeze(metai(dpo,i,2)),'c','linewidth',1);
    plot(squeeze(metai(dpo,i,1)),'m','linewidth',1);
end
p(3).FaceColor=[1 .7 0];
axis square;
box on;
set(gca,'fontsize',12);

% [odp,dpo]=sort(-mean(metamr,2));
[odp,dpo]=sort(-metamr(:,1));
subplot(2,4,2);
plot(metamr(dpo,:),'linewidth',2);
axis square;
set(gca,'fontsize',12);
l=legend('1','2','3');
l.Location='northeast';
l.Title.String='cond';
l.FontSize=9;
l.Title.FontSize=9;
l.ItemTokenSize=[10 10];

subplot(2,4,3);
dps=0.1:.01:4.0;
yyaxis right;
plot(dps,midpm(dps),'g');
%ylabel('meta-I(d'')');
set(gca,'ylim',[0 0.2],'ytick',[0 0.2]);
yyaxis left
plot(dps,ent(normcdf(1,0,2./dps)),'k');
%ylabel('H_2(r)');
%xlabel('d''');
set(gca,'fontsize',12);
ax=gca;
ax.YAxis(1).Color=[0 0 0];
ax.YAxis(2).Color=[0 1 0];
axis square;
%set(gca,'view',[90 90]);

subplot(2,4,6);
cols=['b' 'r' 'y'];
hold all;
for i=1:3
    plot(squeeze(metair1(dpo,i,2)));
    plot(squeeze(metair1(dpo,i,1)));
    p(i)=patch([1:20 fliplr(1:20)],[squeeze(metair1(dpo,i,2))' fliplr(squeeze(metair1(dpo,i,1))')],cols(i));
    plot(squeeze(metair1(dpo,i,2)),'c','linewidth',1);
    plot(squeeze(metair1(dpo,i,1)),'m','linewidth',1);
end
p(3).FaceColor=[1 .7 0];
set(gca,'ytick',[0 1 2]);
axis square;
box on;
set(gca,'fontsize',12);
%xlabel('subject');

subplot(2,4,7);
cols=['b' 'r' 'y'];
hold all;
for i=1:3
    plot(squeeze(metair2(dpo,i,2)));
    plot(squeeze(metair2(dpo,i,1)));
    p(i)=patch([1:20 fliplr(1:20)],[squeeze(metair2(dpo,i,2))' fliplr(squeeze(metair2(dpo,i,1))')],cols(i));
    plot(squeeze(metair2(dpo,i,2)),'c','linewidth',1);
    plot(squeeze(metair2(dpo,i,1)),'m','linewidth',1);
end
p(3).FaceColor=[1 .7 0];
axis square;
box on;
set(gca,'fontsize',12);

load fulldata
subplot(2,4,4);
plot(metamr(dpo,:),squeeze(nmetair1(dpo,:,2)),'c.');
hold on;
plot(metamr(dpo,:),squeeze(nmetair1(dpo,:,1)),'m.');
for i=1:size(metadp,1)
    for c=1:size(metadp,2)
        plot(metamr(i,c)*[1 1],[metair1(i,c,1)*1.01 nmetair1(i,c,2)*0.99],'k');
    end
end
axis square;
set(gca,'xlim',[0 1.5],'ylim',[0 2.5],'ytick',[0 1 2]);
set(gca,'fontsize',12);
plot(.25,2,'c.','markersize',10);
plot(.25,1.7,'m.','markersize',10);

load fulldata
subplot(2,4,8)
ratios=nmetai./nmetai(:,:,1);
mratios=squeeze(mean(ratios,1));
plot(mratios(:,1:9)','linewidth',2);
axis square
%xlabel('bins');
%ylabel('ratio');
set(gca,'xlim',[1 9],'ylim',[1 2],'fontsize',12,'xtick',[1 5 9],'xticklabel',[2 6 10]);
l=legend('1','2','3');
l.Location='northwest';
l.Title.String='cond';
l.FontSize=9;
l.Title.FontSize=9;
l.ItemTokenSize=[10 10];


set(gcf,'Position',[126.6000 323.4000 1.1992e+03 471.2000],'PaperPositionMode','auto')
print -depsc ../fig2
	
