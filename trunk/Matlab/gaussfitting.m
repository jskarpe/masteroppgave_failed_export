clear, clc,close all % clear all variables, window, and close all windows
fontsize = 14;
delimiter = '\t';

% Analysis
MH2_noise_20s = '..\Results\april-28-2010\MH2-Q3-210-B2\Noise-20s-during-spot3\';
MH2_noise_20s = get_result_from_dir(MH2_noise_20s,delimiter,1);

% Area 1
MH2_area1 = '..\Results\april-28-2010\MH2-Q3-210-B2\spot1-goodspot\';
MH2_area1 = get_result_from_dir(MH2_area1,delimiter,1);
MH2_area1 = dark_current_noise_removal(MH2_area1,MH2_noise_20s);
%MH2_area1 = nm_to_ev(MH2_area1);

%plot_result(MH2_area1,2,'ev','20s integrating time','MH2-Q3-210 B2 Area 1',fontsize,'b',0);

 
% Guess what peaks/curves are present in the resultset, expect nm arg
    %position_nm  width intensity
t8 = [nm_to_ev(0.934)   19  1000]; %D3
t7 = [nm_to_ev(0.968)   19  1000]; %TO + 2 phonon
t6 = [nm_to_ev(1.0)   19  1000]; %D4
t5 = [nm_to_ev(1.0315)   15  2000]; %TO + 1 zone center phonon
t4 = [nm_to_ev(1.074)   9  3000]; %TO + 1 intervalley phonon
t3 = [nm_to_ev(1.092)   5  1000]; %BE B
t2 = [nm_to_ev(1.097)   9  20000]; %TO
t1 = [nm_to_ev(1.10)   5  1000]; %BE P
t0 = [nm_to_ev(1.1045)   7  800]; %I0
peak_guesses = [t0 t1 t2 t3 t4 t5 t6 t7 t8];
interval = [nm_to_ev(1.2) nm_to_ev(0.79)]; % From -> TO in wavelength (nm)

plot_result(MH2_area1,1,'ev','20s integration time','Gaussfitting MH2',fontsize,'y',0)
plot_gaussfitting(MH2_area1,peak_guesses,interval,1,'ev','20s integration time','Gaussfitting MH2',fontsize,'b',0)

%{

param0 = [t1 t2 t3 t4 t5 t6 t7 t8];
indexlow = find(x > nm_to_ev(1.2),1,'first'); % 1.2 eV at the lowest index (due to results in nm, not eV)
indexhigh = find(x > nm_to_ev(0.79),1,'first'); % 0.79 eV at highest index (due to nm_to_ev)

lambda = x(indexlow:indexhigh);
intensity = y(indexlow:indexhigh);

%sgolay filtering
intensity = sgolayfilt(intensity,1,19);


[calcInt,g1,g2,g3,g4,g5,g6,g7,g8] = Gn(param0,lambda);
%[calcInt,g1,g2,g3] = Gn(param0,lambda);

figure1 = figure(1);
clf;

lambda2 = lambda;
lambda = nm_to_ev(lambda);

plot(lambda,intensity,'r');
hold on;
plot(lambda,calcInt,'k');
plot(lambda,g1,'--r','Color','b');
plot(lambda,g2,'--r','Color','b');
plot(lambda,g3,'--r','Color','b');
plot(lambda,g4,'--r','Color','b');
plot(lambda,g5,'--r','Color','b');
plot(lambda,g6,'--r','Color','b');
plot(lambda,g7,'--r','Color','b');
plot(lambda,g8,'--r','Color','b');
xlabel({'Wavelength [nm]'},'FontWeight','bold','FontSize',18,'FontName','Calibri');
ylabel({'Intensity'},'FontWeight','bold','FontSize',18,'FontName','Calibri');
title({'sf090604 visible spectrum Gaussian fit'},'FontWeight','bold','FontSize',24,'FontName','Calibri');
%}






%% Computer fit
lambda = lambda2;

param = lsqcurvefit(@Gn, param0, lambda, intensity);

[calcInt,g1,g2,g3,g4,g5,g6] = Gn(param,lambda);

figure(2);
%lambda = nm_to_ev(lambda);
%plot(lambda,intensity,'r');
hold on;
plot(lambda,calcInt,'k');
plot(lambda,g1,'--r','Color','b');
plot(lambda,g2,'--r','Color','b');
plot(lambda,g3,'--r','Color','b');
plot(lambda,g4,'--r','Color','b');
plot(lambda,g5,'--r','Color','b');
plot(lambda,g6,'--r','Color','b');
plot(lambda,g7,'--r','Color','b');
%xlabel({'Wavelength [nm]'},'FontWeight','bold','FontSize',18,'FontName','Calibri');
%ylabel({'Intensity'},'FontWeight','bold','FontSize',18,'FontName','Calibri');
%title({'sf090604 visible spectrum Gaussian fit'},'FontWeight','bold','FontSize',24,'FontName','Calibri');


% Skrive til fil for bruk i latex
%print -depsc 'C:\Documents and Settings\Jon\My Documents\Prosjekt\solcelle\Latex_filer\bilder\Posisjoner_gauss'

