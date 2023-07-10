% didactic example of the second order actor/rater
% with different quantile bins (.1, .5 .9)
% refer to fourdrun.m

x=-10:.01:10;               % even spacing
ym=normpdf(x,-1,alpha);
yp=normpdf(x,+1,alpha);
mpc=normcdf(1,0,alpha);

clf;
subplot(3,3,1);
plot(x,ym,'r','linewidth',2);
hold on;
plot(x,yp,'g','linewidth',2);
set(gca,'ylim',[0 0.6]);
plot([0 0],[0 1],'k');
axis square
%title(sprintf('actor: P(corr)=%3.1f',mpc),'fontsize',14);

subplot(3,3,2);
plot(x,normpdf(x,0,beta),'m','linewidth',2);
set(gca,'ylim',[0 0.6]);
axis square
%title('rater: noise','fontsize',14);

subplot(3,3,3);
plot(x,normpdf(x,-1,gamma),'r--','linewidth',2);
hold on;
plot(x,normpdf(x,+1,gamma),'g--','linewidth',2);
set(gca,'ylim',[0 0.6]);
axis square
%title('rater: unique','fontsize',14);

[b,c]=ndgrid(x,x);
del2=1/alpha2 + 1/beta2;

psu=0.5*normpdf(c,1,sqrt(gamma2)).*exp(-(b-1).^2/(2*(alpha2+beta2))).*normcdf(-(b/beta2+1/alpha2)/del2,0,sqrt(1/del2))/sqrt(2*pi*(alpha2+beta2));
psu=psu+0.5*normpdf(c,-1,sqrt(gamma2)).*exp(-(b+1).^2/(2*(alpha2+beta2))).*normcdf(-(b/beta2-1/alpha2)/del2,0,sqrt(1/del2))/sqrt(2*pi*(alpha2+beta2));
psu0=psu./(0.5*normcdf(1,0,sqrt(alpha2))+0.5*normcdf(-1,0,sqrt(alpha2))+1e-200);

subplot(3,3,4);
pcolor(x,x,psu0(:,:));   % don't worry about the measure - or normalization - for -1
                         % P(beta,gamma|a=-1)
shading flat;
hold on;
axis square
xlabel('\gamma','fontsize',16);
ylabel('\beta','fontsize',16);
%t=title('P(\beta,\gamma|a=-1)');
%set(t,'color','r','fontsize',14);

psu=0.5*normpdf(c,1,sqrt(gamma2)).*exp(-(b-1).^2/(2*(alpha2+beta2))).*normcdf((b/beta2+1/alpha2)/del2,0,sqrt(1/del2))/sqrt(2*pi*(alpha2+beta2));
psu=psu+0.5*normpdf(c,-1,sqrt(gamma2)).*exp(-(b+1).^2/(2*(alpha2+beta2))).*normcdf((b/beta2-1/alpha2)/del2,0,sqrt(1/del2))/sqrt(2*pi*(alpha2+beta2));
psu1=psu./(0.5*normcdf(1,0,sqrt(alpha2))+0.5*normcdf(-1,0,sqrt(alpha2))+1e-200);

subplot(3,3,7);
pcolor(x,x,psu1(:,:));    % don't worry about the measure - or normalization - for +1
shading flat;
hold on;
axis square
xlabel('\gamma','fontsize',16);
ylabel('\beta','fontsize',16);
%t=title('P(\beta,\gamma|a=1)');
%set(t,'color','g','fontsize',14);


pdp=exp(c/gamma2+b/(alpha2+beta2)).*normcdf(-(b/beta2+1/alpha2)/del2,0,sqrt(1/del2));
pdm=exp(-c/gamma2-b/(alpha2+beta2)).*normcdf(-(b/beta2-1/alpha2)/del2,0,sqrt(1/del2));
pdp0=pdm./(pdp+pdm+1e-200);
usequant=[0 .1 .5 .9 1];

subplot(3,3,5);
pcolor(x,x,pdp0(:,:));    % P(d=-1 | a=-1, beta,gamma)  - is the numerical confidence value
shading flat;
hold on;
[C,h]=contour(x,x,pdp0,usequant(2:(end-1)),'g');
set(h,'linewidth',2);
clabel(C,h,'color','r','fontsize',14);
axis square
xlabel('\gamma','fontsize',16);
ylabel('\beta','fontsize',16);
%t=title('P(d=-1|a=-1,\beta,\gamma)');
%set(t,'color','r','fontsize',14);


