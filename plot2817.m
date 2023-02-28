%plot 2817
shot = 2817;
langmuir = read_NORTH_data(shot,'rt2');
langmuir.Data = langmuir.Data/48/20*1000;
itf = read_NORTH_data(shot,'itf');
pow = read_NORTH_data(shot,'pow2');
pres = read_NORTH_data(shot,'pres');
rog = read_NORTH_data(shot,'rt1');

s2817a = figure;
                              
s = stackedplot(langmuir.Time,[langmuir.Data.',interp1(itf.Time,itf.Data,langmuir.Time).',interp1(pow.Time,pow.Data,langmuir.Time).',interp1(rog.Time,rog.Data,langmuir.Time).']);
s.XLabel = 'Time [ms]';
s.Title = 'Shot 2817';
s.DisplayLabels={'mA','A','W','V'};
s.GridVisible = 'on';
s.AxesProperties(1).LegendVisible = 'on';
%s.AxesProperties(1).LegendLocation = 'southeast';
s.AxesProperties(1).LegendLabels = {'Langmuir current'};
s.AxesProperties(2).LegendVisible = 'on';
%s.AxesProperties(2).LegendLocation = 'southeast';
s.AxesProperties(2).LegendLabels = {'Toroidal coil current'};
s.AxesProperties(3).LegendVisible = 'on';
%s.AxesProperties(3).LegendLocation = 'southeast';
s.AxesProperties(3).LegendLabels = {'Forward power Hfs'};
s.AxesProperties(4).LegendVisible = 'on';
s.AxesProperties(4).LegendLabels = {'Rogovski'};
%s.AxesProperties(4).LegendLocation = 'southeast';
s.FontSize = 10;
%s2817a
exportgraphics(s2817a, '2817a.pdf', 'ContentType', 'vector'); 

s2817aclose = figure;
xlabel('Time [ms]');
ylabel('Probe current [mA]')
title('Langmuir current')

t = tiledlayout(1,1);
ax1 = axes(t);
plot(langmuir.Time(17875:18100),langmuir.Data(17875:18100))
hold on
ax2 = axes(t);
plot(langmuir.Time(17875:18100),langmuir.Data(17875:18100))
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.YTick = [];
ax2.XTick = 174.586:0.125:(177.086-0.125*3);
ax2.XTickLabel = {'-50','-25','0','25','50','25','0','-25','-50','-25','0','25','50','25','0','-25','-50','-25','0'};
grid(ax2,'on')
ax2.XMinorTick = 'off';
ax2.XLabel.String = 'Bias voltage [V]';
ax1.XLabel.String = 'Time [ms]';
ax1.YLabel.String = 'Probe current [mA]';
ax1.Box = 'off';
ax2.Box = 'off';
ax1.XLim = [174.5,176.875];
ax2.XLim = [174.5,176.875];

title('Langmuir current shot#2817')

exportgraphics(s2817aclose, '2817close.pdf', 'ContentType', 'vector'); 


