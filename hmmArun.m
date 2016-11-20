function observations = hmmArun(preid, postid)
    observations = getObservationSeq(preid, postid);
    
end

function observations = getObservationSeq(preid, postid)
    observationSeq = [];
    observations = [];
    for i=1:size(preid,2)
        observationSeq = [observationSeq, preid(i)];
        observationSeq = [observationSeq, postid(i)];
        if mod(i,10) == 0
            observations = [observations; observationSeq];
            observationSeq = [];
        end
    end
end

