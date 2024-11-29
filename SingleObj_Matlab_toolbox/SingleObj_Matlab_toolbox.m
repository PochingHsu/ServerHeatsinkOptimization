clc;clear;
% Parameters
props = getGeometryProperties();
% optimization: initial points, upper boundary, lower boundary
% [tfin1, tfin2, bfin1, bfin2, Hfin, Vair]
x0=[2e-3,2e-3,1.5e-3,1.5e-3,0.022,0.01];
ub=[3e-3,3e-3,3e-3,3e-3,props.Hmax,0.02];
lb=[2e-4,2e-4,1e-3,1e-3,0,0];
% optimization: linear constraints
options = optimoptions("fmincon",...
    "Algorithm","interior-point",...
    "EnableFeasibilityMode",true,...
    "SubproblemAlgorithm","cg",'Display','iter','MaxFunctionEvaluations', 1e6);
%options = optimoptions(@fmincon,'Display','iter','Algorithm','interior-point');
[x,fval] = fmincon('fminSinObj',x0,[],[],[],[],lb,ub,'Nonlcon',options);
%% Calculate result at optimimum point
t1=x(1); t2=x(2); b1=x(3); b2=x(4); Hfin=x(5); Va=x(6);
% heatsink 1:
[R_hs1, N1, V1, ~] = TR_hs(props, t1, b1, Hfin, Va);
% heatsink 2:
[R_hs2, N2, V2, Hbase] = TR_hs(props, t2, b2, Hfin, Va);
% CPUs heat dissipated
Q1 = (props.Tcpu-props.Ta1)./(props.R_jc+props.R_TIM+R_hs1);
Ta2 = Q1./(props.rou_air.*Va.*props.Cp_air)+props.Ta1;
Q2 = (props.Tcpu-Ta2)./(props.R_jc+props.R_TIM+R_hs2);
Ta3 = Q2./(props.rou_air.*Va.*props.Cp_air)+Ta2;
% Pressure drop:
dP_hs1 = dP_hs(props, N1, t1, b1, Hfin, V1);
dP_hs2 = dP_hs(props, N2, t2, b2, Hfin, V2);
P = dP_hs1+dP_hs2;