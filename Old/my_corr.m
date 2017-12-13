function corr_values = my_corr(data,signal)
    corr_values = [];
    sl = length(signal);
    
    for i=1:length(data)-sl+1
        tempS = data(i:i+sl-1);
        %display(size(tempS));
        %display(size(signal));
        t = signal*tempS;
        corr_val = t;
        corr_values = [corr_values; i corr_val];
    end
end
