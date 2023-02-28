

dat = load('transports.mat');
s = dat.s;
s = orderfields(s);
chs = fieldnames(s);

figure;
hold on
cm = prism(6);
cm(3,:) = [];
colororder(cm);

for i=1:23
    if (i < 14)
        color = rgb('blue');
    else
        color = rgb('red');
    end


    plot(1,mean(s.(chs{i}).v1),'*','Color',color);
    plot(3,mean(s.(chs{i}).v2),'*','Color',color);
    plot(5,mean(s.(chs{i}).v3),'*','Color',color);
    plot(6,mean(s.(chs{i}).v4),'*','Color',color);

    

end

he900 = [s.s3202.v,s.s3203.v,s.s3204.v];
he900v1 = [s.s3202.v1,s.s3203.v1,s.s3204.v1];
he900v2 = [s.s3202.v2,s.s3203.v2,s.s3204.v2];
he900v3 = [s.s3202.v3,s.s3203.v3,s.s3204.v3];
he900v4 = [s.s3202.v4,s.s3203.v4,s.s3204.v4];
he800 = s.s3210.v;
he700 = s.s3211.v;
he600 = s.s3212.v;
he500 = s.s3213.v;
he1000 = s.s3214.v;



h900 = [s.s3215.v,s.s3218.v,s.s3217.v];
h900v1 = [s.s3215.v1,s.s3218.v1,s.s3217.v1];
h900v2 = [s.s3215.v2,s.s3218.v2,s.s3217.v2];
h900v3 = [s.s3215.v3,s.s3218.v3,s.s3217.v3];
h900v4 = [s.s3215.v4,s.s3218.v4,s.s3217.v4];

h800 = s.s3223.v;
h700 = s.s3224.v;
h600 = s.s3225.v;

span = 5;
figure;
hold on 


colororder(cm);
cutoff = 7000;

