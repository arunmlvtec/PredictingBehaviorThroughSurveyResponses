function accuracyHMM = runHMM(observations)
%     load('observations.mat')
%     for numstate=1:25
        numstate=10;
        disp(['computing numstate: ' num2str(numstate)]);
        [stateTransition, stateToObservation] = trainModel(numstate, observations); 
        for numgiven = 1:10
            fprintf('.');
%            results(numstate,numgiven) = observationsHMM2(numstate, numgiven, ...
%                stateTransition, stateToObservation, observations);
            results(numgiven) = observationsHMM2(numstate, numgiven, ...
                stateTransition, stateToObservation, observations);
        end
        fprintf('\n');
        accuracyHMM = mean (results);
%         if(numstate >1)
%             contourf(results);
%             drawnow;
%         end
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
        'MAXITERATIONS',1000);
end

function ret=observationsHMM2(numstate, numgiven, stateTransition, ...
    stateToObservation, observations)   
    for i=1:size(observations,1);
        x = observations(i,:);
        x1 = x(1:numgiven);
        numPredict = length(x) - length(x1)+1;
        stateSeq = hmmviterbi(x1, stateTransition, stateToObservation);
    %   Augmenting the transition and emission probabilities
        p = zeros(1,numstate);
        p(stateSeq(end))=1;
        augstateTransition = [p;stateTransition];
        augstateTransition = [zeros(size(augstateTransition,1),1),augstateTransition];
        augstateToObservation = [zeros(1,size(stateToObservation,2));stateToObservation];

        y = hmmgenerate(numPredict, augstateTransition, augstateToObservation);
        result(i) = calculateAccuracy(y(2:end), x(numgiven+1:end));
%         disp (result);
    end
    ret = (mean(result));
end

function result = calculateAccuracy(y,x)
    result = sum(x==y)/length(y);
end




