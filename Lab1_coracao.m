clear all
close all
clc
%%
name = 'g4.wav';
[t, signal, sig_filt, Fs] = readWAV(name) ; 

%% Criterio autocorr
[HR_corr, x, y, locs_corr, pks_corr, arritmia] = criterio_xcorr(sig_filt,Fs) ; 
HR_corr
% si arritmia == 1 tiene arritmia, si arritmia == 0 no tiene arritmia
arritmia
%% Criterio FFT
% recibe un HR al que debe aproximar, el que vino de la correlacion
[HR_fft, frec_mid, X_k_mid, locs_fft, pks_fft] = criterio_fft(sig_filt,Fs,HR_corr) ; 
HR_fft

%% solo funciona bien con el corazon bueno g4 
[sig_1, sig_2, s1_largo_final, s1_std_final,  s2_largo_final, s2_std_final] = separa_s1s2(signal,sig_filt);

% Esta es la duración de los s1 y s2 (solo funciona bien con archivo g4.wav)
s1_tiempo = s1_largo_final/Fs ; 
s2_tiempo = s2_largo_final/Fs ; 

s1_std = s1_std_final/Fs ; 
s2_std = s2_std_final/Fs ; 


%% magia que calcula la frec instantanea 
s1_FI_plot = (1/(2*pi)) * diff(unwrap(angle( hilbert(  s1(:,2)  )))) * Fs ;
s2_FI_plot = (1/(2*pi)) * diff(unwrap(angle( hilbert(  s2(:,2)  )))) * Fs ;

s1_AI_plot = abs(hilbert(  s1(:,2)  ));
s2_AI_plot = abs(hilbert(  s2(:,2)  ));

%% ploteos 
% ===================================================================================================
% ===================================================================================================

% fig1 = figure('Position', get(0, 'Screensize')); 
%     subplot(211)
%         plot(x,y,'ok','MarkerFace','k','MarkerSize',4)
%         hold on 
%         stem(x(locs_corr),pks_corr,'MarkerSize',20,'MarkerFace','b','LineWidth',5)
%         grid on
%         set(gca,'FontSize',30)
%         xlabel('Retardos [s]','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
%         ylabel('Autocorrelación','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
%           
%     subplot(212)
%         plot(frec_mid,X_k_mid,'-ok','MarkerFace','k','MarkerSize',10,'LineWidth',5)
%         hold on 
%         stem(frec_mid(locs_fft),pks_fft,'MarkerSize',20,'MarkerFace','b','LineWidth',5)
%         grid on 
%         set(gca,'FontSize',30)
%         xlabel('Frecuencia [Hz]','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
%         ylabel('FFT ','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
%         
    
%      saveas(fig1, 'autocorr.png','png');
%%
% ===================================================================================================
% ===================================================================================================

fig2 = figure('Position', get(0, 'Screensize')); 
    subplot(211)
        plot(t,signal,'-k','LineWidth',2)
        grid on
        set(gca,'FontSize',30)
        xlabel('Tiempo [s]','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
        ylabel('Sonido','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
        xlim([0,7])
        ylim([-1.1,1.1])
          
    subplot(212)
        plot(t(1:length(sig_filt)),sig_filt,'-k','LineWidth',2)
        grid on 
        set(gca,'FontSize',30)
        xlabel('Tiempo [s]','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
        ylabel('Energía','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
        xlim([0,7])
        
    
%      saveas(fig2, 'signals.png','png');
%%
% ===================================================================================================
% ===================================================================================================
fig3 = figure('Position', get(0, 'Screensize')); 
    
        plot(t(1:length(sig_1)),sig_1,'-b','LineWidth',2)
        hold on 
        plot(t(1:length(sig_2)),sig_2,'-r','LineWidth',2)
        grid on
        set(gca,'FontSize',30)
        xlabel('Tiempo [s]','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
        ylabel('Sonido','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
        xlim([0,7])
        ylim([-1.1,1.1])
        
       [~ , L] =  legend({'S1','S2'},'location','northeast','FontSize',40)
       set(findobj(L,'-property','MarkerSize'),'LineWidth',20) % Esta maia cambia el tamaño de los markers en el legend

        
    
%      saveas(fig3, 's1s2.png','png');


%% spectogram 
N= 25;
fig4 = figure('Position', get(0, 'Screensize'));
subplot(211)
specgram(s1(:,2),N,Fs,ones(N,1),17);
set(gca,'FontSize',30)
        xlabel('Tiempo [s]','FontSize',30,'FontWeight','bold','FontName', 'Times New Roman')
        ylabel('Frecuencia [Hz] ','FontSize',30,'FontWeight','bold','FontName', 'Times New Roman')
        ylim([0,200])
        xticks([])
        yticks([0,50,100,150,200])
        title('Espectrograma S1','FontSize',30,'FontName','Times')      

subplot(212)
N=25
specgram(s2(:,2),N,Fs,ones(N,1),17);
set(gca,'FontSize',30)
        xlabel('Tiempo [s]','FontSize',30,'FontWeight','bold','FontName', 'Times New Roman')
        ylabel('Frecuencia [Hz] ','FontSize',30,'FontWeight','bold','FontName', 'Times New Roman')
        ylim([0,200])
        xticks([])
        yticks([0,50,100,150,200])
        title('Espectrograma S2','FontSize',30,'FontName','Times')   

%          saveas(fig4, 'spectrograma_m.png','png');


%%

fig5 = figure('Position', get(0, 'Screensize'));

plot(t(1:length(s1_FI_plot)),s1_FI_plot,'-b','LineWidth',4)
hold on 
grid on
plot(t(1:length(s2_FI_plot)),s2_FI_plot,'-r','LineWidth',4)
ylim([0,160])
set(gca,'FontSize',30)
        xlabel('Tiempo [s]','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
        ylabel('Frecuencia instantanea [Hz]','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)

[~ , L] =  legend({'S1','S2'},'location','northeast','FontSize',40)
       set(findobj(L,'-property','MarkerSize'),'LineWidth',20) % Esta maia cambia el tamaño de los markers en el legend

        saveas(fig5, 'FI_m.png','png');    
        
        
%%        
% fig6 = figure('Position', get(0, 'Screensize'));
% 
% plot(x1,y1,'-b','LineWidth',4)
% hold on 
% grid on
% plot(x,y,'-r','LineWidth',4)
% plot(x,0.6327*ones(length(x),1),'--k','LineWidth',4)
% 
% set(gca,'FontSize',30)
%         xlabel('Retardos [s]','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
%         ylabel('Autocorrelación','FontSize',20,'FontWeight','bold','FontName', 'Times New Roman', 'FontSize' , 40)
% 
% [~ , L] =  legend({'Sano','No sano','Umbral'},'location','northeast','FontSize',40)
%        set(findobj(L,'-property','MarkerSize'),'LineWidth',20) % Esta maia cambia el tamaño de los markers en el legend
% 
%         saveas(fig6, 'arritmia.png','png');      
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        