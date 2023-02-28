

x = -50:0.1:2.9;
y = exp(x/5)-0.2+x*0.001-0.02*exp(x);
xx = 2.9:0.1:20;
yy = exp(2.9/5)-0.2+2.9*0.001-0.02*exp(2.9)+(xx-2.9)*0.003;

figure;
plot(x,y,'blue')

hold on
plot(xx,yy,'blue')
set(gca,'YTick', [-0.1],'XTick', [-1],'YTickLabel',{'I=0'},'XTickLabel','V=0')

xlabel('Bias voltage [V]')
ylabel('Probe current [A]')
plot(-50:20,-0.1*linspace(1,1,71),'--k')
%ylim([-0.25,1.8])
plot(-1*linspace(1,1,2),ylim,'--k')
title('IV curve sketch for an ideal cylindrical probe.')
legend('Probe current')