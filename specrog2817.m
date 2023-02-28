

rog = read_NORTH_data(2817,'rt6');
rog = rog.Data;
fs = 102400;
s2817rog=figure;
spectrogram(rog,500,[],[],fs,'yaxis')
title('Spectrogram of rogovski coil, Shot#2817')
colormap('jet')
%2817rog
exportgraphics(s2817rog, '2817rog.pdf', 'ContentType', 'vector'); 

