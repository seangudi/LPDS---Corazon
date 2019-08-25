%signal es una matriz con cada realizacion en cada COLUMNA, 
%Recibe signals y la frecuencia de muestreo
function [X_k, frec] = fft_bonita( signal , fs) 

signal = signal(:) ; % lo convierto si o si a columna  
%L = length(signal) ;

sig_fft = fftshift(fft(signal,2^(nextpow2(length(signal))))); 
L = length(sig_fft) ;

%X_k =  abs(sig_fft) ;  % Aca estan las amplitudes double-sided
X_k =  (sig_fft) ; 

frec  = -fs/2 : fs/L : (fs/2 - fs/L) ;  %vector fila

end

