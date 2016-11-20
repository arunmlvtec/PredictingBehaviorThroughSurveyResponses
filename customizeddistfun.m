function dist = customizeddistfun(x, y, initWeights)
    size_weight = size(initWeights,2);
    difArray = ones(1,size_weight);
    compLen = 0;
    dist = 0;
    if (size(x,1) <= size(y,1))
        compLen = size(x,1);
        diff = size(y,1) - size(x,1);
    else
        compLen = size(y,1);
        diff = size(x,1) - size(y,1);
    end
    for i=1:size_weight
        if (i <= compLen)
            if (x(i,1) == y(i,1))
                difArray(i) = 0;
            end
        elseif ((diff + i) <= size_weight)
                i = i + diff;
                if (size(x,1) == size(y,1))
                    difArray(i) = 0;
                end
        else
            difArray(i) = 0;
        end
    end
    for i = 1:size_weight
         dist = dist + difArray(i) * initWeights(i);
    end
end