[y,Fs] = audioread('Data.m4a');
SampleCount = length(y);
recordingTime = SampleCount/Fs;

s=23750;

while(s+20<23750+(20*10))
    small_data = y(s:s+20);
    fft_smalldata = fftshift(fft(small_data));
    figure;
    N = 20;
    farray = linspace(-48000/40, 48000/40, 21);
    %farray = (-1000/2: 1000/N: 1000/2-1000/N);
    plot(farray, abs(fft_smalldata));
    s= s+20
    
end



