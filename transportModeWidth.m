[xp1,tp1,~,movs] = transportMode(1,0.2);
[xp2,tp2,~,~] = transportMode(2,0.15);
[xp3,tp3,~,~] = transportMode(3,0.15);
[xp4,tp4,~,~] = transportMode(4,0.1);
[xp5,tp5,xip,~] = transportMode(5,0.15);


% for i=1:length(tp2)
%     if (abs(tp2(i)-tp1(i)) < 0.25)
%         figure;
%         plot(xp1(i,:));
%         hold on
%         plot(xp2(i,:));
%     end
% 
% 
% 
% end

% figure;
% hold on
% plot(xip,mean(xp1,'omitnan'));
% findpeaks(mean(xp1),xip,'Annotate','extents','WidthReference','halfheight')
% figure;
% hold on
% plot(xip,mean(xp2,'omitnan'));
% findpeaks(mean(xp2),xip,'Annotate','extents','WidthReference','halfheight')
% figure;
% hold on
% plot(xip,mean(xp3,'omitnan'));
% %findpeaks(mean(xp3),xip,'Annotate','extents','WidthReference','halfheight')
% figure;
% hold on
% plot(xip,mean(xp4,'omitnan'));
% findpeaks(mean(xp4),xip,'Annotate','extents','WidthReference','halfheight')
% figure;
% hold on
% plot(xip,mean(xp5,'omitnan'));
% findpeaks(mean(xp5),xip,'Annotate','extents','WidthReference','halfheight')



% figure;
% plot(xip,mean(xp1,'omitnan')/max(mean(xp1,'omitnan')));
% hold on
% plot(xip,mean(xp2,'omitnan')/max(mean(xp2,'omitnan')));
% plot(xip,mean(xp3,'omitnan')/max(mean(xp3,'omitnan')));
% plot(xip,mean(xp4,'omitnan')/max(mean(xp4,'omitnan')));
% plot(xip,mean(xp5,'omitnan')/max(mean(xp5,'omitnan')));
% legend('1','2','3','4','5')

ModeProfile = figure;
plot(xip,mean(xp1(1:floor(end/5),:),'omitnan')/max(mean(xp1(1:floor(end/5),:),'omitnan')));
hold on
plot(xip,mean(xp2(1:floor(end/5),:),'omitnan')/max(mean(xp2(1:floor(end/5),:),'omitnan')));
plot(xip,mean(xp3(1:floor(end/5),:),'omitnan')/max(mean(xp3(1:floor(end/5),:),'omitnan')));
plot(xip,mean(xp4(1:floor(end/5),:),'omitnan')/max(mean(xp4(1:floor(end/5),:),'omitnan')));
plot(xip,mean(xp5(1:floor(end/5),:),'omitnan')/max(mean(xp5(1:floor(end/5),:),'omitnan')));
legend('Probe-tip 1','Probe-tip 3','Probe-tip 5','Probe-tip 6','Probe-tip 7')
xlabel('\tau [ms]')
ylabel('Density [Normalized]')
title('Average profile of periodic blobs, shot#3222')

exportgraphics(ModeProfile, 'ModeProfile.pdf', 'ContentType', 'vector');

% figure;
% plot(xip,mean(xp1(floor(end/5*4):end,:),'omitnan')/max(mean(xp1(floor(end/5*4):end,:),'omitnan')));
% hold on
% plot(xip,mean(xp2(floor(end/5*4):end,:),'omitnan')/max(mean(xp2(floor(end/5*4):end,:),'omitnan')));
% plot(xip,mean(xp3(floor(end/5*4):end,:),'omitnan')/max(mean(xp3(floor(end/5*4):end,:),'omitnan')));
% plot(xip,mean(xp4(floor(end/5*4):end,:),'omitnan')/max(mean(xp4(floor(end/5*4):end,:),'omitnan')));
% plot(xip,mean(xp5(floor(end/5*4):end,:),'omitnan')/max(mean(xp5(floor(end/5*4):end,:),'omitnan')));
% legend('1','2','3','4','5')
smoothw = 1;
ws1 = [];
ps1 = [];
for i=1:length(xp1(:,1))
    [~,~,w,~] = findpeaks(smooth(xp1(i,:),smoothw),'SortStr','descend');
    ws1(i) = w(1);
    ps1(i) = max(xp1(i,:));
