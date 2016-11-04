%% Scripts to look at transfer functions
% Author: Francis James
% Model: [mass_m]-[spring and damper]-[load_l]

clear all;

%% Set up parameters
model.k=100;    %Spring stiffness
model.c=1;      %damping
model.m_m=1;    %motor inertia
model.m_l=1;    %load inertia

controller.P=-1000;
controller.D=-100;


%% open loop transfer functions
%1) X_l/Xm
olsys1=tf([model.c,model.k],[model.m_l, model.c, model.k]);
%2) X_l/F_app
olsys2=tf([model.c, model.k],[model.m_l*model.m_m, model.c*(model.m_m+model.m_l), ...
    model.k*(model.m_m+model.m_l),0,0]);
%3) X_m/F_app
olsys3=tf([model.m_l, model.c, model.k],[model.m_l*model.m_m, model.c*(model.m_m+model.m_l), ...
    model.k*(model.m_m+model.m_l),0,0]);

%% Closed loop transfer functions
% Using PD controller with (x_l-x_m)_desired and its derivative = 0
%1) (x_l-x_m)/F_d
clsys1=tf([1/model.m_l],[1, (model.c/model.m_m+model.c/model.m_l-controller.D/model.m_m) ...
    model.k/model.m_m+model.k/model.m_l-controller.P/model.m_m]);
%2) Xl/Fd
clsys2=tf([model.m_m, model.c-controller.D, model.k-controller.P],[model.m_m*model.m_l, ... 
    model.c*model.m_l+model.c*model.m_m-controller.D*model.m_l, model.k*model.m_l+model.k*model.m_m ...
    -controller.P*model.m_l]);
%3) Xm/Fd
clsys3=tf([model.c-controller.D, -controller.P+model.k],[model.m_m*model.m_l, ... 
    model.c*model.m_l+model.c*model.m_m-controller.D*model.m_l, model.k*model.m_l+model.k*model.m_m ...
    -controller.P*model.m_l]);