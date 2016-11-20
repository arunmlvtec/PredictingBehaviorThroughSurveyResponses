function survey=PRESurvey()
survey(1) = input1('how is the prep? (1:Bad, 2, or 3)',3);
if(survey(1) == 1)% 1 => bad
   survey(end+1) = input1('Are you facing trouble understanding the material? (1:Yes,2)',2);
   if(survey(end) == 1) %Yes
       survey =[survey, ttprof()];
   else % No
       survey = [survey, lackingMaterial()];
   end
   
elseif(survey(1) == 2) % 2 => somewhat good
    survey(end+1) = input1('Tried outside material?(1:Yes,2)',2);
    if(survey(end) == 1) % Yes
        survey = [survey, lackingMaterial()];
    else
        survey =[survey, ttprof()];
    end
elseif(survey(1) == 3) % 3 => good
    survey = [survey, lackingMaterial()];
end
end


function retVal=lackingMaterial()
    retVal = input1('Lacking material? (1:Yes,2)',2);
    if(retVal == 1) %Yes
        retVal = [retVal,ttprof()];
    else % No
        retVal = [retVal, busy()];
    end
end

function retVal = busy()
    retVal = input1('Other exam/homework? (1:Yes,2)',2);
end