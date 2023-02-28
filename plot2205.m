%plot 2207
shot = 2207;
langmuir = read_NORTH_data(shot,'rp1');
itf = read_NORTH_data(shot,'itf');
pow = read_NORTH_data(shot,'pow1');
pres = read_NORTH_data(shot,'pres');
rog = read_NORTH_data(shot,'rt2');

SingleShot1 = figure;
s = stackedplot(langmuir.Time,[langmuir.Data.',interp1(itf.Time,itf.Data,langmuir.Time).',interp1(pow.Time,pow.Data,langmuir.Time).',interp1(pres.Time,pres.Data,langmuir.Time).',interp1(rog.Time,rog.Data,langmuir.Time).']);
s.XLabel = 'Time [ms]';
s.Title = 'Shot 2207';
s.DisplayLabels={'mA','A','W','mbar','V'};
s.GridVisible = 'on';
s.AxesProperties(1).LegendVisible = 'on';
s.AxesProperties(1).LegendLocation = 'southeast';
s.AxesProperties(1).LegendLabels = {'Langmuir current'};
s.AxesProperties(2).LegendVisible = 'on';
s.AxesProperties(2).LegendLocation = 'southeast';
s.AxesProperties(2).LegendLabels = {'Toroidal coil current'};
s.AxesProperties(3).LegendVisible = 'on';
s.AxesProperties(3).LegendLocation = 'southeast';
s.AxesProperties(3).LegendLabels = {'Forward power Lfs'};
s.AxesProperties(4).LegendVisible = 'on';
s.AxesProperties(4).LegendLocation = 'southeast';
s.AxesProperties(4).LegendLabels = {'Pressure'};
s.AxesProperties(5).LegendVisible = 'on';
s.AxesProperties(5).LegendLabels = {'Rogovski'};
s.AxesProperties(5).LegendLocation = 'southeast';
s.FontSize = 10;

%SingleShot1
exportgraphics(SingleShot1, 'SingleShot1.pdf', 'ContentType', 'vector'); 
