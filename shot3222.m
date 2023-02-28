

rt1 = read_NORTH_data(3222,'rt1');
rt2 = read_NORTH_data(3222,'rt2');
rt3 = read_NORTH_data(3222,'rt3');
rt4 = read_NORTH_data(3222,'rt4');

MPAMode = figure;
s = stackedplot(rt1.Time,[rt1.Data.',rt2.Data.',rt3.Data.',rt4.Data.']);
xlim([371,375]);
s.AxesProperties(1).YLimits = [-1.1,0.1];
s.AxesProperties(2).YLimits = [-1.5,0.1];
s.AxesProperties(3).YLimits = [-1.7,0.1];
s.AxesProperties(4).YLimits = [-1.6,0.1];
s.GridVisible = 'on';
s.XLabel = 'Time [ms]';
s.Title = 'Shot 3222';
s.DisplayLabels={'mA','mA','mA','mA'};
s.AxesProperties(1).LegendVisible = 'on';
s.AxesProperties(1).LegendLocation = 'southeast';
s.AxesProperties(1).LegendLabels = {'Probe 1'};
s.AxesProperties(2).LegendVisible = 'on';
s.AxesProperties(2).LegendLocation = 'southeast';
s.AxesProperties(2).LegendLabels = {'Probe 2'};
s.AxesProperties(3).LegendVisible = 'on';
s.AxesProperties(3).LegendLocation = 'southeast';
s.AxesProperties(3).LegendLabels = {'Probe 3'};
s.AxesProperties(4).LegendVisible = 'on';
s.AxesProperties(4).LegendLabels = {'Probe4'};
s.AxesProperties(4).LegendLocation = 'southeast';

exportgraphics(MPAMode, 'MPAMode.pdf', 'ContentType', 'vector'); 
