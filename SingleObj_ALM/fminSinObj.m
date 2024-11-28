function Ttot = fminSinObj(x)
t1=x(1); t2=x(2); b1=x(3); b2=x(4); Hfin=x(5); Va=x(6);
% Parameters
props = getGeometryProperties();
% heatsink 1:
[R_hs1, N1, V1] = TR_hs(props, t1, b1, Hfin, Va);
% heatsink 2:
[R_hs2, N2, V2] = TR_hs(props, t2, b2, Hfin, Va);
% CPU temp
Tcpu1 = props.Q.*(props.R_jc+props.R_TIM+R_hs1)+props.Ta1;
Ta2 = props.Q./(props.rou_air.*Va.*props.Cp_air)+props.Ta1;
Tcpu2 = props.Q.*(props.R_jc+props.R_TIM+R_hs2)+Ta2;
%Ttot = (Tcpu1+Tcpu2);
Ttot = max(Tcpu1,Tcpu2)/-(Tcpu1+Tcpu2);
% Pressure drop:
dP_hs1 = dP_hs(props, N1, t1, b1, Hfin, V1);
dP_hs2 = dP_hs(props, N2, t2, b2, Hfin, V2);
P = dP_hs1+dP_hs2;
end