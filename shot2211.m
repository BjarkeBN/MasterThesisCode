

shot = 2211;
langmuir = read_NORTH_data(shot,'rp1');
rog = read_NORTH_data(shot,'rt2');

Manymodes=figure;
s = stackedplot(langmuir.Time,[langmuir.Data.'*1000/48,interp1(rog.Time,rog.Data,langmuir.Time).']);
s.XLabel = 'Time [ms]';
s.Title = 'Shot 2211';
s.DisplayLabels={'mA','V'};
s.GridVisible = 'on';
s.AxesProperties(1).LegendVisible = 'on';
s.AxesProperties(1).LegendLabels = {'Langmuir current'};
s.AxesProperties(2).LegendVisible = 'on';
s.AxesProperties(2).LegendLabels = {'Rogovski'};
%Manymodes
exportgraphics(Manymodes, 'Manymodes.pdf', 'ContentType', 'vector'); 



manyModesSpec = figure;
sgtitle('Shot#2211')
subplot(2,1,1);
colormap('jet')
fs = 102400;
spectrogram(rog.Data,500,[],[],fs,'yaxis')
title('Spectrogram of Rogovski');
subplot(2,1,2);
fs = 15255;
spectrogram(langmuir.Data,100,[],[],fs,'yaxis')
title('Spectrogram of probe current')
exportgraphics(manyModesSpec, 'manyModesSpec.pdf', 'ContentType', 'vector'); 
