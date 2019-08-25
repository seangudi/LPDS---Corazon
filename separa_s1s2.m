% separa s1 y s2 de una grabacion bonita. Si es muy mala no funciona

function [sig_1, sig_2, s1_largo_final, s1_std_final, s2_largo_final, s2_std_final] = separa_s1s2(signal,sig_filt)
e_media = floor(mean(sig_filt)*10)/10; 

% sacamos cuadrada de s1 y s2 juntas
for i=1:length(sig_filt)
    if(sig_filt(i) > e_media)
        s(i) = 1 ; 
    else
        s(i) = 0 ; 
    end
end

% separamos las s1 y s2
% flag me va alternando entre s1 (1) y s2 (2), supongo que empieza en s1
flag = 1 ; 

% contadores para longitudes de s1 y s2
cont_1 = 0;
cont_2 = 0;

% indices para contadores
k1 = 1 ; 
k2 = 1 ; 

sig_l = length(sig_filt)-1 ; 
for i= 1:sig_l
    if(s(i) == 0 )
        s1(i) = 0 ; 
        s2(i) = 0 ; 
    else
        if(flag == 1)
            s1(i) = 1 ; 
            s2(i) = 0 ; 
            cont_1 =cont_1 +1 ; 
                if(s(i+1)== 0)
                    flag = 2 ; 
                    s1_largo(k1) = cont_1 ;
                    k1          = k1+1;
                    cont_1      = 0 ; 
                end
        else
            s1(i) = 0 ; 
            s2(i) = 1 ; 
            cont_2 =cont_2 +1 ; 
                if(s(i+1) == 0)
                    flag = 1 ; 
                    s2_largo(k1) = cont_2 ;
                    k2          = k2+1;
                    cont_2      = 0 ; 
                end
        end
    end
end

sig_1 = s1(:) .* signal(1:length(s1)) ; 
sig_2 = s2(:) .* signal(1:length(s2)) ;

s1_largo_final = mean(s1_largo) ; 
s1_std_final    = std(s1_largo) ; 

s2_largo_final = mean(s2_largo) ; 
s2_std_final    = std(s2_largo) ; 

end











