clear all
% Parameters
props = getGeometryProperties();
% Initial points, upper boundary, lower boundary
% [tfin1, tfin2, bfin1, bfin2, Hfin, Vair]
x0=[1.5e-3,1.5e-3,1.5e-3,1.5e-3,0.022,0.01];
ub=[3e-3,3e-3,3e-3,3e-3,props.Hmax,0.015];
lb=[2e-4,2e-4,1e-3,1e-3,0,0];
options = optimoptions(@fmincon,'Display','iter','Algorithm','interior-point','MaxIter',1e5,'MaxFunEvals',1e5);
weights = 0:0.025:1;
for i=1:length(weights)
    wn=weights(i);
    [x,fval,exitflag,output] = fmincon('fminBiObj_weightsum',x0,[],[],[],[],lb,ub, ...
        'Nonlcon_bi',options,wn);
    [phi,f] = fminBiObj_weightsum(x,wn);
    f1(i)=f(1);
    f2(i)=f(2);
end
%%
[phi,f] = fminBiObj_weightsum(x,wn);
[f2sort,indxf2]=sort(f2);
f1sort=f1(indxf2);
plot(f1sort,f2sort,'ko');
xlabel('Negative min(Q1,Q2) [W]',FontSize=18)
ylabel('Pressure drop [Pa]',FontSize=18)
title('weightsum',FontSize=18)
ylim([60 450]);
%xlim([-260 -100])
%saveas(gcf,'MutilObj_weightsum.png')