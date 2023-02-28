chs = {'rt1','rt2','rt3','rt4','rt5','rt6'};
ohm = [51.8,49.9,47.4,47.1,47.6,46.9];

r = 0.15e-3;
%R = 15e-3;
R = [20,20*5/7,20*6/7,20*5/7,20/7,20*5/7]*1e-3;
q = 1.602e-19;
mi = 6.644e-27; % helium
%mi = 1.674e-27; %Hydrogen


shot = '3217';
shots = [3218,3219,3220,3221,3222,3223,3224,3225];%,3226]; kan ikke finde

for fff=1:8
shot = num2str(shots(fff));
%for i=1:3
%    area = pi*r*r+2*pi*r*R(i);
%    d = read_NORTH_data(3203,chs{i});
%    di.(chs{i}) = d.Data/ohm(i) - movmean(d.Data/ohm(i),100);
%    di.(chs{i}) = -di.(chs{i})./area;
%    di.(chs{i}) = di.(chs{i})/max(di.(chs{i}));
%end
%dt = read_NORTH_data(3203,'rt0').Time;
di = load(['transport',shot,'.mat']);
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


threshold = std(sub);
threshold = 0;
parfor i=1:length(pl1)
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > threshold)
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
threshold = std(sub);
threshold = 0;
parfor i=1:length(vall)-1
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > threshold)
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
threshold = std(sub);
threshold = 0;
parfor i=1:length(vall)-1
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > threshold)
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
threshold = std(sub);
threshold = 0;
parfor i=1:length(vall)-1
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > threshold)
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
threshold = std(sub);
threshold = 0;
parfor i=1:length(vall)-1
    if (length(vall(i):vall(i+1)) > 3 && (sub(locs(i))-(sub(vall(i))+sub(vall(i+1)))/2) > threshold)
        ff = fit(dtsub(vall(i):vall(i+1)).',sub(vall(i):vall(i+1)).',f,'Lower',[min(sub(vall(i):vall(i+1))),0,dtsub(vall(i)),0],'Upper', [1,0.1,dtsub(vall(i+1)),inf],'Startpoint',[0,0.1,dtsub(locs(i)),1]);
        pl5(i) = ff.c;
        pla5(i) = ff(ff.c);
    end
end
disp('fifth')
toc




vdt = [];
vt = [];
vt1 = [];
vt2 = [];
vt3 = [];
vt4 = [];
t1 = [];
t2 = [];
t3 = [];
t4 = [];
t5 = [];
pl1 = pl1(pl1~=0);
pl2 = pl2(pl2~=0);
pl3 = pl3(pl3~=0);
pl4 = pl4(pl4~=0);
pl5 = pl5(pl5~=0);


% for i=1:min([(length(pl1)-1),length(pl2),length(pl3),length(pl4),length(pl5),length(pl6)])
for i=1:length(pl1)-1
    finderror = 0;
    a = find( pl2 > pl1(i),1,'first');
    if (isempty(a))
        finderror = 1;
        a = 1;
    end
    b = find( pl3 > pl2(a),1,'first');
    if (isempty(b))
        finderror = 1;
         b = 1;
    end
    c = find( pl4 > pl3(b),1,'first');
    if (isempty(c))
        finderror = 1;
        c = 1;
    end
    d = find( pl5 > pl4(c),1,'first');
    if (isempty(d))
        finderror = 1;
        d = 1;
    end

    if (pl5(d) < pl1(i+1) && finderror == 0)
        vm1 = 0.02/(pl2(a)-pl1(i))*1000;
        vm2 = 0.02/(pl3(b)-pl2(a))*1000;
        vm3 = 0.01/(pl4(c)-pl3(b))*1000;
        vm4 = 0.01/(pl5(d)-pl4(c))*1000;
        if (vm2 < 5*vm1 && vm2 > 0.2*vm1 && vm3 < 5*vm2 && vm3 > 0.2*vm2 && vm4 < 5*vm3 && vm4 > 0.2*vm3)
            vt1(end+1) = 0.02/(pl2(a)-pl1(i))*1000;
            vt2(end+1) = 0.02/(pl3(b)-pl2(a))*1000;
            vt3(end+1) = 0.01/(pl4(c)-pl3(b))*1000;
            vt4(end+1) = 0.01/(pl5(d)-pl4(c))*1000;
            vt(end + 1) = 0.06/(pl4(c)-pl1(i))*1000;
            vdt(end +1) = pl1(i);
            t1(end +1) = pl1(i);
            t2(end +1) = pl2(a);
            t3(end +1) = pl3(b);
            t4(end +1) = pl4(c);
            t5(end +1) = pl5(d);
        end
    end
    
    
end
 % c1p1,c2p3,c3p5,c4p6,c5p7,c6p12
cutoff =4000;
figure;
colororder(rgb('blue','red','green','orange','purple'));
hold on
x1 = histogram(vt1(vt1 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
x2 = histogram(vt2(vt2 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
x3 = histogram(vt3(vt3 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
x4 = histogram(vt4(vt4 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
legend('v from probe 1 to 2','v from probe 2 to 3','v from probe 3 to 4','v from probe 4 to 5')
xlabel('Velocity [m/s]')
ylabel('Density')
xlim([0,cutoff])
title(['Histogram of blob velocities ',shot],[num2str(length(vt)),' Blobs'])

figure;
colororder(rgb('blue','red','green','orange','purple'));
hold on
span = 5;
plot(x1.BinEdges(1:end-1)/2+x1.BinEdges(2:end)/2,smooth(x1.Values,span));
plot(x2.BinEdges(1:end-1)/2+x2.BinEdges(2:end)/2,smooth(x2.Values,span));
plot(x3.BinEdges(1:end-1)/2+x3.BinEdges(2:end)/2,smooth(x3.Values,span));
plot(x4.BinEdges(1:end-1)/2+x4.BinEdges(2:end)/2,smooth(x4.Values,span));
legend('v from probe 1 to 2','v from probe 2 to 3','v from probe 3 to 4','v from probe 4 to 5')
xlabel('Velocity [m/s]')
ylabel('Density')
xlim([0,cutoff])
title(['Histogram of blob velocities ',shot],[num2str(length(vt)),' Blobs'])

figure;
histogram(vt,50);
xlabel('Velocity [m/s]')
ylabel('Count')
title('Histogram of blob velocities')
title(['Histogram of blob velocities ',shot])

s.(['s',shot]).t = vdt;
s.(['s',shot]).v = vt;
s.(['s',shot]).v1 = vt1;
s.(['s',shot]).v2 = vt2;
s.(['s',shot]).v3 = vt3;
s.(['s',shot]).v4 = vt4;
s.(['s',shot]).t1 = t1;
s.(['s',shot]).t2 = t2;
s.(['s',shot]).t3 = t3;
s.(['s',shot]).t4 = t4;
s.(['s',shot]).t5 = t5;

end

save('transports2.mat','s');
