load new_all_data;

clf;
dprimes1=0.5:0.1:5;
ndprimes1=length(dprimes1);
perrs=zeros(1,ndprimes1);
mis1=perrs;
for i=1:ndprimes1
    [perrs(i),mis1(i)]=hhypo(dprimes1(i));
end

mult=sqrt(gamma2s(1));
for i=1:nbetas
    subplot(3,nbetas,i);
    plot(dprimes1,ent(perrs)-2*perrs,'c','linewidth',2);
    hold on;
    plot(dprimes1,mis1,'g','linewidth',2);
%    xlabel('d''');
    if (i==1)
     %ylabel('meta-I');
    end
    if (i==3)
        lgd=legend('mixture','normal','location','northeast');
        lgd.ItemTokenSize=[10;10];
    end
    for j=1:ndprimes
        plot(dprimes(j)*[1 1],[0 mis(end,j,nbetas+1-i,1)],'k','HandleVisibility','off');
        for k=[1 3 5 7 9]
            plot(dprimes(j),squeeze(mis(end,j,nbetas+1-i,k)),'.','color',0.5*[1 0 1]+0.5*(1/sqrt(gamma2s(k)))*mult*[1 0 1],'markersize',20,'HandleVisibility','off');
        end
    end
    for k=[1 3 5 7 9]
        plot(dprimes,squeeze(mis(end,:,nbetas+1-i,k)),'k:','HandleVisibility','off');
    end
    %title(['B = ' num2str(sqrt(beta2s(nbetas+1-i)))]);
    axis square
    set(gca,'xtick',[0 4 8],'ytick',[0 0.5 1]);
end

mult=sqrt(gamma2s(1));
enters=ent(normcdf(1,0,2./dprimes(:)))';
enters=midpm(dprimes);
for i=1:nbetas
    subplot(3,nbetas,3+i);
    plot(dprimes1,log((ent(perrs)-2*perrs)./midpm(dprimes1)),'c','linewidth',2);
    hold on;
    plot(dprimes1,log(mis1./midpm(dprimes1)),'g','linewidth',2);
%    xlabel('d''');
    if (i==1)
     %ylabel('log meta-I-ratio');
    end
    %legend('mixture','normal');
    for j=1:ndprimes
        enter=midp(dprimes(j));
        plot(dprimes(j)*[1 1],[0 log(mis(end,j,nbetas+1-i,1)/enter)],'k','HandleVisibility','off');
        for k=[1 3 5 7 9]            plot(dprimes(j),log(squeeze(mis(end,j,nbetas+1-i,k)./enter)),'.','color',0.5*[1 0 1]+0.5*(1/sqrt(gamma2s(k)))*mult*[1 0 1],'markersize',20,'HandleVisibility','off');
        end
    end
    for k=[1 3 5 7 9]
        plot(dprimes,log(squeeze(mis(end,:,nbetas+1-i,k))./enters),'k:','HandleVisibility','off');
    end
%    title(['B = ' num2str(sqrt(beta2s(nbetas+1-i)))]);
    set(gca,'ylim',[-4 5],'xtick',[0 4 8]);
    axis square
end

mult=sqrt(gamma2s(1));
enters=ent(normcdf(1,0,2./dprimes(:)))';
for i=1:nbetas
    subplot(3,nbetas,6+i);
    plot(dprimes1,log((ent(perrs)-2*perrs)./ent(perrs)),'c','linewidth',2);
    hold on;
    plot(dprimes1,log(mis1./ent(perrs)),'g','linewidth',2);
    %xlabel('d''');
    if (i==1)
       % ylabel('log meta-I-ratio_2');
    end
    %legend('mixture','normal');
    for j=1:ndprimes
        enter=enters(j);
        plot(dprimes(j)*[1 1],[0 log(mis(end,j,nbetas+1-i,1)/enter)],'k','HandleVisibility','off');
        for k=[1 3 5 7 9]            plot(dprimes(j),log(squeeze(mis(end,j,nbetas+1-i,k)./enter)),'.','color',0.5*[1 0 1]+0.5*(1/sqrt(gamma2s(k)))*mult*[1 0 1],'markersize',20,'HandleVisibility','off');
        end
    end
    for k=[1 3 5 7 9]
        plot(dprimes,log(squeeze(mis(end,:,nbetas+1-i,k))./enters),'k:','HandleVisibility','off');
    end
%    title(['B = ' num2str(sqrt(beta2s(nbetas+1-i)))]);
    set(gca,'ylim',[-4.5 0.5],'xtick',[0 4 8]);
    axis square
    if (i==1)
        for k=[1 3 5 7 9]
            text(4.5,log(squeeze(mis(end,end,nbetas+1-i,k))./enters(end)),sprintf('%4.1f',gamma2s(k)));
        end
        %text(6.5,-1.6,'G^2');
    end
end

set(gcf,'Position',[680 414 784 668]);

print -depsc ../fig7

