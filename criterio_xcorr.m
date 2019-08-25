function [HR, x, y, locs, pks, arritmia] = criterio_xcorr(sig,Fs)
    [sig_c, lags] = xcorr( sig ) ;
    
    % me quedo con los primeros dos seundo en LAG => HR = 30 bpm (super muerto)
   
    x = lags(length(lags)/2: end )/Fs ;  % ya me lo da en tienpo 
    y = sig_c(length(lags)/2:end) ; 
    
    x = x(1:2*Fs);
    y = y(1:2*Fs) / max(y(1:2*Fs)); % normalizamos
    
    % de aqui saco los picos en bins de .5 s NUNCA agarra el maximo en cero
    % porque no es un pico (no tiene la parte de la izq que sube y lo hace pico)
    
    [pks,locs]  = findpeaks(y) ;
    [~, idx] = max(pks) ; 
   
    HR = 60/x(locs(idx));
    
    % me dice si tiene arritmia o no comparando con umbral calculado
    % estadisticamente
    
    umbral = 0.6327 ; 
    
    if(pks(idx) > umbral)
        arritmia = 0 ; 
    else
        arritmia = 1 ; 
    end
end
