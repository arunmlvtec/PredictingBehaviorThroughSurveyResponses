function observationSeq = generateObservations(observationSeq, neededObser, ...
    initProb, stateTransition, stateToObservation)
%     initProb = [0.2 0.6 0.2]; %a
%     stateTransition = [0.3 0.5 0.2; 0.1 0.6 0.3; 0.3 0.2 0.5]; %b
%     stateToObservation = [0.1 0.85 0.05; 0.3 0.4 0.3; 0.6 0.2 0.2]; %c
    for i = 1:neededObser
        observationSeq = [observationSeq, getNextObservation(observationSeq, ...
            initProb, stateTransition, stateToObservation)];
    end
    %disp(observationSeq);
end
function nextObservation = getNextObservation(observationSeq, initProb, ...
    stateTransition, StateToObservation)
    stateProb = calculateObservationProbHMMDemo(observationSeq, ...
        initProb, StateToObservation, stateTransition);
    observationProb = calculateObservationProb(stateProb, stateTransition, ...
        StateToObservation);
    %nextObservation = observationProb;
    %nextObservation = max(rand <= cumsum(squeeze(markov_model(state,action,:)./...
            %sum(markov_model(state,action,:)))));
    [~,nextObservation] = max(rand <= cumsum(observationProb));
end

function observationProb = calculateObservationProb(stateProb, stateTransition, ...
    StateToObservation)
    observationProb = stateProb * stateTransition * StateToObservation;
end