
function [t, signal, sig_filt, Fs] = readWAV(name)
    
    signal = fread( fopen(name,'r') ,inf,'int16') ;  
    
    info = audioinfo(name);
    Fs = info.SampleRate;
    Ts          = 1/Fs ; 

    % Fs          = 11025 ;
    % Ts          = 1/Fs ; 

    % recorto puntas que tienen cosas raras
    L   = length(signal) ; 
    recorte = 0.05*L ; 
    signal = signal(recorte : end-recorte);
    
    % normalizamos la señal
    signal  = signal /max(signal) ;

    % creamos eje de tiempo
    L   = length(signal) ; 
    t   = 0: Ts : Ts*(L-1) ;

    % filtramos la señal al cuadrado para mas placer
    M = 200 ; 
    sig_filt = ventaneo(M,signal.^2) ;
    sig_filt = sig_filt/max(sig_filt) ; 
end