clear; clc; close all;
cd ..
system ('./ard.sh')
cd matlab/
runMe_fuser_dm;
runMeB_fast_spanning_tree;
%runMeC_drawresults;