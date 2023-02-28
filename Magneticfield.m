clear all
close all


R = 0.25;
r = 0.12;
th = 0:pi/50:2*pi;
xunit1 = r * cos(th) + R;
yunit1 = r * sin(th);

magneticfield = figure('Position', [0 0 600 550]);
yyaxis left
plot(xunit1, yunit1);
xlabel('r [m]')
ylabel('z [m]')


x = 0.13:0.001:0.37;
mu = 4*pi*10^-7;
N = 96;
I = 1000;

B = mu*N*I/2/pi./x;
grid on
yyaxis right
plot(x,B)
ylabel('Magnetic field strength [T]')

title('Magnetic field inside NORTH')

q = 1.6*10^-19;
fh = 2.45*10^9;
m = 9.11*10^-31;
rr = mu*N*I*q/(4*pi^2*fh*m); 
xline(rr);

legend('NORTH Walls','Magnetic field strength','Electron cyclotron resonance')



exportgraphics(magneticfield, 'magneticfield.pdf', 'ContentType', 'vector'); 

