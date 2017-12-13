%% Time domain parameters
fs = 48000;    % Sampling frequency
dt = 1/(fs);     % Time resolution
amp1 = 10;
amp2 = -10;

%b = [+1, +1, +1, +1, +1, -1, -1, +1, +1, -1, +1, -1, +1];
b= mls(4, 0);


signal = []
for i=1:length(b)
    f = i*1000;
    T = 6*(1/f);        % Signal duration
    t = 0:dt:T; % Total duration
    N = length(t); % Number of time samples
    if(b(i) == 1)
        x1 = amp1*sin(2*pi*f*t);
        signal = [signal x1];
    else
        x2 = amp2*sin(2*pi*f*t);
        signal = [signal x2];
    end
end



%figure;
%plot( signal);

%r = randi([-10,10],1,length(signal)/5); 

r = zeros(1,100000);

fsignal=[]
for j = 1:1
    fsignal = [fsignal r signal];
end

fsignal = [fsignal r];

figure;
plot(signal);

audiowrite('signal.wav',fsignal,fs);

 
%sound(signal);



               