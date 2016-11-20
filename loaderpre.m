data2 = {};
counter=1;
counter2=1;
counter3=1;
load('k.mat');
load('k2.mat');
load('dat.mat');
p={};
for i=1:6
    for j=1:10
    p{counter3,1}=data{i}.presurvey{j};
    counter3=counter3+1;
    end
end
for i = 61:210
        p{counter3,1} = k{i-60};
        counter3 = counter3 + 1;
end
k = p;
temp={};
temp2={};
for s=1:21
for i=1:10
    temp{i}=k{counter};
    temp2{i}=k2{counter2};
    counter=counter+1;
    counter2=counter2+1;
end
data2{s}.pre=temp;
data2{s}.post=temp2;
end
for i=1:21
    student_data{end+1}=data2{i};
end
breakhere=1;