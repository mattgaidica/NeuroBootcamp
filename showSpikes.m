function showSpikes()
    [f,p] = uigetfile('*');
    data = tdfread(fullfile(p,f));
    
    eventStartTime = data.Event_Start_Time_ms;
    peakAmplitude = data.Peak_Amplitude_mV;
    interspikeInterval = data.Interspike_Interval_ms;
    
    % scatter peak voltages, look for any patterns
    plot(peakAmplitude,'*');
    title('Peak Voltages of All Data Points (mV)');
    axis([0 length(peakAmplitude) 0 1]); axis 'auto y';
    
    % bucket peak voltages, shows a recording-wide distribution
    [f,x] = ecdf(peakAmplitude);
    figure;
    ecdfhist(f,x);
    title('Bucketed Peak Voltages (mV)');
    
    % scatter intereventIntervals, look for patterns or groupings
    figure;
    subplot(2,1,1);
    bar(eventStartTime./1000,interspikeInterval);
    title('Interspike Interval (ms) vs. Time (s)');
    axis([0 180 0 1]); axis 'auto y';
    
    subplot(2,1,2);
    stimulation = zeros(1,180);
    stimulation(30:60) = 1;
    plot(stimulation);
    axis([0 180 0 2]);
    title('Stimulation Applied (on/off)');
end