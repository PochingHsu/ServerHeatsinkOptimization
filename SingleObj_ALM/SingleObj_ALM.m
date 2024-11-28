clc;clear all
% Parameters
props = getGeometryProperties();
LmG=ones(1,18); % 17 inequality constraints
LmH=ones(1,3); % 3 equality constraints
rP=1.2;
gama=1.5;
rPmax=50;
tol=1e-6;
% [tfin1, tfin2, bfin1, bfin2, Hfin, Vair]
x0=[1.5e-3,1.5e-3,1.5e-3,1.5e-3,0.022, 0.01];
do=true; % do-while loop
while do
       %minX=powellS(ALM, x0, 1e-6); % Self-developped
       %minX=fminsearch(ALM,x0); % non-gradient based
       %options = optimset('MaxFunEvals', 1e6);
       options = optimset('Display','iter','MaxFunEvals', 1e6);
       minX = fminsearch(@(x) ALM(x, LmG, LmH, rP), x0, options);
       %minX=fminunc(ALM,x0); % gradient based
       %minX = fminunc(@(x) ALM(x, LmG, LmH, rP), x0, options);
       disp(norm(minX-x0))
    if norm(minX-x0)<tol
        do=false;
        minFuncValue=ALM(minX, LmG, LmH, rP); % calculate minimize function value
    else
        x0=minX;
    end
    % update Lamda
    [LmG, LmH] = Lamda(minX, LmG, LmH, rP);
    %update rP
    rP=gama*rP;
    if rP > rPmax
        rP=rPmax;
    end
end
fval = fminSinObj(minX);
%% Calculate result at optimimum point
t1=minX(1); t2=minX(2); b1=minX(3); b2=minX(4); Hfin=minX(5); Va=minX(6);
% heatsink 1:
[R_hs1, N1, V1, ~] = TR_hs(props, t1, b1, Hfin, Va);
% heatsink 2:
[R_hs2, N2, V2, Hbase] = TR_hs(props, t2, b2, Hfin, Va);
% CPU temp
Tcpu1 = props.Q.*(props.R_jc+props.R_TIM+R_hs1)+props.Ta1;
Ta2 = props.Q./(props.rou_air.*Va.*props.Cp_air)+props.Ta1;
Tcpu2 = props.Q.*(props.R_jc+props.R_TIM+R_hs2)+Ta2;
Ta3 = props.Q./(props.rou_air.*Va.*props.Cp_air)+Ta2;
% Pressure drop:
dP_hs1 = dP_hs(props, N1, t1, b1, Hfin, V1);
dP_hs2 = dP_hs(props, N2, t2, b2, Hfin, V2);
P = dP_hs1+dP_hs2;