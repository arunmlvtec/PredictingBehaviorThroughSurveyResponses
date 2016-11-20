function abc()
    global numstate
    numstate = 1;
    triggerModel();
    ObjectiveFunction = @learnClustering;
    X0 = [rand(1,4)];
    lb = [zeros(1,4)];
    ub = [ones(1,4)];
    options = optimoptions(@simulannealbnd, ...
                     'PlotFcn',{@saplotbestf,@saplottemperature,@saplotf,@saplotstopping});
    [x,fval,exitFlag,output] = simulannealbnd(ObjectiveFunction,X0,lb,ub,options);
    
end