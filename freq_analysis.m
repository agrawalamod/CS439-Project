[rsignal,Fs] = audioread('Data73.m4a');
rsignal= rsignal';

SampleCount = length(rsignal);
recordingTime = SampleCount/Fs;

figure;
plot(1:length(rsignal),rsignal);
title('Received Signal');


[aCorr, alag] = xcorr(transmit_preamble, transmit_preamble);
[xCorr, lags] = xcorr(rsignal, transmit_preamble);

figure;
plot(lags,xCorr);
title('Cross Correlation');

figure;
plot(alag, aCorr);
title('Auto Correlation')

[max_corr,index] = max(abs(xCorr));
shifts = lags(index);
high_index = shifts+1;


%cropped_signal = r_signal(87660:87660+48000);

cropped_signal = rsignal(high_index:high_index+Fs);

%r_signal = cropped_signal;

figure;
plot(1:length(cropped_signal),cropped_signal);
title('Cropped Signal');


fftcroppedsignal = fftshift(fft(cropped_signal,Fs));


farray = -Fs/2:(Fs/2)-1;

figure;
plot(farray, preamble); 
title('Transmitted Preamble');

figure;
plot(farray, abs(fftcroppedsignal));
title('FFT of received signal');

result = fftcroppedsignal./preamble;

result_shifted = ifft(ifftshift(result),Fs);

figure;
t_y = linspace(0, recordingTime, Fs);
plot(1:length(result_shifted),abs(result_shifted));
title('Channel Impulse Response');

cir = abs(result_shifted);

windowSize = 20; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

%filterCIR = filter(b,a,cir);
filterCIR = cir;

figure;
plot(1:length(filterCIR),filterCIR);
title('filtered CIR');
%echo_peak = ginput(1)

filterCIR = [1:length(filterCIR); filterCIR];

[~,idx] = sort(filterCIR(2,:),'descend'); % sort just the first column
sortedCIR = filterCIR(:,idx);   % sort the whole matrix using the sort indices

%hold on
%plot(1:length(filterCIR), cir);
%legend('Filtered Data','Input Data')
%{
[pks,locs] = findpeaks(filterCIR);

xaxis = 1:length(filterCIR)
plot(xaxis,filterCIR,xaxis(locs),pks,'or');
axis tight
%}

min_distance = 0.200;
max_distance = 1.050 + 1.050;

min_sample = (min_distance/346.00)*Fs;
max_sample = (max_distance/346.00)*Fs;


direct_peak = [1 sortedCIR(2,1)];

for i=1:length(sortedCIR)
    if(sortedCIR(1,i) >= direct_peak(1,1) + min_sample && sortedCIR(1,i) < direct_peak(1,1) + max_sample)
        echo_peak = [sortedCIR(1,i) sortedCIR(2,i)];
        break;
    end
end

distance = (echo_peak(1) - direct_peak(1))/Fs*346.00/2;

display(distance);


