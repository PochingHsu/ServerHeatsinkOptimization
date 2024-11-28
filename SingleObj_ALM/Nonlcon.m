function [C, Ceq] = Nonlcon(x)
t1=x(1); t2=x(2); b1=x(3); b2=x(4); Hfin=x(5); Va=x(6);
% Parameters
props = getGeometryProperties();
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
% Constraints:
C(1)=Tcpu1-70; % Tcpu1 < 70c (max cpu temp.)
C(2)=Tcpu2-70; % Tcpu2 < 70c (max cpu temp.)
C(3)=Ta3-50; % GPU inlet < 50c
C(4)=(0.002.*Ta3.^3-0.1857.*Ta3.^2+6.3071.*Ta3-64.0571)...
    .*0.00047194745-Va; % min air flow rate for GPU [m^3/sec]
C(5)=Ta2-Ta3-props.espT; % Ta2 < Ta3
C(6)=(Hfin+Hbase-(props.Hmax))*100; % HS fin height limits
C(7) = (2e-3-Hbase)*100; % Hbase > 1mm
C(8)=props.Ta1-Tcpu1; % Ta1 < Tcp1
C(9)=Ta2-Tcpu1; % Ta2 < Tcpu1
C(10)=t1-3e-3; % t1 < 3mm
C(11)=2e-4-t1; % t1 > 0.2mm
C(12)=t2-3e-3; % t2 < 3mm
C(13)=2e-4-t2; % t2 > 0.2mm
C(14)=b1-3e-3; % b1 < 3mm
C(15)=1e-3-b1; % b1 > 1mm
C(16)=b2-3e-3; % b2 < 3mm
C(17)=1e-3-b2; % b2 > 1mm
C(18)=Va-0.02; % Va < 0.02 m3/s (max flow rate by fan)
Ceq(1)=((props.W+b1)/(b1+t1))-N1;
Ceq(2)=((props.W+b2)/(b2+t2))-N2;
Ceq(3)=((8e10).*(Va.^4)-(4e9).*(Va.^3)+(5e7).*...
    (Va.^2)-262001.*(Va)+1571.3)-P; % fan curve
end