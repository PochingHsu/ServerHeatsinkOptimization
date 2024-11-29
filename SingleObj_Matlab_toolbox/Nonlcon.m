function [C, Ceq] = Nonlcon(x,weights)
t1=x(1); t2=x(2); b1=x(3); b2=x(4); Hfin=x(5); Va=x(6);
% Parameters
props = getGeometryProperties();
% heatsink 1:
[R_hs1, N1, V1, ~] = TR_hs(props, t1, b1, Hfin, Va);
% heatsink 2:
[R_hs2, N2, V2, Hbase] = TR_hs(props, t2, b2, Hfin, Va);
% CPUs heat dissipated
Q1 = (props.Tcpu-props.Ta1)./(props.R_jc+props.R_TIM+R_hs1);
Ta2 = Q1./(props.rou_air.*Va.*props.Cp_air)+props.Ta1;
Q2 = (props.Tcpu-Ta2)./(props.R_jc+props.R_TIM+R_hs2);
Ta3 = Q2./(props.rou_air.*Va.*props.Cp_air)+Ta2;
% Constraints
C(1)=Ta2-Ta3-props.espT;
% Practical Constraints
C(2)=Ta2-props.Tcpu;
C(3)=(0.002.*Ta3.^3-0.1857.*Ta3.^2+6.3071.*Ta3-64.0571).*0.00047194745-Va; % Minimum air flow for GPU [m^3/sec]
C(4)=Ta3-50; % GPU card inlet temperature
C(5)=(Hfin+Hbase-props.Hmax)*100; % heatsink fin height
C(6)=(2e-3-Hbase)*100; % Hbase > 2mm
Ceq(1)=((props.W+b1)/(b1+t1))-N1;
Ceq(2)=((props.W+b2)/(b2+t2))-N2;
% Pressure drop:
dP_hs1 = dP_hs(props, N1, t1, b1, Hfin, V1);
dP_hs2 = dP_hs(props, N2, t2, b2, Hfin, V2);
P = dP_hs1+dP_hs2;
C(7)=P-90; % dP < 90 pa
% Fan curve constraint
%Ceq(3)=((8e10).*(Va.^4)-(4e9).*(Va.^3)+(5e7).*(Va.^2)-262001.*(Va)+1571.3)-P;

end