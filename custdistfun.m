function distance = custdistfun(actual,predicted,postcentroids,varargs)
    distance = 0;
    for i=1:varargs
        distance = distance + customizeddistfun(postcentroids{actual(i)}',postcentroids{predicted(i)}',10);
    end
end