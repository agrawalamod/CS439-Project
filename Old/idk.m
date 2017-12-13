%% Time domain parameters
fs = 48000;    % Sampling frequency
f = 10000;
dt = 1/(fs);     % Time resolution
T = 100*(1/f);        % Signal duration
t = 0:dt:T; % Total duration
N = length(t); % Number of time samples
amp1 = 10;
amp2 = -10;


x1 = amp1*sin(2*pi*f*t);
x2 = amp2*sin(2*pi*f*t);
figure;
plot(t,x1)
figure;
plot(t,x2)

%b = [+1, +1, +1, +1, +1, -1, -1, +1, +1, -1, +1, -1, +1];
b= mls(5, 0);



sound(x1);
%sound(x2);



signal = []
for i=1:length(b)
    if(b(i) == 1)
        signal = [signal x1];
    
    else
        
        signal = [signal x2];
    end
end



%figure;
%plot( signal);

%r = randi([-10,10],1,length(signal)/5); 

r = zeros(1,100000);

fsignal=[]
for j = 1:3
    fsignal = [fsignal r signal];
end

fsignal = [fsignal r];

figure;
plot(signal);

audiowrite('signal.wav',fsignal,fs);
%sound(signal);



