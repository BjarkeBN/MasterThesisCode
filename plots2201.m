%2201

ilan = read_NORTH_data(2201,'rp1');
ilan = ilan.Data;
fs = 122000;
ProbeOldModes2 = figure;
spectrogram(ilan,300,[],[],fs,'yaxis');

title('Spectrogram of probe current, Shot#2201')

colormap('jet')
%ProbeOldModes2
exportgraphics(ProbeOldModes2, 'ProbeOldModes2201.pdf', 'ContentType', 'vector'); 



rog = read_NORTH_data(2201,'rt2');
rog = rog.Data;

ProbeOldModes2spec=figure;
[pxxi,fsi] = pwelch(ilan(1100:end),300,[],[],fs);
[pxxr,fsr] = pwelch(rog(1100:69000),300,[],[],102400);

%semilogy(fsr,pxxr)

semilogy(fsi(6:end),pxxi(6:end))
hold on
semilogy(fsr(6:end),pxxr(6:end))
legend('Probe current','Rogovski coil')
title('Power density, Welchs method, Shot#2201')
xlabel('Frequency [Hz]')
ylabel('Power')
exportgraphics(ProbeOldModes2spec, 'ProbeOldModes2201spec.pdf', 'ContentType', 'vector'); 


ProbeOldModes2201All = figure;
subplot(2,1,1);
spectrogram(ilan,300,[],[],fs);
colorbar('off')

title('Spectrogram of probe current, Shot#2201')

colormap('jet')
subplot(2,1,2);

semilogy(fsi(6:end),pxxi(6:end))
hold on
semilogy(fsr(6:end),pxxr(6:end))
legend('Probe current','Rogovski coil')
title('Power density, Welchs method, Shot#2201')
xlabel('Frequency [Hz]')
ylabel('Power')
xlim([0 61120])

exportgraphics(ProbeOldModes2201All, 'ProbeOldModes2201spec.pdf', 'ContentType', 'vector'); 


