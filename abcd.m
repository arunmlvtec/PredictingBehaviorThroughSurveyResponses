%
function abcd()
for s=1:30
    disp(['student ' num2str(s)])
for i=1:10
    data{s}.presurvey{i} = input(['pre ' num2str(i) ': ']);
end
save('dat2.mat','data')
end