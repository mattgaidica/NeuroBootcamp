function showSpikes()
    [f,p] = uigetfile('*');
    data = tdfread(fullfile(p,f));
    
    eventStartTime = data.Event_Start_Time_ms;
    peakAmplitude = data.Peak_Amp_uV;
    timeOfPeak = data.Time_of_Peak_ms;
    timeOfAntipeak = data.Time_of_Antipeak_ms;
    interspikeInterval = data.Interspike_Interval_ms;
    
    % scatter peak voltages, look for any patterns
    figure;
    subplot(2,1,1);
    plot(peakAmplitude,'*');
    title('Peak Voltages of All Data Points (uV)');
    axis([0 length(peakAmplitude) 0 1]); axis 'auto y';
    
    % bucket peak voltages, shows a recording-wide distribution
    [f,x] = ecdf(peakAmplitude);
    subplot(2,1,2);
    ecdfhist(f,x);
    title('Bucketed Peak Voltages (uV)');
    
    % plot peak-to-antipeak time to assess length of spikes
    figure;
    subplot(2,1,1);
    plot(eventStartTime./1000,abs(timeOfPeak-timeOfAntipeak),'*');
    title('Spike Peak-to-Antipeak (ms) vs. Time (s)');
    axis([0 180 0 1]); axis 'auto y';
    
    subplot(2,1,2);
    stimulation = zeros(1,180);
    stimulation(30:60) = 1;
    plot(stimulation);
    axis([0 180 0 2]);
    title('Stimulation Applied (on/off)');
    
    % subplot interspikeIntervals and stimulation paradigm
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