%% Main test function
% source: https://www.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests.html
function testcollection = tests
testcollection = functiontests(localfunctions);
end

%% Test 'to_glt'
function test_to_glt(testCase)
% a starting GLT matrix
sparse_matrix=[4, 0, 0, 0;
               0, -2, 0, 0;
               -1, 1, 0, 0;
               -3, 0, 0, 0;
               0, 2, 2, 0;
               1, -5, 3, 3;
               1, 1, 1, 1;
               1, 2, 3, 4;
               2, 1, 0, -1];
% an orthonormal rotation
rotation_matrix=[-0.72883764955166219, 0.64216679939770527, -0.237506809253953011, 0.0028280568103095094;
                 -0.21487437088930778, -0.23757796738246245, 0.028301013720456139, 0.9468816012425926854;
                 -0.44564025072535923, -0.69164998750579221, -0.505624669563513596, -0.2595549175906017858;
                 0.47331749625845398, 0.22977990762676095, -0.828935016578011608, 0.1898380364349491756];
rotated_matrix=rotation_matrix*sparse_matrix';
testCase.verifyEqual(to_glt(rotated_matrix), sparse_matrix', 'AbsTol', 2*sqrt(eps));
end

%% Test 'is_identified_identicator'
function test_is_identified_identicator(testCase)
test_cases={...
    struct('matrix',1,'result',false),...
    struct('matrix',[1; 1],'result',false),...
    struct('matrix',[1; 1; 1],'result',true),...
    struct('matrix',[1, 0;
                     1, 0;
                     0, 1;
                     0, 1;
                     1, 1],'result',true),...
    struct('matrix',[1, 0;
                     1, 0;
                     0, 1;
                     0, 1;
                     0, 1],'result',false),...
    struct('matrix',[1, 0, 0;
                     1, 0, 1;
                     0, 1, 0;
                     0, 1, 1;
                     1, 1, 1],'result',false),...
    struct('matrix',[1, 0, 0;
                     1, 0, 1;
                     0, 1, 0;
                     0, 1, 1;
                     0, 1, 1;
                     1, 1, 1;
                     1, 1, 1],'result',true)};

for k=1:size(test_cases,2)
    delta=test_cases{1,k}.matrix;
    result=test_cases{1,k}.result;
    testCase.verifyEqual(is_identified_indicator(delta'),result);
end
end

%% Test 'is_identified'
function test_is_identified(testCase)
% create an identified case
identified_matrix=[4, 0, 0, 0;
                   0, -2, 0, 0;
                   -1, 1, 0, 0;
                   -3, 0, 0, 0;
                   0, 2, 2, 0;
                   1, -5, 3, 3;
                   1, 1, 1, 1;
                   1, 2, 3, 4;
                   2, 1, 0, -1];
% an orthonormal rotation
rotation_matrix=[-0.72883764955166219, 0.64216679939770527, -0.237506809253953011, 0.0028280568103095094;
                 -0.21487437088930778, -0.23757796738246245, 0.028301013720456139, 0.9468816012425926854;
                 -0.44564025072535923, -0.69164998750579221, -0.505624669563513596, -0.2595549175906017858;
                 0.47331749625845398, 0.22977990762676095, -0.828935016578011608, 0.1898380364349491756];
rotated_matrix=rotation_matrix*identified_matrix';
testCase.verifyEqual(is_identified(rotated_matrix), true);

% a non-identified matrix
non_identified_matrix=[4, 0, 0, 0;
                       0, -2, 0, 0;
                       -1, 0, 0, 0;
                       -3, 0, 0, 0;
                       0, 2, 2, 0;
                       1, -5, 3, 3;
                       1, 1, 1, 1;
                       1, 2, 3, 4;
                       2, 1, 0, -1];
rotated_matrix2=rotation_matrix*non_identified_matrix';
testCase.verifyEqual(is_identified(rotated_matrix2), false);
end