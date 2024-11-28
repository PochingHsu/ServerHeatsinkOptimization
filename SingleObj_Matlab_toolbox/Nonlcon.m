function [C, Ceq] = Nonlcon(x,weights)
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
% Constraints
C(1)=Tcpu1-70; % CPU spec. 70c
C(2)=Tcpu2-70; % CPU spec. 70c
C(3)=Ta2-Ta3-props.espT;
% Practical Constraints
C(4)=props.Ta1-Tcpu1;
C(5)=Ta2-Tcpu2;
C(6)=(0.002.*Ta3.^3-0.1857.*Ta3.^2+6.3071.*Ta3-64.0571).*0.00047194745-Va; % Minimum air flow for GPU [m^3/sec]
C(7)=Ta3-50; % GPU card inlet temperature
C(8)=(Hfin+Hbase-props.Hmax)*100; % heatsink fin height
C(9)=(2e-3-Hbase)*100; % Hbase > 2mm
Ceq(1)=((props.W+b1)/(b1+t1))-N1;
Ceq(2)=((props.W+b2)/(b2+t2))-N2;
% Pressure drop:
dP_hs1 = dP_hs(props, N1, t1, b1, Hfin, V1);
dP_hs2 = dP_hs(props, N2, t2, b2, Hfin, V2);
P = dP_hs1+dP_hs2;
% Fan curve constraint
%Ceq(3)=0.0004.*(Va./0.00047194745).^4-0.0387.*(Va./0.00047194745).^3+1.0685.*(Va./0.00047194745).^2 ...
%    -12.6708.*(Va./0.00047194745)+160.3425-P*0.1;
Ceq(3)=((8e10).*(Va.^4)-(4e9).*(Va.^3)+(5e7).*(Va.^2)-262001.*(Va)+1571.3)-P;

end