end



ws2 = [];
ps2 = [];
for i=1:length(xp2(:,1))
    [~,~,w,~] = findpeaks(smooth(xp2(i,:),smoothw),'SortStr','descend');
    ws2(i) = w(1);
    ps2(i) = max(xp2(i,:));
end
ws3 = [];
ps3 = [];
for i=1:length(xp3(:,1))
    [~,~,w,~] = findpeaks(smooth(xp3(i,:),smoothw),'SortStr','descend');
    ws3(i) = w(1);
    ps3(i) = max(xp3(i,:));
end
ws4 = [];
ps4 = [];
for i=1:length(xp4(:,1))
    if (i~= 610)
        [~,~,w,~] = findpeaks(smooth(xp4(i,:),smoothw),'SortStr','descend');
        ws4(i) = w(1);
        ps4(i) = max(xp4(i,:));
    end
end
ws5 = [];
ps5 = [];
for i=1:length(xp5(:,1))
    [~,~,w,~] = findpeaks(smooth(xp5(i,:),smoothw),'SortStr','descend');
    ws5(i) = w(1);
    ps5(i) = max(xp5(i,:));
end

indToTime = 0.0006;

BlobWidth = figure;
% plot(tp1,ws)
hold on
meanwidth=200;
plot(tp1,movmean(ws1,meanwidth)*indToTime)
plot(tp2,movmean(ws2,meanwidth)*indToTime)
plot(tp3,movmean(ws3,meanwidth)*indToTime)
plot(tp4,movmean(ws4,meanwidth)*indToTime)
plot(tp5,movmean(ws5,meanwidth)*indToTime)
legend('Probetip 1','Probetip 3','Probetip 5','Probetip 6','Probetip 7');
ylabel('Width at half prominence of blob [ms]')
xlabel('Time [ms]')
title('Widths of blobs measured by probes')

exportgraphics(BlobWidth, 'BlobWidth.pdf', 'ContentType', 'vector'); 

BlobHeight = figure;
% plot(tp1,ws)
hold on
meanwidth=200;
plot(tp1,movmean(ps1,meanwidth))
plot(tp2,movmean(ps2,meanwidth))
plot(tp3,movmean(ps3,meanwidth))
plot(tp4,movmean(ps4,meanwidth))
plot(tp5,movmean(ps5,meanwidth))
legend('Probetip 1','Probetip 3','Probetip 5','Probetip 6','Probetip 7');
xlabel('Time [ms]')
ylabel('Prominence of blob [mA]')
title('Height of blobs measured by probes')

exportgraphics(BlobHeight, 'BlobHeight.pdf', 'ContentType', 'vector'); 



blobCompare = figure;
subplot(2,1,1)

d = read_NORTH_data(3222,'rt1');
dmin = 30000;
dmax = 90000;

t1 = d.Time(dmin:dmax);
d1 = -d.Data(dmin:dmax);
% d1 = d1/R(ch);
t1(41600:41720) = [];
d1(41600:41720) = [];
movs = movmin(d1,100);
d1 = d1 - movs;
plot(t1(1:400),d1(1:400))
xlabel('Time [ms]')
ylabel('Density [Normalized]')
legend('Periodic blobs from modes')
grid on
title('Comparison of blobs in two different regimes')
subplot(2,1,2)
plot(t1(39000:39400),d1(39000:39400))
xlabel('Time [ms]')
ylabel('Density [Normalized]')
legend('Irregular blobs')
grid on


exportgraphics(blobCompare, 'blobCompare.pdf', 'ContentType', 'vector'); 
