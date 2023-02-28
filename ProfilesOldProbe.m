


d = 37-[0,2,4,6,8,10,12,14,16,17,18];
ne = [2+5/40,2+26/40,2+23/40,3+8/40,3+12/40,4+5/40,5+8/40,6+8/40,6+4/40,6+13/40,6+8/40]*10^15;
ne_err = [26,47,53,50,76,56,84,72,56,54,50]/40/2*10^15;
ProfileOlda=figure;
errorbar(d,ne,ne_err,'*')
title('Electron density from fitted data')
ylabel('Electron density [m$^{-3}$]','Interpreter','latex')
xlabel('Probe position [cm]')
xlim(37-[18.5,-0.5])
grid on
ylim([0,8*10^15])
%ProfileOlda
exportgraphics(ProfileOlda, 'ProfileOlda.pdf', 'ContentType', 'vector'); 


vf = 2*[144,129,100,124,140,145,190,218,223,208,203]/-40;
vf_err = 2*[112,93,46,39,76,82,144,174,182,166,161]/-40;
vf_err = vf_err-vf;
ProfileOldb=figure;
errorbar(d,vf,vf_err,'*')
title('Floating potential from fitted data')
ylabel('Floating potential [V]')
xlabel('Probe position [cm]')
xlim(37-[18.5,-0.5])
grid on
exportgraphics(ProfileOldb, 'ProfileOldb.pdf', 'ContentType', 'vector'); 

Te = 6-[60,83,107,142,117,160,162,153,128,135,145]/2/46.5;
Te_err = 6-[13,18,13,31,33,71,85,76,38,53,56]/2/46.5;
Te_err = Te_err-Te;
ProfileOldc=figure;
errorbar(d,Te,Te_err,'*')
title('Electron temperature from fitted data')
ylabel('Electron temperature [eV]')
xlabel('Probe position [cm]')
ylim([0,6])
xlim(37-[18.5,-0.5])
grid on
exportgraphics(ProfileOldc, 'ProfileOldc.pdf', 'ContentType', 'vector'); 

pres = (8-20/38*2+[82,31,38,64,45,53,46,28,12,15,31]/19)*10^-4;
ProfileOldd=figure('Position',[100,100,560,200]);
plot(d,pres,'*')
title('Mean pressure during measurements')
ylabel('Pressure [mBar]')
xlabel('Probe position [cm]')
%ylim([0,6])
xlim(37-[18.5,-0.5])
grid on
exportgraphics(ProfileOldd, 'ProfileOldd.pdf', 'ContentType', 'vector'); 