pdp=exp(c/gamma2+b/(alpha2+beta2)).*normcdf((b/beta2+1/alpha2)/del2,0,sqrt(1/del2));
pdm=exp(-c/gamma2-b/(alpha2+beta2)).*normcdf((b/beta2-1/alpha2)/del2,0,sqrt(1/del2));
pdp1=pdp./(pdp+pdm+1e-200);

subplot(3,3,8);
pcolor(x,x,pdp1(:,:));
shading flat;
hold on;
[c,h]=contour(x,x,pdp1,usequant(2:(end-1)),'g');
set(h,'linewidth',2);
clabel(c,h,'color','r','fontsize',14);
axis square
xlabel('\gamma','fontsize',16);
ylabel('\beta','fontsize',16);
%t=title('P(d=1|a=1,\beta,\gamma)');
%set(t,'color','g','fontsize',14);
set(gcf,'position',[965 326 810 590]);

dbs=diff(x);
dcs=diff(x);
areas=dbs'*dcs;

avprobs0=0.25*(psu0(1:(end-1),1:(end-1))+psu0(1+(1:(end-1)),1:(end-1))+psu0(1:(end-1),1+(1:(end-1)))+psu0(2:end,2:end));
avprobs1=0.25*(psu1(1:(end-1),1:(end-1))+psu1(1+(1:(end-1)),1:(end-1))+psu1(1:(end-1),1+(1:(end-1)))+psu1(2:end,2:end));
metric0=avprobs0.*areas;
metric1=avprobs1.*areas;

avpconf0=0.25*(pdp0(1:(end-1),1:(end-1))+pdp0(1+(1:(end-1)),1:(end-1))+pdp0(1:(end-1),1+(1:(end-1)))+pdp0(2:end,2:end));
avpconf1=0.25*(pdp1(1:(end-1),1:(end-1))+pdp1(1+(1:(end-1)),1:(end-1))+pdp1(1:(end-1),1+(1:(end-1)))+pdp1(2:end,2:end));

nr=length(usequant)-1;
pacc=zeros(2,nr);
pbin=pacc;
for i=1:nr
    inds=find((avpconf0(:)>=usequant(i)).*(avpconf0(:)<usequant(i+1)));  % compile in confidence bins
    pbin(1,i)=sum(metric0(inds));
    pacc(1,i)=sum(metric0(inds).*avpconf0(inds))/(pbin(1,i)+1e-200);
    inds=find((avpconf1(:)>=usequant(i)).*(avpconf1(:)<usequant(i+1)));
    pbin(2,i)=sum(metric1(inds));
    pacc(2,i)=sum(metric1(inds).*avpconf1(inds))/(pbin(2,i)+1e-200);
end

mpc=normcdf(1,0,sqrt(alpha2));
mi=ent(mpc);
for i=1:nr
    mi=mi-pbin(1,i)*ent(pacc(1,i));
end


subplot(3,3,6);
y=[pbin(1,:).*(1-pacc(1,:)) ; pbin(1,:).*pacc(1,:)];
b=bar(y','stacked');
b(1).FaceColor=[0 0 0];
b(2).FaceColor=[1 1 1];
set(gca,'ylim',[0 1]);
set(gca,'xticklabel',['0.0-0.1' ; '0.1-0.5' ; '0.5-0.9' ;'0.9-1.0']);
set(gca,'xlim',[0.5 nr+0.5]);
set(gca,'fontsize',8);
xlabel('confidence bins');
ylabel('accuracy')
%title(sprintf('meta-I: %5.3f',mi),'fontsize',14);
%axis square

subplot(3,3,9);
y=[pbin(2,:).*(1-pacc(2,:)) ; pbin(2,:).*pacc(2,:)];
b=bar(y','stacked');
b(1).FaceColor=[0 0 0];
b(2).FaceColor=[1 1 1];
set(gca,'ylim',[0 1]);
set(gca,'xticklabel',['0.0-0.1' ; '0.1-0.5' ; '0.5-0.9' ;'0.9-1.0']);
set(gca,'xlim',[0.5 nr+0.5]);
set(gca,'fontsize',8);
xlabel('confidence bins');
ylabel('accuracy')
%title(sprintf('meta-I: %5.3f',mi),'fontsize',14);


%
