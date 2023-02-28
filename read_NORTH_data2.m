function [struct1] = read_NORTH_data2(shot,diag)
%
% [struct1] = read_NORTH_data(shot,diag)
%
% diag list:
%
% - 'itf'   : toroidal field current
% - 'light' : photo diode light
% - 'pow1'  : power from microwave 1 - LFS  
% - 'pow2'  : power from microwave 1 - HFS  
% - 'req1'  : request power from microwave 1 - LFS  
% - 'req2'  : request power from microwave 1 - HFS  
% - 'pres'  : torus pressure  
% - 'bias'  : Langmuir bias voltage  
% - 'ilan'  : Langmuir current  
% - 'man'   : position of manupiltor arm (mm)
%


struct1 = [];
scal = 1;
Myoperation = [];

if strcmp(diag(1:2),'rt')
    channel = ['ch' diag(3)];
   
    if length(diag) > 3
        if strcmp(lower(diag(4)),'s')
                    Myoperation = 'SpecGram';   
        end
    end
     diag = 'rt';               
end



if strcmp(diag(1:2),'rn')
    channel = ['ch' diag(3:end)];
    diag = 'rn';
end

if strcmp(diag(1:2),'rp')
    channel = str2num([diag(3)]);
    diag = 'rp';
end

switch lower(diag)
    case 'itf'
        filetype = 'crio';
        channel = 'I_TF';
        struct1.name = 'Toroidal field current';
        struct1.unit = 'A';
        
    case 'ip'
        filetype = 'rt';
        channel = 'ch1';
        struct1.name = 'Ip';
        struct1.unit = 'a.u.';   
       % Myoperation = 'RMoffset_cumsum_calTF';
        Myoperation = 'RMoffset_cumsum';
%        Myoperation = 'cumsum';
        
             
    case 'rogs'
        filetype = 'rt';
        channel = 'ch7';
        struct1.name = 'Spec';
        struct1.unit = 'a.u.';   
       % Myoperation = 'RMoffset_cumsum_calTF';
%        Myoperation = 'RMoffset_cumsum';
        Myoperation = 'SpecGram';   
        
    case 'light' 
        filetype = 'crio';
        channel = 'Light';
        struct1.name = 'photo diode';
        struct1.unit = 'V';
        
    case 'pow2' 
        filetype = 'crio';
        channel = 'HFS_Power';
        struct1.name = 'Forward power HFS';
        struct1.unit = 'W';
        
    case 'pow1' 
        filetype = 'crio';
        channel = 'Microwave_Power';
        struct1.name = 'Forward power LFS';
        struct1.unit = 'W';
        
    case 'ipf1' 
        filetype = 'crio';
        channel = 'IPF1';
        struct1.name = 'Forward power LFS';
        struct1.unit = '6 A';
        
    case 'ref1' 
        filetype = 'crio';
        channel = 'Reflected_Power';
        struct1.name = 'Reflected_Power LFS';
        struct1.unit = 'W';
                
      %  Reflected_Power
    case 'req2' 
        filetype = 'crio';
        channel = 'HFSset';
        struct1.name = 'Req power HFS';
        struct1.unit = 'W';
        
    case 'req1' 
        filetype = 'crio';
        channel = 'LFSset';
        struct1.name = 'Req power LFS';
        struct1.unit = 'W'; 
        
    case 'pres' 
        filetype = 'crio';
        channel = 'Pressure';
        struct1.name = 'Pressure';
        struct1.unit = 'mbar';
         

    case 'bias' 
        filetype = 'rt';
        channel = 'ch0';
        struct1.name = 'Bias potential';
        struct1.unit = 'V';   
        scal = -10;

    case 'ilan' 
 
        channel = 2;
        struct1.name = 'Langmuir CUrrent';
        struct1.unit = 'mA';
        scal = 1000/220;
        filetype = 'rp';
        %struct1.name = ['RP - ' num2str(channel)];
    
    case 'vfl' 
        filetype = 'rt';
        channel = 'ch1';
        struct1.name = 'Floating potential';
        struct1.unit = 'V';   
        
        
    case 'rog' 
        filetype = 'rt';
        channel = 'ch7';
        struct1.name = 'Rogovski';
        struct1.unit = 'V';   
        
    case 'gas' 
        filetype = 'crio';
        channel = 'Gas';
        struct1.name = 'gas puf';
        struct1.unit = 'a.u.';   

    case 'lanpos' 
        filetype = 'crio';
        channel = 'Gas';
        struct1.name = 'gas puf';
        struct1.unit = 'a.u.';   
    
    case 'te' 
        filetype = 'jsonL';
        channel = 'Te';
        struct1.name = 'Te';
        struct1.unit = 'eV';  

    case 'ne' 
        filetype = 'jsonL';
        channel = 'ne';
        struct1.name = 'Ne';
        struct1.unit = 'm-3 10E15';  
        scal = 1e-15;
        
    case 'rt'
        filetype = 'rt';
        struct1.name = ['RT - ' num2str(channel)];
        struct1.unit = 'v'; 

   case 'rn'
        filetype = 'rn';
        struct1.name = ['RTN - ' num2str(channel)];
        struct1.unit = 'v'; 

    case 'rp'
        filetype = 'rp';
        struct1.name = ['RP - ' num2str(channel)];
        struct1.unit = 'v'; 

    case 'man'
 
        filetype = 'crio';
        channel = 'Manarm';
        struct1.name = 'Manipulator position';
        struct1.unit = 'mm';   
        
        
    otherwise
        
        disp('Please provide correct input')
        %read_NORTH_data
        error(['> Input ' diag ' not found'])
end


