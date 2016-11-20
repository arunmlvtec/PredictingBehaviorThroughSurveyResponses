%Simulated Annealing example
function xyz()
    ObjectiveFunction = @simple_objective;
    X0 = [0.5 0.5];   % Starting point
    lb = [-64 -64];
    ub = [64 64];
    [x,fval,exitFlag,output] = simulannealbnd(ObjectiveFunction,X0,lb,ub)
end

function y = simple_objective(x)
   y = (4 - 2.1*x(1)^2 + x(1)^4/3)*x(1)^2 + x(1)*x(2) + ...
       (-4 + 4*x(2)^2)*x(2)^2;
end