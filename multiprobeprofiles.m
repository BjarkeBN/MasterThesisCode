clear variables





rt1 = IV_Analysis_Simple(3192,'rt1');
rt2 = IV_Analysis_Simple(3192,'rt2');
rt3 = IV_Analysis_Simple(3192,'rt3');
rt4 = IV_Analysis_Simple(3192,'rt4');
rt5 = IV_Analysis_Simple(3192,'rt5');
rt6 = IV_Analysis_Simple(3192,'rt6');

for i=1:188
    f = 189-i;
    if ((mod(rt1.times(f)+1,100) < 2) || (mod(rt1.times(f)-29,100) < 2))
        rt1.times(f) = [];
        rt1.Te(f) = [];
        rt1.ne(f) = [];

    elseif (rt1.times(f) > 899 || rt1.times(f) < 203)
        rt1.times(f) = [];
        rt1.Te(f) = [];
        rt1.ne(f) = [];
    end
    if ((mod(rt2.times(f)+1,100) < 2) || (mod(rt2.times(f)-29,100) < 2))
        rt2.times(f) = [];
        rt2.Te(f) = [];
        rt2.ne(f) = [];
    elseif (rt2.times(f) > 899 || rt2.times(f) < 203)
        rt2.times(f) = [];
        rt2.Te(f) = [];
        rt2.ne(f) = [];
    end
    if ((mod(rt5.times(f)+1,100) < 2) || (mod(rt5.times(f)-29,100) < 2))
        rt5.times(f) = [];
        rt5.Te(f) = [];
        rt5.ne(f) = [];

    elseif (rt5.times(f) > 899 || rt5.times(f) < 203)
        rt5.times(f) = [];
        rt5.Te(f) = [];
        rt5.ne(f) = [];
    end

    if (i ~= 1)
        if ((mod(rt6.times(f)+1,100) < 2) || (mod(rt6.times(f)-29,100) < 2))
            rt6.times(f) = [];
            rt6.Te(f) = [];
            rt6.ne(f) = [];

        elseif (rt6.times(f) > 899 || rt6.times(f) < 203)
            rt6.times(f) = [];
            rt6.Te(f) = [];
            rt6.ne(f) = [];
        end
    end
end

for i=1:170
    f = 171-i;
    if ((mod(rt3.times(f)+1,100) < 2) || (mod(rt3.times(f)-29,100) < 2))
        rt3.times(f) = [];
        rt3.Te(f) = [];
        rt3.ne(f) = [];
    elseif (rt3.times(f) > 899 || rt3.times(f) < 203)
        rt3.times(f) = [];
        rt3.Te(f) = [];
        rt3.ne(f) = [];
    end
    if ((mod(rt4.times(f)+1,100) < 2) || (mod(rt4.times(f)-29,100) < 2))
        rt4.times(f) = [];
        rt4.Te(f) = [];
        rt4.ne(f) = [];
    elseif(rt4.times(f) > 899 || rt4.times(f) < 203)
        rt4.times(f) = [];
        rt4.Te(f) = [];
        rt4.ne(f) = [];
    end
    
end




Te = figure;
hold on
meanWindow = 40;
plot(rt1.times,movmean(rt1.Te,meanWindow))
plot(rt2.times,movmean(rt2.Te,meanWindow))
plot(rt3.times,movmean(rt3.Te,meanWindow))
plot(rt4.times,movmean(rt4.Te,meanWindow))
plot(rt5.times,movmean(rt5.Te,meanWindow))
plot(rt6.times,movmean(rt6.Te,meanWindow))
xlabel('Time [ms]')
ylabel('Temperature [eV]')
title('Electron temperature over time, shot#3192')
legend('Probetip 1','Probetip 3','Probetip 5','Probetip 6','Probetip 7','Probetip 12')
exportgraphics(Te, 'TeLpa.pdf', 'ContentType', 'vector'); 


ne = figure;
hold on
meanWindow = 12;
plot(rt1.times,movmean(rt1.ne,meanWindow))
plot(rt2.times,movmean(rt2.ne,meanWindow))
plot(rt3.times,movmean(rt3.ne,meanWindow))
plot(rt4.times,movmean(rt4.ne,meanWindow))
plot(rt5.times,movmean(rt5.ne,meanWindow))
plot(rt6.times,movmean(rt6.ne,meanWindow))
xlabel('Time [ms]')
ylabel('Density [m^{-3}]')
title('Density over time, shot#3192')
legend('Probetip 1','Probetip 3','Probetip 5','Probetip 6','Probetip 7','Probetip 12')
exportgraphics(ne, 'neLpa.pdf', 'ContentType', 'vector'); 


TeProf = figure;
hold on
d = 22.5+[1,3,5,6,7,12];
errorbar(d,[mean(rt1.Te),mean(rt2.Te),mean(rt3.Te),mean(rt4.Te),mean(rt5.Te),mean(rt6.Te)], [std(rt1.Te),std(rt2.Te),std(rt3.Te),std(rt4.Te),std(rt5.Te),std(rt6.Te)],'*')
xlabel('Distance from center of NORTH [cm]')
ylabel('Temperature [eV]')
title('Temperature profile of plasma, shot #3192')
grid on
exportgraphics(TeProf, 'TeProf.pdf', 'ContentType', 'vector'); 

neProf = figure;
hold on
d = 22.5+[1,3,5,6,7,12];
errorbar(d,[mean(rt1.ne),mean(rt2.ne),mean(rt3.ne),mean(rt4.ne),mean(rt5.ne),mean(rt6.ne)], [std(rt1.ne),std(rt2.ne),std(rt3.ne),std(rt4.ne),std(rt5.ne),std(rt6.ne)],'*')
xlabel('Distance from center of NORTH [cm]')
ylabel('Density [m^{-3}]')
title('Density profile of plasma, shot #3192')
grid on
exportgraphics(neProf, 'neProf.pdf', 'ContentType', 'vector'); 

