function Caller()
    %     Designing Markov model
    %     3DArray{}.{}.{}
    global postcentroids;
    global precentroids
        global preid
    global postid
    triggerModel() ;
    learnClustering();
    markov_model = zeros((size(postcentroids,2)+1),size(precentroids,2),size(postcentroids,2));
%     trainData = ceil(size(preid,2)*0.20)
    trainData=10;
%     hmmArun(preid, postid)
%     learnClustering();
    for i = 1: trainData
       %i%10 ==1
       if(mod(i,10) == 1)
           a=size(postcentroids,2)+1;
           b=preid(i);
           c=postid(i);
           markov_model(a,b,c) = markov_model(a,b,c)+1;
       else
           a = postid(i-1);
           b = preid(i);
           c = postid(i);
           markov_model(a,b,c) = markov_model(a,b,c)+1;
       end
    end
    %cumProb = cumsum(pdfs)
    %r = rand
    %r <= cumProb
    %[~,id] = max(r <= cumProb)
    action = 1;
%     load('markov_model.mat')
    state = size(markov_model,1);
    
    
    for s=1:9%s=num known
    k1=[zeros(1,10)];
    k2=ones(1,10);
    maxdist=customizeddistfun(k1',k2',10);
    for i=1:1e3
%     studentTestData = getTestData(postid, (ceil(size(preid,2)*0.70)+randi(ceil(size(preid,2)*0.30))));
    studentTestData = getTestData(postid, (3+randi(10)));%ceil(numStudent*0.70) ceil(numStudent*0.30)
    target = studentTestData(s+1:end);
    output = predictNStep(markov_model, studentTestData(s), 10-s);
    app=studentTestData(1:s);
    target=[app,target];
    output=[app,output];
%     disp([target;output]);
distval(i)=sum(target==output)/10;
%     distval(i)=customizeddistfun(target',output',10,postcentroids);
%     distval(i)=custdistfun(target',output',postcentroids,10);
    end
    err=mean(distval);
%     acc=100*(maxdist-err)/maxdist;
%     disp(acc)
    acc=err/1;
    accarr(s)=100*(acc);
    disp([s,accarr(s)])
    figure(1)
    plot(accarr)
    title('Accuray vs Number of Clusters')
    xlabel('Given number of Post Event Surveys')
    ylabel('Accuracy in Percentage')
    drawnow
    end
    
%     predictNStep(markov_model, state, 9)
    % this would require length of the sequence (s11,s12,s13...)
    fprintf([num2str(state), ', ', num2str(action), ', ']);
    for i = 1:10
        [~,nextState] = max(rand <= cumsum(squeeze(markov_model(state,action,:)./...
            sum(markov_model(state,action,:)))));
        state = nextState;
        fprintf([num2str(nextState), ', ']);
    end
end

function studentTestData = getTestData(postid, studentID)
    studentTestData = [];
    for i=1:10
        studentTestData = [studentTestData, postid(1,(10*(studentID-1)+i))];
    end
end

function retVal = getNextState(markov_model,state)
    freq = zeros(1,size(markov_model,3));
    for b = 1:size(markov_model,3)
        for a = 1:size(markov_model,2)
            freq(b) = markov_model(state,a,b) + freq(b);
        end
    end
    cumProb = cumsum(freq ./sum(freq));
    r = rand;
    retVal=1;
    for i=1:size(cumProb,2)
        if (r <= cumProb(i))
            retVal = i;
            break;
        end
    end
end



function reTrajectory = predictNStep(markov_model, state, nStep)
    reTrajectory = [];
    for i = 1:nStep
        nextState = getNextState(markov_model,state);
        reTrajectory = [reTrajectory,nextState];
        state = nextState;
    end
end






