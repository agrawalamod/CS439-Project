crecObj1 = audiorecorder(99999,16,1);
disp('Start speaking.')
recordblocking(recObj1, 10);
disp('End of Recording.');
%play(recObj);
x = getaudiodata(recObj1);
%figure;
%plot(x);


recObj2 = audiorecorder(99999,16,1);
disp('Start speaking.');
recordblocking(recObj2, 1);
disp('End of Recording.');
%play(recObj);
y = getaudiodata(recObj2);
%figure;
%plot(y);

save('test.mat', 'x', 'y')


%Correlation;