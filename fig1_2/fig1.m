load alldata;
figure;
clf;
addpath('helperFunctions','Mfunctions','Violinplot-Matlab-master');
lent=zeros(20,3);
iind=1:20;
nn=zeros(20,3,2);
for cond=1:3
    len(cond)=0;
    d=cell(2,1);
    med=zeros(20,1);
    for subject=1:20
        datamat{cond,1,subject}=subjdata(subject,cond).conf_cont(subjdata(subject,cond).correct==1)';
        nn(subject,cond,1)=length(datamat{cond,1,subject});
        datamat{cond,2,subject}=subjdata(subject,cond).conf_cont(subjdata(subject,cond).correct==0)';
        nn(subject,cond,2)=length(datamat{cond,2,subject});
        len(cond)=max(len(cond),max(length(datamat{cond,1,subject}),length(datamat{cond,2,subject})));
%         med(subject)=median(subjdata(subject,cond).conf_cont);
        med(subject)=median(datamat{cond,1,subject});
    end
end
subjects=[5 1 18];nsubjects=length(subjects);
for isubject=1:nsubjects
    subject=subjects(isubject);
    d{1}=NaN*zeros(len(cond),3);
    d{2}=NaN*zeros(len(cond),3);
    for cond=1:3
        subject=subjects(isubject);
        d{1}(1:length(datamat{cond,1,subject}),cond)=datamat{cond,1,subject};
        d{2}(1:length(datamat{cond,2,subject}),cond)=datamat{cond,2,subject};
    end
    subplot(nsubjects,1,isubject);
    v=violinplot(d);
    for cond=1:3
%         v(isubject).ViolinAlpha{1}=nn(iind(subject),cond,1)/sum(nn(iind(subject),cond,:));
%         v(isubject).ViolinAlpha{2}=nn(iind(subject),cond,2)/sum(nn(iind(subject),cond,:));
        v(cond).ViolinAlpha{1}=1;
        v(cond).ViolinAlpha{2}=1;
        v(cond).ViolinColor{1}=[0 1 0];
        v(cond).ViolinColor{2}=[1 0 0];
        v(cond).ShowData=0;
        v(cond).ShowMedian=0;
        v(cond).ShowBox=0;
        q=t2(subject,cond,1).quants;
        q1=q{1}(2);
        q2=q{2}(2:3);
        plot(cond*[1 1],q2,'k','linewidth',2);
        plot([cond-.25 cond+.25],q1*[1 1],'m','linewidth',1);
        plot([cond cond],q2(1)*[1 1],'kv','linewidth',1,'markersize',12);
        plot([cond cond],q2(2)*[1 1],'k^','linewidth',1,'markersize',12);
    end
    set(gca,'xlim',[0 3+1],'xtick',1:3,'ylim',[.49 1.01],'ytick',[.5 .75 1],'fontsize',16);
    title(['subject: ' num2str(subject)]);
    ylabel('confidence rating');
    if (isubject==3)
        xlabel('condition');
    end
end
load fulldata
for is=1:nsubjects
    sub=subjects(is);
    fprintf('%2d ',subjects(is));
    for c=1:3
        fprintf('&%1d&%3.1f&%3.1f&%3.1f&%5.3f&%5.3f&%5.3f&%5.3f&%5.3f&%5.3f\\\\\\hline\n',...
           c,t2(sub,c,2).da,t2(sub,c,2).meta_da,t2(sub,c,2).M_ratio,...
           t2(sub,c,2).metai(1), t2(sub,c,2).metai(2),nt2(sub,c,2).metai(9),...
           t2(sub,c,2).metair1(1), t2(sub,c,2).metair1(2),nt2(sub,c,2).metair1(9));
    end
end
set(gcf,'Position',[111.4000 80.2000 1.2032e+03 733.6000],'PaperPositionMode','auto');
print -depsc ../fig1

