function survey=POSTSurvey()
    survey(1) = input1('how was the Exam/homework? (1:Bad, 2, or 3)',3);
    if(survey(1) == 1)% 1 => bad
        survey = [survey, betterOrWorse()];
        if(survey(2) == 1) % Better
            survey(end+1) = input1('How well related was the material for the exam? (1:Poor, 2)',2);
            if(survey(end) == 1)
                survey = [survey, ttprof()];
            else
                survey = [survey, unforseen()];
            end
        elseif(survey(2) == 2) % Worse
            survey(end+1) = input1('Having trouble concentrating? (1:Yes,2)',2);
            if(survey(end) == 1) % Yes
                survey = [survey, ttprof()];
            else
                survey = [survey, unforseen()];
            end
        end
    elseif(survey(1) == 2) % somewhat good
        survey = [survey, betterOrWorse()];
        if(survey(end) == 2) %Worse
            survey = [survey, unforseen()];
        end
    elseif(survey(1) == 3) %Good
        survey = [survey, betterOrWorse()];
        if(survey(end) == 2) % Worse
            survey(end+1) = input1('Prob more complicated than material? (1:Yes,2)',2);
            if(survey(end) == 2) % No
                survey = [survey, unforseen()];
            end
        end
    end
end

function retVal = betterOrWorse()
    retVal = input1 ('Better or Worse than expectation? (1: Better, 2): ',2);
end

function retVal = unforseen()
    retVal = input1 ('Did you face any unforeseen circumstance? (1: Yes, 2): ',2);
end