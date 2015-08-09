clc;
close all;
clear all;

[V, F] = read_obj('face_HoleFilled.obj');

FV.vertices = V;
FV.faces = F;
save face_FV.mat FV;