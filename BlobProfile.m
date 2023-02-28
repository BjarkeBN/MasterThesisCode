
%clear all
dat = load('transports2.mat');


dt = dat.s.s3218;
dp = load('transport3218.mat');
f = 1;
% f=4 interp5 er mærkelig
dp = dp.di;
figure();
hold on
r = 12;
xip = -0.15:0.0001:0.15;
for i=1:length(dt.t)
    k1 = find(abs(dp.t-dt.t1(i)) < 0.005);
    k2 = find(abs(dp.t-dt.t2(i)) < 0.005);
    k3 = find(abs(dp.t-dt.t3(i)) < 0.005);
    k4 = find(abs(dp.t-dt.t4(i)) < 0.005);
    k5 = find(abs(dp.t-dt.t5(i)) < 0.005);
    k1 = k1(1);
    k2 = k2(1);
    k3 = k3(1);
    k4 = k4(1);
    k5 = k5(1);
   
    x1 = dt.t1(i)-dp.t(k1)+0.0098*(-r:r);
    x2 = dt.t2(i)-dp.t(k2)+0.0098*(-r:r);
    x3 = dt.t3(i)-dp.t(k3)+0.0098*(-r:r);
    x4 = dt.t4(i)-dp.t(k4)+0.0098*(-r:r);
    x5 = dt.t5(i)-dp.t(k5)+0.0098*(-r:r);
    y1 = dp.rt1(k1-r:k1+r);
    y2 = dp.rt2(k2-r:k2+r);
    y3 = dp.rt3(k3-r:k3+r);
    y4 = dp.rt4(k4-r:k4+r);
    y5 = dp.rt5(k5-r:k5+r);

    xp1(i,:) = interp1(x1,y1/max(y1),xip);
    xp2(i,:) = interp1(x2,y2/max(y2),xip);
    xp3(i,:) = interp1(x3,y3/max(y3),xip);
    xp4(i,:) = interp1(x4,y4/max(y4),xip);
    xp5(i,:) = interp1(x5,y5/max(y5),xip);
end


interpmean1(f,:) = mean(xp1);
interpmean2(f,:) = mean(xp2);
interpmean3(f,:) = mean(xp3);
interpmean4(f,:) = mean(xp4);
interpmean5(f,:) = mean(xp5);
plot(xip,interpmean1(f,:)/max(interpmean1(f,:)))
hold on
plot(xip,interpmean2(f,:)/max(interpmean2(f,:)))
plot(xip,interpmean3(f,:)/max(interpmean3(f,:)))
plot(xip,interpmean4(f,:)/max(interpmean4(f,:)))
plot(xip,interpmean5(f,:)/max(interpmean5(f,:)))


figure
plot(xip,(interpmean5(f,:)+interpmean4(f,:)+interpmean3(f,:)+interpmean2(f,:)+interpmean1(f,:))/5)

meanInterp = mean( interpmean1+interpmean2+interpmean3+interpmean4)+mean(interpmean5([1,2,3,5,6,7,8],:));
meanInterp = meanInterp-min(meanInterp);
meanInterp = meanInterp/max(meanInterp);
figure;
plot(xip,meanInterp)
xlabel('\tau')

f = figure;
y = mean(interpmean1(:,:));
plot(xip,y-min(y(1:1000)));
hold on
y = mean(interpmean2(:,:));
plot(xip,y-min(y(1:1000)));
y = mean(interpmean3(:,:));
plot(xip,y-min(y(1:1000)));
y = mean(interpmean4(:,:));
plot(xip,y-min(y(1:1000)));
y = mean(interpmean5(:,:));
plot(xip,y-min(y(1:1000)));
xlabel('\tau [ms]')
legend('Probe-tip 1','Probe-tip 3','Probe-tip 5','Probe-tip 6','Probe-tip 7')
set(gca,'YTick', [])
title('Irregular blob profile')
ylabel('Density [Normalized]')
exportgraphics(f, 'irregularBlobProfile.pdf', 'ContentType', 'vector');
