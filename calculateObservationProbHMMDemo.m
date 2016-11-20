function stateSeq = calculateObservationProbHMMDemo(observationSeq, ...
    initProb, StateToObservation, stateTransition)
    d = initProb .* StateToObservation(:,observationSeq(1))';
    for i = 2:length(observationSeq)
        d = d * stateTransition .* StateToObservation(:,observationSeq(i))';
    end
    d = d ./ sum(d);
    stateSeq = d;
end