function quality = learnClustering(initWeights)
    global complete_pre_data_train;
    global complete_post_data_train;
    global complete_pre_data_validation;
    global complete_post_data_validation;
	global complete_pre_data_test;
    global complete_post_data_test;
    global student;
    global postcentroids;
    global precentroids;
    global preid;
    global postid;
    global preid_validation;
    global postid_validation;
	global preid_test;
    global postid_test;
    global accuracyHMM_test;
%   Used Customized distance function
%   initWeights = [4,3,2,1];
    [preid,precentroids] = googkmeans(complete_pre_data_train, initWeights, 10);
%     disp('pre_clustered');
    [postid,postcentroids] = googkmeans(complete_post_data_train, initWeights, 20);
%     disp('post_clustered');
    clusterCounts = [size(precentroids,2), size(postcentroids,2)];
    
    postid = postid + size(precentroids,2);
    observations = hmmArun(preid, postid);
    
    preid_validation = validate_clustering(complete_pre_data_validation, ...
        initWeights, precentroids);
    postid_validation = validate_clustering(complete_post_data_validation, ...
        initWeights, postcentroids);
    postid_validation = postid_validation + size(precentroids,2);
    observations_validation = hmmArun(preid_validation, postid_validation);
    
    preid_test = validate_clustering(complete_pre_data_test, ...
        initWeights, precentroids);
    postid_test = validate_clustering(complete_post_data_test, ...
        initWeights, postcentroids);
    postid_test = postid_test + size(precentroids,2);
    observations_test = hmmArun(preid_test, postid_test);
    
    [accuracyHMM_validation, accuracyHMM_test] = ...
        runHMM(observations, observations_validation, observations_test);
    quality = 1/(mean(accuracyHMM_validation) * mean(clusterCounts));
%   fprintf('.');
end

function ret = validate_clustering(data, initWeights, C)
   wsize = 4;
    for i=1:size(data,2)
       for j=1:size(C,2)
           distmat(j)=customizeddistfun(data{i}', C{j}', initWeights);
       end
       [~,ret(i)] = min (distmat);
    end
end