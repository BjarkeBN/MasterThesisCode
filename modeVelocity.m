clear variables
close all
clc
chs = {'rt1','rt2','rt3','rt4','rt5','rt6'};
area = [20,20*5/7,20*6/7,20*5/7,20/7,20*5/7]/20;


d = read_NORTH_data(3222,chs{1});
t1 = d.Time(30000:45000);
d1 = -d.Data(30000:45000)*area(1);
d = read_NORTH_data(3222,chs{2});
t2 = d.Time;
d2 = -d.Data(30000:45000)*area(2);
d = read_NORTH_data(3222,chs{3});
t3 = d.Time;
d3 = -d.Data(30000:45000)*area(3);
d = read_NORTH_data(3222,chs{4});
t4 = d.Time;
d4 = -d.Data(30000:45000)*area(4);
d = read_NORTH_data(3222,chs{5});
t5 = d.Time;
d5 = -d.Data(30000:45000)*area(5);
d = read_NORTH_data(3222,chs{6});
t6 = d.Time;
d6 = -d.Data(30000:45000)*area(6);
v12 = [];
v23=[];
v34=[];
v45=[];
v = [];
L =50;
for i=1:length(d1)/(L/2)-1
    phi = phdiffmeasure(d1(1+(i-1)*(L/2):L+(i-1)*(L/2)),d2(1+(i-1)*(L/2):L+(i-1)*(L/2)));
    phi = min(abs(phi),abs(phi-2*pi));   
    Y = fft(d1(1:L));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    Fs = 102400;
    f = Fs*(0:(L/2))/L;
    [~, ind] = max(P1(2:end));
    fsMode = f(1+ind);
    dis = 0.02;
    v12(end+1) = dis*2*pi/phi*fsMode;

    phi = phdiffmeasure(d2(1+(i-1)*(L/2):L+(i-1)*(L/2)),d3(1+(i-1)*(L/2):L+(i-1)*(L/2)));
    phi = min(abs(phi),abs(phi-2*pi));   
    Y = fft(d2(1:L));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    Fs = 102400;
    f = Fs*(0:(L/2))/L;
    [~, ind] = max(P1(2:end));
    fsMode = f(1+ind);
    dis = 0.02;
    v23(end+1) = dis*2*pi/phi*fsMode;

    phi = phdiffmeasure(d3(1+(i-1)*(L/2):L+(i-1)*(L/2)),d4(1+(i-1)*(L/2):L+(i-1)*(L/2)));
    phi = min(abs(phi),abs(phi-2*pi));   
    Y = fft(d3(1:L));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    Fs = 102400;
    f = Fs*(0:(L/2))/L;
    [~, ind] = max(P1(2:end));
    fsMode = f(1+ind);
    dis = 0.02;
    v34(end+1) = dis*2*pi/phi*fsMode;

    phi = phdiffmeasure(d4(1+(i-1)*(L/2):L+(i-1)*(L/2)),d5(1+(i-1)*(L/2):L+(i-1)*(L/2)));
    phi = min(abs(phi),abs(phi-2*pi));   
    Y = fft(d4(1:L));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    Fs = 102400;
    f = Fs*(0:(L/2))/L;
    [~, ind] = max(P1(2:end));
    fsMode = f(1+ind);
    dis = 0.02;
    v45(end+1) = dis*2*pi/phi*fsMode;

    phi = phdiffmeasure(d1(1+(i-1)*(L/2):L+(i-1)*(L/2)),d5(1+(i-1)*(L/2):L+(i-1)*(L/2)));
    phi = min(abs(phi),abs(phi-2*pi));   
    Y = fft(d1(1:L));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    Fs = 102400;
    f = Fs*(0:(L/2))/L;
    [~, ind] = max(P1(2:end));
    fsMode = f(1+ind);
    dis = 0.06;
    v(end+1) = dis*2*pi/phi*fsMode;
end
cutoff = 3000;
v12 = v12(v12<cutoff);
v = v(v<cutoff);
v23 = v23(v23<cutoff);
v34 = v34(v34<cutoff);
v45 = v45(v45<cutoff);

figure;
hold on
plot(t1(1:L/2:L+(i-1)*(L/2)-4*L/2),v)
plot(t1(1:L/2:L+(i-1)*(L/2)-4*L/2),movmean(v,100))
title('Mode velocity')
xlabel('Time [ms]')
ylabel('Velocity [m/s]')
legend('v-Total','v-mean')

div = 150;
figure;
histogram(v,div)
title('Mode velocity - total')

figure;
hold on
x1 =histogram(v12,'FaceAlpha',0.5,BinWidth=cutoff/div,Normalization='probability');
x2 =histogram(v23,'FaceAlpha',0.5,BinWidth=cutoff/div,Normalization='probability');
x3 =histogram(v34,'FaceAlpha',0.5,BinWidth=cutoff/div,Normalization='probability');
x4 =histogram(v45,'FaceAlpha',0.5,BinWidth=cutoff/div,Normalization='probability');
xt =histogram(v,'FaceAlpha',0.5,BinWidth=cutoff/div,Normalization='probability'); 

ModeVelocity = figure;
cm = prism(6);
cm(3,:) = [];
colororder(cm);
hold on
span = 10;
plot(x1.BinEdges(1:end-1)/2+x1.BinEdges(2:end)/2,smooth(x1.Values,span));
plot(x2.BinEdges(1:end-1)/2+x2.BinEdges(2:end)/2,smooth(x2.Values,span));
plot(x3.BinEdges(1:end-1)/2+x3.BinEdges(2:end)/2,smooth(x3.Values,span));
plot(x4.BinEdges(1:end-1)/2+x4.BinEdges(2:end)/2,smooth(x4.Values,span));
plot(xt.BinEdges(1:end-1)/2+xt.BinEdges(2:end)/2,smooth(xt.Values,span));
legend('v1','v2','v3','v4','v-total')
xlabel('Velocity [m/s]')
ylabel('Density')
xlim([0,cutoff])
title(['Histogram of mode velocities '])
grid on
exportgraphics(ModeVelocity, 'modeVelocity.pdf', 'ContentType', 'vector'); 