hh900 = histogram(h900(h900 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hh800 = histogram(h800(h800 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hh700 = histogram(h700(h700 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hh600 = histogram(h600(h600 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');


colororder(cm);

hhe1000 = histogram(he1000(he1000 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hhe900 = histogram(he900(he900 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hhe800 = histogram(he800(he800 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hhe700 = histogram(he700(he700 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hhe600 = histogram(he600(he600 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hhe500 = histogram(he500(he500 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');


MPABlobHydrogenPower = figure;
hold on

colororder(cm);
plot(hh900.BinEdges(1:end-1)/2+hh900.BinEdges(2:end)/2,smooth(hh900.Values,span));
plot(hh800.BinEdges(1:end-1)/2+hh800.BinEdges(2:end)/2,smooth(hh800.Values,span));
plot(hh700.BinEdges(1:end-1)/2+hh700.BinEdges(2:end)/2,smooth(hh700.Values,span));
plot(hh600.BinEdges(1:end-1)/2+hh600.BinEdges(2:end)/2,smooth(hh600.Values,span));
title('Density of radial velocities at different power levels','Hydrogen')
xlabel('Velocity [m/s]')
ylabel('Density')
legend('900W','800W','700W','600W')
%MPABlobHydrogenPower
grid on
exportgraphics(MPABlobHydrogenPower, 'MPABlobHydrogenPower.pdf', 'ContentType', 'vector');

MPABlobHeliumPower = figure;
hold on

colororder(cm);
plot(hhe1000.BinEdges(1:end-1)/2+hhe1000.BinEdges(2:end)/2,smooth(hhe1000.Values,span));
plot(hhe900.BinEdges(1:end-1)/2+hhe900.BinEdges(2:end)/2,smooth(hhe900.Values,span));
plot(hhe800.BinEdges(1:end-1)/2+hhe800.BinEdges(2:end)/2,smooth(hhe800.Values,span));
plot(hhe700.BinEdges(1:end-1)/2+hhe700.BinEdges(2:end)/2,smooth(hhe700.Values,span));
plot(hhe600.BinEdges(1:end-1)/2+hhe600.BinEdges(2:end)/2,smooth(hhe600.Values,span));
%plot(hhe500.BinEdges(1:end-1)/2+hhe500.BinEdges(2:end)/2,smooth(hhe500.Values,span));
title('Density of radial velocities at different power levels','Helium')
xlabel('Velocity [m/s]')
ylabel('Density')
legend('1000W','900W','800W','700W','600W');%,'500W')
%MPABlobHeliumPower
grid on
exportgraphics(MPABlobHeliumPower, 'MPABlobHeliumPower.pdf', 'ContentType', 'vector');

figure;
hold on
colororder(cm);


hhe900v1 = histogram(he900v1(he900v1 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hhe900v2 = histogram(he900v2(he900v2 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hhe900v3 = histogram(he900v3(he900v3 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hhe900v4 = histogram(he900v4(he900v4 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
cutoff= 4000;
hh900v1 = histogram(h900v1(h900v1 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hh900v2 = histogram(h900v2(h900v2 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hh900v3 = histogram(h900v3(h900v3 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
hh900v4 = histogram(h900v4(h900v4 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');


MPABlobHydrogen = figure;
hold on;
colororder(cm);
plot(hh900v1.BinEdges(1:end-1)/2+hh900v1.BinEdges(2:end)/2,smooth(hh900v1.Values,span));
plot(hh900v2.BinEdges(1:end-1)/2+hh900v2.BinEdges(2:end)/2,smooth(hh900v2.Values,span));
plot(hh900v3.BinEdges(1:end-1)/2+hh900v3.BinEdges(2:end)/2,smooth(hh900v3.Values,span));
plot(hh900v4.BinEdges(1:end-1)/2+hh900v4.BinEdges(2:end)/2,smooth(hh900v4.Values,span));
legend('v from probe 1 to 3','v from probe 3 to 5','v from probe 5 to 6','v from probe 6 to 7','v from probe 7 to 12')
title('Radial velocities at different positions, 900W','Hydrogen')
xlabel('Velocity [m/s]')
%MPABlobHydrogen
grid on
exportgraphics(MPABlobHydrogen, 'MPABlobHydrogen.pdf', 'ContentType', 'vector');

MPABlobHelium = figure;
hold on;
colororder(cm);
plot(hhe900v1.BinEdges(1:end-1)/2+hhe900v1.BinEdges(2:end)/2,smooth(hhe900v1.Values,span));
plot(hhe900v2.BinEdges(1:end-1)/2+hhe900v2.BinEdges(2:end)/2,smooth(hhe900v2.Values,span));
plot(hhe900v3.BinEdges(1:end-1)/2+hhe900v3.BinEdges(2:end)/2,smooth(hhe900v3.Values,span));
plot(hhe900v4.BinEdges(1:end-1)/2+hhe900v4.BinEdges(2:end)/2,smooth(hhe900v4.Values,span));
legend('v from probe 1 to 3','v from probe 3 to 5','v from probe 5 to 6','v from probe 6 to 7','v from probe 7 to 12')
title('Radial velocities at different positions, 900W','Helium')
xlabel('Velocity [m/s]')
grid on
exportgraphics(MPABlobHelium, 'MPABlobHelium.pdf', 'ContentType', 'vector');
%MPABlobHelium

h900v1 = [s.s3215.v1,s.s3218.v1,s.s3217.v1];
h900v2 = [s.s3215.v2,s.s3218.v2,s.s3217.v2];
h900v3 = [s.s3215.v3,s.s3218.v3,s.s3217.v3];
h900v4 = [s.s3215.v4,s.s3218.v4,s.s3217.v4];

vt1 = he900v1;
vt2 = he900v2;
vt3 = he900v3;
vt4= he900v4;


figure;
hold on
x1 =histogram(vt1(vt1 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
x2 =histogram(vt2(vt2 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
x3 =histogram(vt3(vt3 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');
x4 =histogram(vt4(vt4 < cutoff),'FaceAlpha',0.5,BinWidth=cutoff/80,Normalization='probability');


MPABlobspeed1 = figure;

colororder(cm);
hold on
span = 5;
plot(x1.BinEdges(1:end-1)/2+x1.BinEdges(2:end)/2,smooth(x1.Values,span));
plot(x2.BinEdges(1:end-1)/2+x2.BinEdges(2:end)/2,smooth(x2.Values,span));
plot(x3.BinEdges(1:end-1)/2+x3.BinEdges(2:end)/2,smooth(x3.Values,span));
plot(x4.BinEdges(1:end-1)/2+x4.BinEdges(2:end)/2,smooth(x4.Values,span));
legend('v from probe 1 to 3','v from probe 3 to 5','v from probe 5 to 6','v from probe 6 to 7','v from probe 7 to 12')
xlabel('Velocity [m/s]')
ylabel('Density')
xlim([0,cutoff])
title(['Histogram of blob velocities '])
grid on
exportgraphics(MPABlobspeed1, 'MPABlobspeed1.pdf', 'ContentType', 'vector');
%MPABlobspeed1


asd = figure;
%plot(s.s3204.t,s.s3204.v)
plot(s.s3206.t,s.s3206.v)
xlabel('Time (ms)' )
ylabel('Velocity (m/s)')
title('Shot 3206','Velocity over time')
hold on
plot(s.s3206.t,movmean(s.s3206.v,100))
grid on
exportgraphics(asd, 'velocity.pdf', 'ContentType', 'vector'); 
