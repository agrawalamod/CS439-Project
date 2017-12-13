x = signal;
%y = fsignal;
%recordingTime = 100;
%recObj = audiorecorder(22000,16,1);
%disp('Start speaking.');
%recordblocking(recObj, recordingTime);
%disp('End of Recording.');
%play(recObj);
%y = getaudiodata(recObj);
[y,Fs] = audioread('Data2.m4a');
SampleCount = length(y);
recordingTime = SampleCount/Fs;

[aCorr, alag] = xcorr(x, x);
[xCorr, xlag] = xcorr(y, x);
%[aCorrMax,aI] = max(abs(aCorr));
%[xCorrMax,xI] = max(abs(xCorr));
%lagDiff = alag(aI);
%timeDiff = lagDiff/SampleCount;

%% Plot autocorrelation of preamble
figure;
alag = alag/SampleCount;
plot(alag,aCorr);
title('Auto Correlation');
xlabel('time')
ylabel('amplitude')

%% Plot Cross-correlation amplitude spectrum
figure;
%lagDiff = xlag(xI);
%timeDiff = lagDiff/99999;
xlag = xlag*recordingTime/SampleCount;
plot(xlag,xCorr);
title('Cross Correlation');
xlabel('time')
ylabel('amplitude')

%% Plot orignal signal
%figure;
%t_x = linspace(0, length(x)/SampleCount, SampleCount);
%plot(t_x, x)

%% Plot recorded signal
figure;
t_y = linspace(0, recordingTime, SampleCount);
plot(1:length(y), y)
title('received signal');

%% fft 
figure;
fft_signal = fftshift(fft(y));
N = length(y);
farray = (-fs/2: fs/N: fs/2-fs/N);
plot(farray, abs(fft_signal));




