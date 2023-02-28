clear variables


di = load('transport3202.mat');
s = di.di;


f = figure;
hold on
cm = lines(6);
%cm(3,:) = [];
colororder(cm);


plot(s.t,s.rt1,'Color',cm(1,:));
plot(s.t,s.rt2,'Color',cm(2,:));
plot(s.t,s.rt3,'Color',cm(3,:));
xlim([298.68, 299.57])
legend('Probetip 1', 'Probetip 3', 'Probetip 5')
xlabel('Time [ms]')
ylabel('Detrended density [Normalized]')
title('Blob propagation between probes, shot#3202')


exportgraphics(f, 'BlobPropagationClose.pdf', 'ContentType', 'vector'); 

