chs = {'rt1','rt2','rt3','rt4','rt5','rt6'};
ohm = [51.8,49.9,47.4,47.1,47.6,46.9];

r = 0.15e-3;
%R = 15e-3;
R = [20,20*5/7,20*6/7,20*5/7,20/7,20*5/7]*1e-3;
q = 1.602e-19;
mi = 6.644e-27; % helium
%mi = 1.674e-27; %Hydrogen





%for i=1:3
%    area = pi*r*r+2*pi*r*R(i);
%    d = read_NORTH_data(3203,chs{i});
%    di.(chs{i}) = d.Data/ohm(i) - movmean(d.Data/ohm(i),100);
%    di.(chs{i}) = -di.(chs{i})./area;
%    di.(chs{i}) = di.(chs{i})/max(di.(chs{i}));
%end
%dt = read_NORTH_data(3203,'rt0').Time;
di = load('transport3203.mat');
di = di.di;
dt = di.t;

subs = 20600;
sube = 90000;


sub = di.(chs{1})(subs:sube);
dtsub = dt(subs:sube);
%figure();
%hold on
for i=1:3
    %plot(dtsub,di.(chs{i})(subs:sube))
end
%legend(chs)
[pks,locs,~,~] = findpeaks(sub);
vall = islocalmin(sub);
vallt = linspace(1,length(vall),length(vall));
vall = vallt(vall);
vals = sub(vall);
%plot(dtsub(locs),pks,'v')
%plot(dtsub(vall),vals,'^')

if(vall(1) < locs(1))
    
else
    locs = locs(2:end);
    pks = pks(2:end);
end

disp('starting')
f = fittype('a+d./(b*sqrt(2*pi))*exp(-(x-c).^2./(2*b^2))');
tic
pl1 = zeros(length(vall)-1,1);
pla1 = zeros(length(vall)-1,1);



parfor i=1:length(pl1)
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > 0.2)
        ff = fit(dtsub(vall(i):vall(i+1)).',sub(vall(i):vall(i+1)).',f,'Lower',[min(sub(vall(i):vall(i+1))),0,dtsub(vall(i)),0],'Upper', [1,0.1,dtsub(vall(i+1)),inf],'Startpoint',[0,0.1,dtsub(locs(i)),1]);
        pl1(i) = ff.c;
        pla1(i) = ff(ff.c);
        
        
    end
    
end
disp('First')
toc


sub = di.(chs{2})(subs:sube);
dtsub = dt(subs:sube);
[pks,locs,~,~] = findpeaks(sub);
vall = islocalmin(sub);
vallt = linspace(1,length(vall),length(vall));
vall = vallt(vall);
vals = sub(vall);
%plot(dtsub(locs),pks,'v')
%plot(dtsub(vall),vals,'^')

if(vall(1) < locs(1))
    
else
    locs = locs(2:end);
    pks = pks(2:end);
end


f = fittype('a+d./(b*sqrt(2*pi))*exp(-(x-c).^2./(2*b^2))');
tic

pl2 = zeros(length(vall)-1,1);
pla2 = zeros(length(vall)-1,1);
parfor i=1:length(vall)-1
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > 0.2)
        ff = fit(dtsub(vall(i):vall(i+1)).',sub(vall(i):vall(i+1)).',f,'Lower',[min(sub(vall(i):vall(i+1))),0,dtsub(vall(i)),0],'Upper', [1,0.1,dtsub(vall(i+1)),inf],'Startpoint',[0,0.1,dtsub(locs(i)),1]);
        pl2(i) = ff.c;
        pla2(i) = ff(ff.c);
        
    end
    
end
disp('second')
toc
sub = di.(chs{3})(subs:sube);
dtsub = dt(subs:sube);
[pks,locs,w,p] = findpeaks(sub);
vall = islocalmin(sub);
vallt = linspace(1,length(vall),length(vall));
vall = vallt(vall);
vals = sub(vall);
%plot(dtsub(locs),pks,'v')
%plot(dtsub(vall),vals,'^')

if(vall(1) < locs(1))
    
else
    locs = locs(2:end);
    pks = pks(2:end);
end

tic
f = fittype('a+d./(b*sqrt(2*pi))*exp(-(x-c).^2./(2*b^2))');

