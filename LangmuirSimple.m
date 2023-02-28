
shot = 2817;
ch = 'rt2';
plotall = 0;

VAfterVf = 10;
sf = 102400;
Hz = 1000;

dv = read_NORTH_data(shot,'rt0');
di = read_NORTH_data(shot,ch);
%dv = read_NORTH_data(shot,'bias');
%di = read_NORTH_data(shot,'ilan');
dt = di.Time;
di = di.Data/48/20*1000; %mA%
%di = di.Data;
dv = dv.Data*-10; %V
%dv = dv.Data;

%di = di(17900:18000);
%dv = dv(17900:18000);

offset = 0;

sgrad = zeros(length(dv),1);
sgrad(2:end-1) = (dv(3:end)-dv(1:end-2))/2;
sgrads = sign(sgrad);

index_minV = [];
index_maxV = [];

%Find start of plasma
index_plasmaOn = find(movmean(di,floor(sf/Hz)) > offset*3.5);
if (length(index_plasmaOn) == 0)
    disp('Cant find plasma')
end
%ignores the first and last 2 sweeps with plasma.
index_plasmaStart = index_plasmaOn(3);
index_plasmaEnd = index_plasmaOn(end-2);

for i=index_plasmaStart:index_plasmaEnd-1

    if sgrads(i-1) == -1
       
        di(i-1) = di(i-1) +offset;
        if sgrads(i) == 1
                if(dv(i) < -9)
                    index_minV(end+1) = i;
                end
        end
    end
   
    if sgrads(i-1) == 1
        di(i-1) = di(i-1) -offset;
        if sgrads(i) == -1
                if(dv(i) > 9)
                    index_maxV(end+1) = i;
                end
        end
    end
    if sgrads(i) == 0
            if(dv(i) < -9)
                index_minV(end+1) = i;
            end
            if(dv(i) > 9)
                index_maxV(end+1) = i;
            end
    end
   
end

index_minVtrim = [];
index_maxVtrim = [];


%index_start = [];
%index_end = [];
%for i=1:length(index_maxVtrim)-1
%    if (index_maxVtrim(i) - index_minVtrim(i) < 0 && abs(index_maxVtrim(i) - index_minVtrim(i)) < sf/Hz/2+10)
%        index_start(end+1) = index_maxVtrim(i);
%        index_end(end+1) = index_minVtrim(i);
%    elseif (index_maxVtrim(i) - index_minVtrim(i+1) < 0 && abs(index_maxVtrim(i) - index_minVtrim(i+1)) < sf/Hz/2+10)
%        index_start(end+1) = index_maxVtrim(i);
%        index_end(end+1) = index_minVtrim(i+1);
%    end
%end


if index_minV(1) > index_maxV(1)
    index_start = index_maxV;
    index_end = index_minV;
else
    index_start = index_maxV(1:end-1);
    index_end = index_minV(2:end);
end

f = fittype('a*(1-exp((x-b)/c))');


Is = zeros(min(length(index_start),length(index_end)),1);
vf = zeros(min(length(index_start),length(index_end)),1);
Te = zeros(min(length(index_start),length(index_end)),1);
Is_err = zeros(min(length(index_start),length(index_end)),1);
vf_err = zeros(min(length(index_start),length(index_end)),1);
Te_err = zeros(min(length(index_start),length(index_end)),1);
SSE = zeros(min(length(index_start),length(index_end)),1);
times = zeros(min(length(index_start),length(index_end)),1);

for i=1:min(length(index_start),length(index_end))
    FirstVbeforeVf = dv(index_start(i)+find(di(index_start(i):index_end(i)-1) < 0,1)-1);
    VUnder_FirstVbeforeVf_Plus_VAfterVf = find(dv(index_start(i):index_end(i)-1) < FirstVbeforeVf + VAfterVf);
    Vu = VUnder_FirstVbeforeVf_Plus_VAfterVf;
   
    coff = 0;

    [fobj,gof,~] = fit(transpose(dv(index_start(i)-1+Vu(1:end-coff))),transpose(di(index_start(i)-1+Vu(1:end-coff))),f,'Lower',[-1,-20,1],'Upper', [0,10,200],'Startpoint',[-0.5,0,2]);
    k = confint(fobj,0.682); %1 std;
    Is(i) = fobj.a;
    vf(i) = fobj.b;
    Te(i) = fobj.c;
    Is_err(i) = -(k(1)-k(2))/2;
    vf_err(i) = -(k(3)-k(4))/2;
    Te_err(i) = -(k(5)-k(6))/2;
    SSE(i) = gof.sse;
    times(i) = dt(floor((index_start(i)+index_end(i))/2));
    if (plotall == 1)
        if (Te_err(i) < 0.3)
           figure;
           plot(fobj)
           hold on
           plot(dv(index_start(i):index_end(i)-1),di(index_start(i):index_end(i)-1),'*')
           title( append(num2str(index_start(i)),' to ',num2str(index_end(i)),num2str(i)))
           coeffs = {'Is','Vf','Te'};
           str1 = sprintf('\n %s = %0.3f pm %0.3f',coeffs{1},Is(i),Is_err(i));
           str2 = sprintf('\n %s = %0.3f pm %0.3f',coeffs{2},vf(i),vf_err(i));
           str3 = sprintf('\n %s = %0.3f pm %0.3f',coeffs{3},Te(i),Te_err(i));
           annotation('textbox',[.2 .6 .3 .2],'String',['Fitting coefficients: ', str1,str2,str3]);
        end
    end
   
   
end
r = 0.5e-3;
R = 2e-3;
area = pi*r*r+2*pi*r*R;
q = 1.602e-19;
mi = 6.644e-27; % helium
%mi = 1.674e-27; %Hydrogen



ne = -Is./1000./area./q.*sqrt(mi/2./Te)./sqrt(q);
ne_err = ne.*sqrt((Is_err./Is).^2 + (0.5*Te_err./Te).^2);


struct.ne = ne;
struct.ne_err = ne_err;
struct.Te = Te;
struct.Te_err = Te_err;
struct.vf = vf;
struct.vf_err = vf_err;
struct.times = times;
struct.di = di;
struct.dt = dt;
struct.sse = SSE;
