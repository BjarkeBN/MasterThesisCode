function plotshot2(varargin)

% plot_shot(shot1,shot2,...,aux,aux,aux,...,option,option)
%
%
% example to work on NORTH:
%
%    plotshot(1644,'itf','light')
%
%    plotshot(1644,1648,'itf','light')
%
%
%   examples of diagnostics:
%
%    'itf'
%         struct1.name = 'Toroidal field current';
%         struct1.unit = 'A';
%
%      'light'
%         struct1.name = 'photo diode';
%         struct1.unit = 'V';
%
%      'pow2'
%         struct1.name = 'Forward power HFS';
%         struct1.unit = 'W';
%
%      'pow1'
%         struct1.name = 'Forward power LFS';
%         struct1.unit = 'W';
%
%      'pres'
%         struct1.name = 'Pressure';
%         struct1.unit = 'mbar';
%
%      'vfl'
%         struct1.name = 'Pressure';
%         struct1.unit = 'mbar';
%
%
%      'rog'
%         struct1.name = 'Rogovski';
%         struct1.unit = 'V';
%
%      'gas'
%         struct1.name = 'gas puf';
%         struct1.unit = 'a.u.';
%

if nargin == 0
    help plotshot
    return
end

machine = 'NORTH';
maxt = 0;
i = 1;
nshotentries = 0;
clear1 = 1;
shots = [];
while isnumeric(varargin{i})
    %if length(varargin{i}) > 1 % is array
    shots = [shots varargin{i}];
    %shots(i) = varargin{i};
    i = i + 1;
    nshotentries = nshotentries + 1;
end

if isempty(shots)
    error('Please supply shot numbers')
end

% save a jpg file
if findstrcell(varargin,'savefig')
    savefig=1;
else
    savefig=0;
end


% time to zoom
if findstrcell(varargin,'t=')
    eval(varargin{findstrcell(varargin,'t=')});
else
    t=[0 999];
end


