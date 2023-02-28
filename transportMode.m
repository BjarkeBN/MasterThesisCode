

function [xp1, tp1,xip,movs] = transportMode(ch,minH)
%clear all
chs = {'rt1','rt2','rt3','rt4','rt5','rt6'};
ohm = [51.8,49.9,47.4,47.1,47.6,46.9];

r = 0.15e-3;
%R = 15e-3;
R = [20,20*5/7,20*6/7,20*5/7,20/7,20*5/7]/20;
q = 1.602e-19;
mi = 6.644e-27; % helium
%mi = 1.674e-27; %Hydrogen


d = read_NORTH_data(3222,chs{ch});
dmin = 30000;
dmax = 90000;

t1 = d.Time(dmin:dmax);
d1 = -d.Data(dmin:dmax);
d1 = d1/R(ch);
t1(41600:41720) = [];
d1(41600:41720) = [];
movs = movmin(d1,100);
d1 = d1 - movs;
%d1 = d1/max(d1);
% figure;
% plot(t1,d1)
% hold on
[pks, Loc] = findpeaks(d1,'MinPeakDistance',30,'MinPeakHeight',minH*max(d1));
Loc = Loc(2:end);
% plot(t1(Loc),d1(Loc),'*');

minima = islocalmin(d1);
minima = minima & [d1 < 0.2];
%plot(t1(minima),d1(minima),'*');
mins = [];
for i=1:length(Loc)
    a = minima(1:Loc(i))*1;
    [p,L] = findpeaks(a);
    mins(end+1) = L(end);
end
maxs=[];
for i=1:length(mins)-2
    b = mins(i):mins(i+2);
    if (length(b) > 2)
        [p,L] = findpeaks(d1(b),'MinPeakHeight',0.45*max(d1(b)));
        maxs(end+1) = min(b)+L(1)-1;
    end

end
% plot(t1(mins),d1(mins),'*')
% plot(t1(maxs),d1(maxs),'*')
%plot(t1,movmean(d1,10))
%plot(t2,movmean(d2,10))
%
% figure;
% hold on
xip = -0.2:0.0006:0.4;
xp1 = [];
tp1 = [];
mins = unique(mins(:).');
maxs = unique(maxs(:).');
for j=1:length(mins)-2
    ss = find(t1(maxs)>t1(mins(j)));
    if (abs(mean(t1(mins(j):mins(j+1))-t1(maxs(ss(1))))) < 0.2  )
        %         plot(t1(mins(j)-5:mins(j+1))-t1(maxs(ss(1))),d1(mins(j)-5:mins(j+1)))
        x1 = t1(mins(j)-5:mins(j+1))-t1(maxs(ss(1)));
        y1 = d1(mins(j)-5:mins(j+1));
        xp1(end+1,:) = interp1(x1,y1,xip);
        tp1(end+1) = t1(mins(j));
    end

end




% interp1(x1,y1,xip)
% interpmean1 = mean(xp1);
% interpmean2 = mean(xp2);
% figure;
% hold on
% %plot(xip,interpmean2)
% plot(xip,mean(xp2(1:60,:)))
% plot(xip,mean(xp2(60:120,:)))
% plot(xip,mean(xp2(120:180,:)))
% plot(xip,mean(xp2(180:end,:)))
% legend('1','2','3','4')
% xlabel('\tau [ms]')
% ylabel('Isat normalized')


% figure;
% hold on
% %plot(xip,interpmean2)
%
% cols = parula(12);
% for i=1:12
%     col = cols(i,:);
%     plot(xip,mean(xp2(1+(i-1)*20:20+(i-1)*20,:)),'Color',col)
% end
% xlabel('\tau [ms]')
% ylabel('Isat normalized')

end