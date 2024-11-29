function f = fminBiObj_goalattain(x)
t1=x(1); t2=x(2); b1=x(3); b2=x(4); Hfin=x(5); Va=x(6);
% Parameters
props = getGeometryProperties();
% heatsink 1:
[R_hs1, N1, V1, ~] = TR_hs(props, t1, b1, Hfin, Va);
% heatsink 2:
[R_hs2, N2, V2, ~] = TR_hs(props, t2, b2, Hfin, Va);
% Obj1: CPUs heat dissipated
Q1 = (props.Tcpu-props.Ta1)./(props.R_jc+props.R_TIM+R_hs1);
Ta2 = Q1./(props.rou_air.*Va.*props.Cp_air)+props.Ta1;
Q2 = (props.Tcpu-Ta2)./(props.R_jc+props.R_TIM+R_hs2);
f(1) = -min(Q1,Q2);
f(1) = (f(1)-props.fmin(1))./(props.fmax(1)-props.fmin(1)); % normalize
% Obj2: Pressure drop
% Pressure drop:
dP_hs1 = dP_hs(props, N1, t1, b1, Hfin, V1);
dP_hs2 = dP_hs(props, N2, t2, b2, Hfin, V2);
dP_total = dP_hs1+dP_hs2;
f(2) = (dP_total-props.fmin(2))./(props.fmax(2)-props.fmin(2)); % normalize
end