nshots = length(shots);
for jjj = 1:length(shots) % main shot loop
    shot = shots(jjj);
    shotstr = num2str(shot);
    
    
    j = 1;
    hw = waitbar(0,'loading other data, please wait...')
    drawnow;
    for index = 1:length(varargin)-nshotentries % load data loop
        strbuf =  varargin{nshotentries+index};
        namebuf =  varargin{nshotentries+index};
        namebuf2{index} = namebuf;
        struct1 = read_NORTH_data2(shot,namebuf);
        %
        if ~isempty(struct1)
            data{j} = struct1;
            data{j}.callname = varargin{nshotentries+index};
            j = j +1;
        end
    end
    
    if jjj == 1
        h = figure;
        hold on;
        set(h,'units','normalized','position',[.25 .05 .5 .8]);
        %       set(gca,'linewidth',1.5,'fontsize',18)
        %uim1=uimenu('parent',gcf,'label','Update_xaxis','callback','textor_log_plot_update_xaxis');
        %uim1=uimenu('parent',gcf,'label','plot_gyr_time2','callback',['textor_log_add_gyr_time2(' shotstr ')']);
        plot_color = {'b','r','g','m','k','y',[0.3 .5 .1],[.0 1 0],[.2,0,.2]};
        
        setappdata(gcf,'shot',shot)
        
        m = uimenu(gcf,'Text','&LangmuirAnalysis');
        mitem = uimenu(m,'Text','&PlotIVcurve','Callback','IVplot');
        
    end
    
    
    
    
    close(hw);
    if ~exist('data') error('No data found for specified discharge!');end
    
    %plot the data
    %n = length(data);
    %    n = length(unique(setdiff(loginfo.plot_value,0))); % number of plots (different values - 0)
    n = j-1;
    fontsize = 10;
    
    linewidth = 1;
    figure(h)
    
    fig_no = [];
    %diag_1d = {'eceS','ece','hcn'};
    
    for i = 1:length(data)  % plot data loop
        try
            maxt = max([maxt,max(signal.Time)]);
        end
        signal = data{i};
        namebuf = namebuf2{i};
        if and(isfield(signal,'Time'), isfield(signal,'Data'));
            %           fig_no = [fig_no loginfo.plot_value(i)];
            fig_no = i;
            eval(['hf' num2str(i) ' = subplot(n,1,' num2str(fig_no(end)) ');']); % handle is called hf1, hf2, ...
            set(gca,'linewidth',1.5,'fontsize',17);
            cont1 = 1;

            if cont1
                if (isfield(signal,'zz'));
                    hold on
                    imagesc(signal.xx,signal.yy,signal.zz)
                    axis xy, colormap(jet)
                    colorbar
                    %contour(signal.Time,signal.Pos,signal.dat,20)
                    %colorbar;
                    twoD = 1;
                    set(gca,'tag','2D')
                    box on;
                else
                    dohold = find(fig_no(end) == fig_no) > 1;
                    dohold = 1;
                    if dohold hold on;end
                    
                    try
                        hplot = plot(signal.Time,signal.Data);
                    catch
                        hplot = plot([0 10],[0 0]);
                    end
                    
                    set(hplot,'color',plot_color{jjj});
                    twoD = 0;
                    set(gca,'tag','1D')
                    if dohold hold on;end
                end
                
                title1 = [signal.name];
                if length(signal.name) > 2
                    if strcmp(lower(signal.name(1:3)),'nbi')
                        if isfield(data{i},'gas')
                            title1 = [title1 ' (' data{i}.gas ')'] ;
                        end
                    end
                end
                %            if and(strcmp(title1,'Gas puff'), strcmp(dataname,'halpha'))
                %                title1 = 'H_{\alpha}'
                %            end
                %legend([title1])
                [LEGH,OBJH,OUTH,OUTM] = legend;
                if isempty(LEGH)% no legend existed create new legend
                    if ~twoD
                        hl = legend([ num2str(shot) ' - ' title1],'tag',['leg' num2str(i)]);
                    else
                        hl = text(0.9,0.95,title1,'units','normalized','BackgroundColor','w')
                    end
                else % append to existing legend
                    old_legend=findobj(gcf, 'tag', ['leg' num2str(i)]);
                    %legend([old_legend.String,[ num2str(shot) ' - ' title1]])
                    old_legend.String{end} = [ num2str(shot) ' - ' title1];
                    %OUTM{length(OUTM)+1} = [ num2str(shot) ' - ' title1];
                    %OUTH(length(OUTH)+1) = hplot;
                    %  hl = legend(OUTH,OUTM,3);
                end
                set(hl,'fontsize',12)
            end
            %     xlabel(['Time / ' signal.unit_Time])
            if isfield(signal,'units')
                %ylabel([data{i}.name ' / ' signal.units])
                ylabel([signal.units])
            end
            if isfield(signal,'unit')
                %ylabel([data{i}.name ' / ' signal.unit])
                ylabel([signal.unit])
            end
            aaa = axis;
            [val,ind] = max(abs(signal.Data));
            %           if signal.dat(ind) > 0;
            if mean(signal.Data) > 0;
                aaa(3) = 0; % do not show negetive data
            else
                aaa(4) = 0; % do not show positive data
            end
            if twoD
                aaa(3) = signal.yy(1);
                aaa(4) = signal.yy(end);
                axis([aaa(1) aaa(2) aaa(3) aaa(4)]);
            end
            if or(strcmp(signal.name(1:2),'DC'),strcmp(signal.callname(1:2),'Ip')) % DCN laser or Ip measurement shoud not go below 0
                try
                    axis([0 aaa(2) aaa(3) aaa(4)])
                catch
                    disp('fred crash')
                end
            end
            if and (jjj == 1, i == 1) % add title
                if nshots == 1
                    title(['NORTH #' shotstr]);
                else
                    title('NORTH Time Traces');
                end
            end
            grid on;
        end
    end
end

xlabel(['Time (ms)']);
set(gca,'XTickMode','auto')
%pic_format
%axis(hf1);
%get_machine;

if length(data) > 1
    if t(end) == 999
        t(end) = maxt;
    end
    samexaxis_north(t)
    %    LockXAxis
    set(gca,'XTickMode','auto');
end
TrackMousePos
AddPanTool('LockXAxis')
aa = findobj(gcf,'tag','2D');
bb = findobj(gcf,'tag','1D');
if ~isempty(bb)
    if ~isempty(aa)    
        for i = 1:length(aa)
            aa(i).Position(3) = bb(1).Position(3);% for 2D plots on same x-width as 1D plots
        end
    end
end
if savefig
    eval(['print -djpeg timetraces' num2str(shot)]);
end




set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
%set(gcf, 'PaperPosition', [10 20 15 20]);
set(gcf, 'PaperPosition', [20 15 20 15]);

function addLegend(title1,shot,hplot)

[LEGH,OBJH,OUTH,OUTM] = legend;
if isempty(LEGH)% no legend existed create new legend
    hl = legend([ num2str(shot) ' - ' title1]);
else % append to existing legend
    %OUTM{length(OUTM)+1} = [ num2str(shot) ' - ' title1];
    %OUTH(length(OUTH)+1) = hplot;
    %hl = legend(OUTH,OUTM);
    old_legend=findobj(gcf, 'Type', 'Legend')
    legend([old_legend.String,[ num2str(shot) ' - ' title1]])
    
end
set(h1,'fontsize',16)

