function [accuracyHMM_validation, accuracyHMM_test] = ...
    runHMM(observations, observations_validation, observations_test)
    global numstate
% function accuracyHMM = runHMM()
%     load('observations.mat')
%     for numstate=90:10:250
%         numstate=3;
%         disp(['computing numstate: ' num2str(numstate)]);
        [stateTransition, stateToObservation] = trainModel(numstate, observations); 
        for numgiven =1:19
%             fprintf('.');
%            results_validation(((numstate-90)/10)+1,numgiven) = observationsHMM2(numstate, numgiven, ...
%                stateTransition, stateToObservation, observations);
            results_validation(numgiven) = observationsHMM2(numstate, numgiven, ...
                stateTransition, stateToObservation, observations_validation);
            results_test(numgiven) = observationsHMM2(numstate, numgiven, ...
                stateTransition, stateToObservation, observations_test);
        end
%         fprintf('\n');
        accuracyHMM_validation = results_validation;
        accuracyHMM_test = results_test;
%     end
end

function [stateTransition, stateToObservation] = trainModel(numstate, observations)
    stateTransition = rand(numstate, numstate);
    %length(stateTransition)
    for i = 1:numstate
        stateTransition(i,:) = stateTransition (i,:) ./sum(stateTransition(i,:));
    end
    stateToObservation = rand (numstate,max(observations(:)));
    for i = 1:numstate
        stateToObservation(i,:) = ...
            stateToObservation (i,:) ./sum(stateToObservation(i,:));
    end
    [stateTransition, stateToObservation] = ...
        hmmtrain(observations,stateTransition,stateToObservation,...
        'MAXITERATIONS',500);
end

function ret=observationsHMM2(numstate, numgiven, stateTransition, ...
    stateToObservation, observations)   
for j=1:200
    for i=1:size(observations,1);
        x = observations(i,:);
        x1 = x(1:numgiven);
        numPredict = length(x) - length(x1)+1;
        stateSeq = hmmdecode(x1, stateTransition, stateToObservation);
        
%         y = calculateStateSeqProb(stateSeq(:,end), numPredict, ...
%             stateTransition, stateToObservation);
    %   Augmenting the transition and emission probabilities
        [~,stateSeq]=max(stateSeq(:,end));
        p = zeros(1,numstate);
        p(stateSeq(end))=1;
        augstateTransition = [p;stateTransition];
        augstateTransition = [zeros(size(augstateTransition,1),1),augstateTransition];
        augstateToObservation = [zeros(1,size(stateToObservation,2));stateToObservation];

        [y,outstates] = hmmgenerate(numPredict, augstateTransition, ...
            augstateToObservation);
        k(i,j)=y(2);
        result(i,j) = calculateAccuracy(y(2:end), x(numgiven+1:end));
br=1;
    end
end
    ret = (mean(result(:)));
end

function id = calculateStateSeqProb(current_state_seq, numPredict, ...
    stateTransition, stateToObservation)
    initial = current_state_seq' * stateTransition;
    stateSeqProb = initial;
    for i = 2:numPredict
        stateSeqProb(i,:) = stateSeqProb(i-1,:) * stateTransition;
    end
    for i = 1:size(stateSeqProb,1)
        stateSeqProb(i,:) = stateSeqProb(i,:) ./ sum(stateSeqProb(i,:));
    end
    observSeqProb = stateSeqProb * stateToObservation;
    [~,id] = max(observSeqProb,[],2);
    id = id';
end

function result = calculateAccuracy(y,x)
    result = sum(x==y)/length(y);
end