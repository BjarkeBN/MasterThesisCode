clear variables
close all


d = read_NORTH_data(2002,'itf');

itf = figure;
plot(d.Time,d.Data)
title('Toroidal field current in shot#2002')
xlabel('Time [ms]')
ylabel('Current [A]')
grid on

exportgraphics(itf, 'Itf.pdf', 'ContentType', 'vector'); 


