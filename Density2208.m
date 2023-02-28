dat = read_NORTH_data(2208,'rp1');

SingleShotDensity1 = figure;


r = 0.5e-3;
R = 2e-3;
area = pi*r*r+2*pi*r*R;
q = 1.602e-19;
mi = 6.644e-27;
Te = 5;
    
ne = dat.Data/220/area/q*sqrt(mi/2/Te)/sqrt(q);
mov = movmean(ne,100);

plot(dat.Time,ne);
hold on
plot(dat.Time,mov);
grid on
xlabel('Time [ms]')
ylabel('Density [m⁻³]')
title('Electron density of shot #2208')
legend('Density','Denisty - moving mean',Location='southeast');

%SingleShotDensity1
exportgraphics(SingleShotDensity1, 'SingleShotDensity1.pdf', 'ContentType', 'vector'); 
