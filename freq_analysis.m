
[rsignal,Fs] = audioread('Data42.m4a');
rsignal= rsignal';

SampleCount = length(rsignal);
recordingTime = SampleCount/Fs;

%figure;
plot(1:length(rsignal),rsignal);
title('Received Signal');


[aCorr, alag] = xcorr(transmit_preamble, transmit_preamble);
[xCorr, lags] = xcorr(rsignal, transmit_preamble);


[max_corr,index] = max(abs(xCorr))
shifts = lags(index)
high_index = shifts+1


%cropped_signal = r_signal(87660:87660+48000);

cropped_signal = rsignal(high_index:high_index+48000);

%r_signal = cropped_signal;

%figure;
plot(1:length(cropped_signal),cropped_signal);
title('cropped signal');


fftcroppedsignal = fftshift(fft(cropped_signal,48000));


farray = -Fs/2:(Fs/2)-1;

%figure;
plot(farray, preamble); 
title('preamble');

%figure;
plot(farray, abs(fftcroppedsignal));
title('FFT of received signal');

result = fftcroppedsignal./preamble;

result_shifted = ifft(ifftshift(result),48000);

%figure;
t_y = linspace(0, recordingTime, 48000);
plot(1:length(result_shifted),abs(result_shifted));
title('CIR');

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
max_distance = 1.000 + 1.000;

min_sample = (min_distance/343.300)*48000;
max_sample = (max_distance/343.300)*48000;


direct_peak = [1 sortedCIR(2,1)];
%echo_peak = [714];

for i=1:length(sortedCIR)
    if(sortedCIR(1,i) >= direct_peak(1,1) + min_sample && sortedCIR(1,i) < direct_peak(1,1) + max_sample)
        echo_peak = [sortedCIR(1,i) sortedCIR(2,i)];
        break;
    end
end

distance = (echo_peak(1) - direct_peak(1))/48000*343.300/2;

display(distance);


