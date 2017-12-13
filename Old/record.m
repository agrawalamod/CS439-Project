recObj = audiorecorder(50000,16,2)
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');

y = getaudiodata(recObj);

plot(y);

