load new_all_data;
clf
for i=1:ndprimes
    subplot(1,ndprimes,i);
    midiff=squeeze(mis(2:4,i,1,:))./squeeze(mis(1,i,1,:))';
    imagesc(1:3,log(gamma2s(end:-1:1))/log(10),midiff(:,:)',[1 1.5]);
    c=colorbar;
    c.Ticks=[1 1.25 1.5];
    %xlabel('log_1_0 G^2');
    if (i==1)
        %ylabel('ratio of meta-$$\mathcal{I}$$s','interpreter','latex');
    end
    set(gca,'xtick',1:3,'xticklabel',{'4/2' ; '8/2' ; '16/2' });
    set(gca,'ytick',-1:1,'yticklabel',[' 1' ; ' 0' ; '-1']);
    %title(['$$d''$$ = ' num2str(dprimes(i))],'interpreter','latex');
    axis square
    set(gca,'fontsize',13);
end
set(gcf,'paperpositionmode','auto');
set(gcf,'Position',[207 462 1265 201]);
print -depsc ../fig6