if strcmp(filetype,'crio')
    aa = TDMS_getStruct(['/zhome/projects/NORTH/ControlData/CRIO' num2str(shot) '.tdms']);
    struct1.Data = eval(['scal*aa.Data.' channel '.data;']);
    struct1.Time = aa.Data.Time.data;
    if length(struct1.Data) == 1
        struct1.Data = double(struct1.Data) + LangmuirMeasurementsstruct1.Time * 0;
    end
elseif strcmp(filetype,'rt')
    aa = TDMS_getStruct(['/zhome/projects/NORTH/DiagRT/diag' num2str(shot) '.tdms']);
    struct1.Data = eval(['scal*aa.data.' channel '.data;']);
    struct1.Time = (0:1/aa.aux.sampletime.data:(length(struct1.Data)-1)/aa.aux.sampletime.data)*1000;
    struct1.Time = (0:1/102400:(length(struct1.Data)-1)/102400)*1000;
elseif strcmp(filetype,'rn')
    aa = TDMS_getStruct(['/zhome/projects/NORTH/DiagRT/diag' num2str(shot) '_6255.tdms']);
    struct1.Data = eval(['scal*aa.data.' channel '.data;']);
    struct1.Time = 0.36+(0:1/200000:(length(struct1.Data)-1)/200000)*1000;
    struct1.Time = 0.36+(0:1/85106:(length(struct1.Data)-1)/85106)*1000;

elseif strcmp(filetype,'json')
    fname = ['/zhome/projects/NORTH/DiagRP/Redpitaya01_' num2str(shot) '.json'];
    fid = fopen(fname); 
    if fid > 1
        raw = fread(fid,inf); 
        str = char(raw'); 
        fclose(fid); 
        val = jsondecode(str);struct1.Data = val*scal;
        struct1.Time = ((1.074/16384:1.074/16384:1.074)+0.00045)*1000;
    else
        warning(['file ' fname 'not found'])
        error('Error in read_NORTH_data.m')
    end

    
elseif strcmp(filetype,'jsonL')
    fname = ['/zhome/projects/NORTH/Analysis/Langmuir/' channel num2str(shot) '.json'];
    fid = fopen(fname); 
    if fid > 1
        raw = fread(fid,inf); 
        str = char(raw'); 
        fclose(fid); 
        val = jsondecode(str);struct1.Data = val*scal;
    else
        warning(['file ' fname 'not found'])
        error('Error in read_NORTH_data.m')
    end
    
    fname = ['/zhome/projects/NORTH/Analysis/Langmuir/Time' num2str(shot) '.json'];
    fid = fopen(fname); 
    if fid > 1
        raw = fread(fid,inf); 
        str = char(raw'); 
        fclose(fid); 
        val = jsondecode(str);struct1.Time = 1000*val;
    else
        warning(['file ' fname 'not found'])
        error('Error in read_NORTH_data.m')
    end
    

    

elseif strcmp(filetype,'rp')
    fname = ['/zhome/projects/NORTH/DiagRP/Redpitaya01_' num2str(shot) '.json'];
    fid = fopen(fname); 
    if fid > 1
        raw = fread(fid,inf); 
        str = char(raw'); 
        fclose(fid); 
        val = jsondecode(str);struct1.Data = val(channel,:)*scal;
        DD = (8192*2)/(125e6/8192);
        struct1.Time =  ((1.074/15259:1.074/15259:1.074)-0.0038)*1000;
        struct1.Time =  ((DD/16384:DD/16384:DD)-0.0038)*1000;
        %struct1.Time = ((1.074/16384:1.074/16384:1.074))*1000;
        %struct1.Time = ((1.074/16384:1.074/16384:1.074)+0.10045-0.0003)*1000;
    else
        warning(['file ' fname 'not found'])
        error('Error in read_NORTH_data.m')
    end

end


if ~isempty(Myoperation)
    if strcmp(Myoperation,'cumsum')
        struct1.Data = cumsum(struct1.Data);
    end
        if strcmp(Myoperation,'RMoffset_cumsum')
            struct1.Data = struct1.Data - (mean(struct1.Data(2:4000)));
            struct1.Data = cumsum(struct1.Data);
        end
    if strcmp(Myoperation,'RMoffset_cumsum_calTF')
            struct1.Data = struct1.Data - (mean(struct1.Data(1:50)));
            struct1.Data = cumsum(struct1.Data);
            bb = read_NORTH_data(shot,'itf');
            indx = round(interp1(bb.Time,1:length(bb.Time),[0 100])); % time at 0 and 50 ms
            if isnan(indx(1)) indx(1) = 1;end; 
            %offset = -10:0.1:10;
            %for i = 1:length(offset)
            offset = -2.1;  
            indy = round(interp1(struct1.Time+offset,1:length(struct1.Time),bb.Time(indx(1):indx(2))));
           % figure(65);clf;grid on;plot(bb.Data(indx(1):indx(2)),struct1.Data(indy),'*')
            [a,b] = polyfit(bb.Data(indx(1):indx(2)),struct1.Data(indy),1);
            %bbb(i) = a(2);
            %end
           
            ITFval = interp1(bb.Time,bb.Data,struct1.Time+offset);
            struct1.Data = struct1.Data - polyval(a,ITFval);
            %end
            
    end
    if strcmp(Myoperation,'SpecGram')
        [bb,ff,tt] = specgram(struct1.Data,1024/0.5,1/((struct1.Time(2)-struct1.Time(1))*1e-3)); % from the matlab
        struct1.zz = 10*log10(abs(bb));
        struct1.xx = (tt+0.5*(tt(2)-tt(1)))*1e3;
        struct1.yy = ff*1e-3;
        structt.yy_label = 'Frequency (kHz)'
        structt.xx_label = 'Time (ms)'
        struct1.yy_label = 'Frequency (kHz)'
        
    end
end