pl3 = zeros(length(vall)-1,1);
pla3 = zeros(length(vall)-1,1);
parfor i=1:length(vall)-1
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > 0.2)
        ff = fit(dtsub(vall(i):vall(i+1)).',sub(vall(i):vall(i+1)).',f,'Lower',[min(sub(vall(i):vall(i+1))),0,dtsub(vall(i)),0],'Upper', [1,0.1,dtsub(vall(i+1)),inf],'Startpoint',[0,0.1,dtsub(locs(i)),1]);
        pl3(i) = ff.c;
        pla3(i) = ff(ff.c);
        
    else
        pl3(i) = 0;
        pla3(i) = 0;
    end
    
end
disp('third')
toc
%plot(pl1,pla1,'b*')
%plot(pl2,pla2,'r*')
%plot(pl3,pla3,'y*')
%xlabel('Time [ms]')
%ylabel('Normalized data')


sub = di.(chs{4})(subs:sube);
dtsub = dt(subs:sube);
[pks,locs,w,p] = findpeaks(sub);
vall = islocalmin(sub);
vallt = linspace(1,length(vall),length(vall));
vall = vallt(vall);
vals = sub(vall);
%plot(dtsub(locs),pks,'v')
%plot(dtsub(vall),vals,'^')

if(vall(1) < locs(1))
    
else
    locs = locs(2:end);
    pks = pks(2:end);
end

tic
f = fittype('a+d./(b*sqrt(2*pi))*exp(-(x-c).^2./(2*b^2))');

pl4 = zeros(length(vall)-1,1);
pla4 = zeros(length(vall)-1,1);
parfor i=1:length(vall)-1
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > 0.2)
        ff = fit(dtsub(vall(i):vall(i+1)).',sub(vall(i):vall(i+1)).',f,'Lower',[min(sub(vall(i):vall(i+1))),0,dtsub(vall(i)),0],'Upper', [1,0.1,dtsub(vall(i+1)),inf],'Startpoint',[0,0.1,dtsub(locs(i)),1]);
        pl4(i) = ff.c;
        pla4(i) = ff(ff.c);
    end
end
disp('Fourth')
toc

sub = di.(chs{5})(subs:sube);
dtsub = dt(subs:sube);
[pks,locs,w,p] = findpeaks(sub);
vall = islocalmin(sub);
vallt = linspace(1,length(vall),length(vall));
vall = vallt(vall);
vals = sub(vall);
%plot(dtsub(locs),pks,'v')
%plot(dtsub(vall),vals,'^')

if(vall(1) < locs(1))
    
else
    locs = locs(2:end);
    pks = pks(2:end);
end

tic
f = fittype('a+d./(b*sqrt(2*pi))*exp(-(x-c).^2./(2*b^2))');

pl5 = zeros(length(vall)-1,1);
pla5 = zeros(length(vall)-1,1);
parfor i=1:length(vall)-1
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > 0.2)
        ff = fit(dtsub(vall(i):vall(i+1)).',sub(vall(i):vall(i+1)).',f,'Lower',[min(sub(vall(i):vall(i+1))),0,dtsub(vall(i)),0],'Upper', [1,0.1,dtsub(vall(i+1)),inf],'Startpoint',[0,0.1,dtsub(locs(i)),1]);
        pl5(i) = ff.c;
        pla5(i) = ff(ff.c);
    end
end
disp('Fifth')
toc

sub = di.(chs{6})(subs:sube);
dtsub = dt(subs:sube);
[pks,locs,w,p] = findpeaks(sub);
vall = islocalmin(sub);
vallt = linspace(1,length(vall),length(vall));
vall = vallt(vall);
vals = sub(vall);
%plot(dtsub(locs),pks,'v')
%plot(dtsub(vall),vals,'^')

if(vall(1) < locs(1))
    
else
    locs = locs(2:end);
    pks = pks(2:end);
end

tic
f = fittype('a+d./(b*sqrt(2*pi))*exp(-(x-c).^2./(2*b^2))');

pl6 = zeros(length(vall)-1,1);
pla6 = zeros(length(vall)-1,1);
parfor i=1:length(vall)-1
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > 0.2)
        ff = fit(dtsub(vall(i):vall(i+1)).',sub(vall(i):vall(i+1)).',f,'Lower',[min(sub(vall(i):vall(i+1))),0,dtsub(vall(i)),0],'Upper', [1,0.1,dtsub(vall(i+1)),inf],'Startpoint',[0,0.1,dtsub(locs(i)),1]);
        pl6(i) = ff.c;
        pla6(i) = ff(ff.c);
    end
