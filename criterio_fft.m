function [HR, frec_mid, X_k_mid, locs, pks] = criterio_fft(sig,Fs, magic)

% busco la frecuencia fundamental con la fft 
    [X_k, frec] = fft_bonita( sig-mean(sig) , Fs) ; % le quito la media para que no tenga pico en cero
    
% selecciono la banda inicio->final Hz ahi estan los corazones mas fieros
inicio   = 0.4;   
final    = 3 ; 
L       = length(frec) ; 
X_k_mid     = abs(X_k( floor(L/2)+ floor(inicio/(Fs/L)) : floor(L/2) + floor(final/(Fs/L)) )) ;
X_k_mid = X_k_mid / max(X_k_mid);
frec_mid    = frec(    floor(L/2)+ floor(inicio/(Fs/L)) : floor(L/2) + floor(final/(Fs/L)) ) ;

% de aqui saco los picos en bins de .5 Hz 
[pks,locs]  = findpeaks(X_k_mid,'MinPeakDistance',ceil(.5/(Fs/L))) ;

% saco el HR mas cercano a 'magic'. Le creo a este resultado pues tiene en
% cuenta toda la señal y no solo un shift como la auto correlacion
[~, idx] = min( abs (60*frec_mid(locs)-magic) ) ;

HR = frec_mid(locs(idx)) * 60 ; 
end