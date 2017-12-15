fs = 44100;

preamble = [];
for i=1:fs/2
    x = round(rand);
    if(x==1)
        preamble = [preamble 1];
    else
        preamble = [preamble -1];
    end
end
preamble = [preamble fliplr(preamble)]

farray = -fs/2:(fs/2)-1;

shifted_preamble = ifftshift(preamble);
transmit_preamble = ifft(shifted_preamble);

transmit_preamble = 100*transmit_preamble;

figure;
plot(1:length(transmit_preamble),transmit_preamble);

audiowrite('freq_signal_441.wav',transmit_preamble,fs);
    