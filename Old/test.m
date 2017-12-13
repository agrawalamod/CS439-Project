%% Time domain parameters
fs = 25000;    % Sampling frequency
dt = 1/(1000*fs);     % Time resolution
T = 2/fs;        % Signal duration
t = 0:dt:T; % Total duration
N = length(t); % Number of time samples

%% Signal generation
f0_1 = 100; % fundamental frequency of first sinusoid
f0_2 = 200; % fundamental frequency of second sinusoid
x1 = sin(2*pi*f0_1*t); % first sinusoid
x2 = sin(2*pi*f0_2*t); % second sinusoid

figure;
plot(t,x1);

% We want 200 Hz signal to last for half of a time, therefore zero-out
% second half - use the logical indexing of time variable
x2(t>5)=0;

% Now add two signals
x = x1+x2;

% Calculate spectrum
X = abs(fft(x))/N;
% Prepare frequency axis
freqs = (0:N-1).*(fs/N);

%% Plotting time and frequency domain
% Time domain signal plot
subplot(211)
plot(t, x)
grid on
xlabel('Time [s]')
ylabel('Amplitude')
title('Time domain signal')

% Spectrum plot
subplot(212)
plot(freqs, X)
grid on
xlim([0 max(freqs)])
xlabel('Frequency [Hz]')
ylabel('Amplitude')
title('Spectrum')

%% Playing back signal
% Normalize the audio:
x = 0.99*x/max(abs(x));

% For MATLAB R2014a use audioplayer
player = audioplayer(x, fs);
play(player)

% For older versions use wavplay
% wavplay(x, fs);