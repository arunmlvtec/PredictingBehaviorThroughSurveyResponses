% student_data={};
load('student.mat')
str={'hw1','hw2','pro1','ex1','hw3','pro2','hw4','pro3','hw5','ex2'};
for i=1:28
    disp(['student: ' num2str(i)])
    for j=1:10
        num=input([str{j} '# responses:']);
        for k=1:num
            student_data{i}.post{j}(k)=input([num2str(k) ':']);
        end
    end
    save('student.mat','student_data');
    disp('saved')
end