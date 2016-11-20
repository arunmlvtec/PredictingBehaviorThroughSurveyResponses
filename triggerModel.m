function triggerModel()
    global complete_pre_data_train;
    global complete_post_data_train;
    global complete_pre_data_validation;
    global complete_post_data_validation;
    global complete_pre_data_test;
    global complete_post_data_test;
    global student;
    numStudent = 24;
%     for i =1:numStudent
%         for j=1:10
%             student{i}.pre{j}=PRESurvey();
%             student{i}.post{j}=POSTSurvey();
%         end
%     end
    load('student_full_data.mat')
    student=student_data;
    complete_pre_data_train={};
    complete_post_data_train={};
    complete_pre_data_validation={};
    complete_post_data_validation={};
    complete_pre_data_test={};
    complete_post_data_test={};
    for i=1:numStudent
        complete_pre_data_train=[complete_pre_data_train,student{i}.pre];
        complete_post_data_train=[complete_post_data_train,student{i}.post];
    end
   for i=numStudent+1:numStudent+6
        complete_pre_data_validation=[complete_pre_data_validation,student{i}.pre];
        complete_post_data_validation=[complete_post_data_validation,student{i}.post];
   end
    for i=numStudent+7:numStudent+11
        complete_pre_data_test=[complete_pre_data_test,student{i}.pre];
        complete_post_data_test=[complete_post_data_test,student{i}.post];
    end  
end