H = comm.BarkerCode('Length',13,'SamplesPerFrame',13);

Y = [+1, +1, +1, +1, +1, -1, -1, +1, +1, -1, +1, -1, +1];

plot(Y)
sound(Y,1000)