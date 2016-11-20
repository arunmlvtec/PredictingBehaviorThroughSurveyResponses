function caller()
figure(1)
% hold on
for i=1:200
    rec(i)=observationsHMM2(i);
    disp([i rec(i)])
    plot(rec)
    drawnow
end

end
function ret=observationsHMM2(numstate)
%     numstate = 7;
    load('observations.mat')
    initProb = (1/numstate).*ones(1, numstate);
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
    [stateTransitiontemp,stateToObservationtemp] = ...
        hmmtrain(observations,stateTransition,stateToObservation,...
        'MAXITERATIONS',1000);
    
    
    %generate crap
%     for j=1:500
%     [seq,~] = hmmgenerate(20,stateTransitiontemp,stateToObservationtemp);
%     observations=[observations;seq];
%     end
%     %train again with appended crap
%     [stateTransition,stateToObservation] = ...
%     hmmtrain(observations,stateTransition,stateToObservation,...
%     'MAXITERATIONS',1000);

    numpredict=10;
    for i=1:14
    x = observations(i,:);
    x1 = x(1:numpredict);
    y = getNextObservationHMM(x1, numpredict, initProb, ....
        stateTransition, stateToObservation);
    a=[x;y];
    numcorrect(i)=sum(x==y)-numpredict;
%     disp(numcorrect/10);
    end
    ret=mean(numcorrect/numpredict);
end
