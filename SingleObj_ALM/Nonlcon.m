function [C, Ceq] = Nonlcon(x)
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
% Pressure drop:
dP_hs1 = dP_hs(props, N1, t1, b1, Hfin, V1);
dP_hs2 = dP_hs(props, N2, t2, b2, Hfin, V2);
P = dP_hs1+dP_hs2;
% Constraints:
C(1)=Ta2-Ta3-props.espT; % Ta2 < Ta3
C(2)=Ta2-props.Tcpu; % Ta2 < Tcpu1
C(3)=(0.002.*Ta3.^3-0.1857.*Ta3.^2+6.3071.*Ta3-64.0571)...
    .*0.00047194745-Va; % min air flow rate for GPU [m^3/sec]
C(4)=Ta3-50; % GPU inlet < 50c
C(5)=(Hfin+Hbase-(props.Hmax))*100; % HS fin height limits
C(6) = (2e-3-Hbase)*100; % Hbase > 1mm
C(7)=t1-3e-3; % t1 upperboud: 3mm
C(8)=2e-4-t1; % t1 lowerboud: 0.2mm
C(9)=t2-3e-3; % t2 upperboud: 3mm
C(10)=2e-4-t2; % t2 lowerboud: 0.2mm
C(11)=b1-3e-3; % b1 upperboud: 3mm
C(12)=1e-3-b1; % b1 lowerboud: 1mm
C(13)=b2-3e-3; % b2 upperboud: 3mm
C(14)=1e-3-b2; % b2 lowerboud: 1mm
C(15)=(Va-0.02)*100; % Va upperboud: 0.02 m^3/s (max flow rate by fan)
C(16)=0.01-Va; % Va lowerboud: 0.01 m^3/s
C(17)=N1-30; % fin# upperboud for stability
C(18)=N2-30; % fin# upperboud for stability
C(19)=P-90; % dP upperboud: 500 pa
Ceq(1)=((props.W+b1)/(b1+t1))-N1;
Ceq(2)=((props.W+b2)/(b2+t2))-N2;
%Ceq(3)=((8e10).*(Va.^4)-(4e9).*(Va.^3)+(5e7).*...
%    (Va.^2)-262001.*(Va)+1571.3)-P; % fan curve
end