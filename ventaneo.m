%% 
function Ez = ventaneo(M, z)
N = length(z) ; 

% w = hann(M); 
 w = ones(M,1);
    for i=M/2:N-M/2
        Ez(i)       = (1/M)*sum(z(i-M/2+1:i+M/2).*w); 
    end
end

