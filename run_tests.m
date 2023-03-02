%% Run tests
% source: https://www.mathworks.com/help/matlab/matlab_prog/write-function-based-unit-tests.html
results=runtests('tests.m');
disp(table(results));