end
disp('Sixth')
toc




v = [];
v1 = [];
v2 = [];
v3 = [];
vt = [];
vt1 = [];
vt2 = [];
vt3 = [];
v4 = [];
v5 = [];
pl1 = pl1(pl1~=0);
pl2 = pl2(pl2~=0);
pl3 = pl3(pl3~=0);
pl4 = pl4(pl4~=0);
pl5 = pl5(pl5~=0);
pl6 = pl6(pl6~=0);
for i=1:min([(length(pl1)-1),length(pl2),length(pl3),length(pl4),length(pl5),length(pl6)])
    a = find( pl2 > pl1(i),1,'first');
    b = find( pl3 > pl2(a),1,'first');
    c = find( pl4 > pl3(b),1,'first');
    d = find( pl5 > pl4(c),1,'first');
    e = find( pl6 > pl5(d),1,'first');

%     if (pl3(b) < pl1(i+1) && pl4(c) < pl1(i+1))
%         v1(end+1) = 0.02/(pl2(a)-pl1(i))*1000;
%         v2(end+1) = 0.02/(pl3(b)-pl2(a))*1000;
%         v3(end+1) = 0.01/(pl4(c)-pl3(b))*1000;
%         v4(end+1) = 0.01/(pl5(d)-pl4(c))*1000;
%         v5(end+1) = 0.05/(pl6(e)-pl5(d))*1000;
%         v(end + 1) = 0.05/(pl4(c)-pl1(i))*1000;
%     end
    if (pl3(b) < pl1(i+1) )
        vm1 = 0.02/(pl2(a)-pl1(i))*1000;
        vm2 = 0.02/(pl3(b)-pl2(a))*1000;
        vm3 = 0.01/(pl4(c)-pl3(b))*1000;
        if (vm2 < 5*vm1 && vm2 > 0.2*vm1 && vm3 < 5*vm2 && vm3 > 0.2*vm2)
            vt1(end+1) = 0.02/(pl2(a)-pl1(i))*1000;
            vt2(end+1) = 0.02/(pl3(b)-pl2(a))*1000;
            vt3(end+1) = 0.01/(pl4(c)-pl3(b))*1000;
            vt(end + 1) = 0.05/(pl4(c)-pl1(i))*1000;
        end
        v1(end+1) = 0.02/(pl2(a)-pl1(i))*1000;
        v2(end+1) = 0.02/(pl3(b)-pl2(a))*1000;
        v3(end+1) = 0.01/(pl4(c)-pl3(b))*1000;
        v(end + 1) = 0.05/(pl4(c)-pl1(i))*1000;
    end
    
    
end
 % c1p1,c2p3,c3p5,c4p6,c5p7,c6p12
figure;
hold on
histogram(v1(v1 < 7000),50,'FaceAlpha',0.5);
histogram(v2(v2 < 7000),50,'FaceAlpha',0.5);
histogram(v3(v3 < 7000),50,'FaceAlpha',0.5);
histogram(v4(v4 < 7000),50,'FaceAlpha',0.5);
%histogram(v5(v5 < 7000),50,'DisplayStyle','stairs');
legend('v from probe 1 to 2','v from probe 2 to 3','v from probe 3 to 4','v4','v5')
xlabel('Velocity [m/s]')
ylabel('Count')
title('Histogram of blob velocities 3203')
figure;
hold on
histogram(vt1(vt1 < 7000),50,'FaceAlpha',0.5);
histogram(vt2(vt2 < 7000),50,'FaceAlpha',0.5);
histogram(vt3(vt3 < 7000),50,'FaceAlpha',0.5);
legend('v from probe 1 to 2','v from probe 2 to 3','v from probe 3 to 4')
xlabel('Velocity [m/s]')
ylabel('Count')
title('Histogram of blob velocities 3203')

figure;
histogram(v,50);
xlabel('Velocity [m/s]')
ylabel('Count')
title('Histogram of blob velocities')
title('Histogram of blob velocities 3203')

figure;
histogram(vt,50);
xlabel('Velocity [m/s]')
ylabel('Count')
title('Histogram of blob velocities')
title('Histogram of blob velocities 3203')


