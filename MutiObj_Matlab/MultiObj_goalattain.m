clc;clear;
% Parameters
props = getGeometryProperties();
% Initial points, upper boundary, lower boundary
% [tfin1, tfin2, bfin1, bfin2, Hfin, Vair]
x0=[1.5e-3,1.5e-3,1.5e-3,1.5e-3,0.022,0.01];
ub=[3e-3,3e-3,3e-3,3e-3,props.Hmax,0.015];
lb=[2e-4,2e-4,1e-3,1e-3,0,0];
t=0.01:0.01:0.99; % t=1 will go to infeasible region
for i=1:length(t) 
    weight = [t(i),1-t(i)];
    goal = [0,0];
    options = optimoptions('fgoalattain','Display','iter','MaxIter',1e4,'MaxFunEvals',1e4);
    [x(i,:),fval(i,:)] = fgoalattain('fminBiObj_goalattain',x0,goal,weight,[],[],[],[],lb,ub,'Nonlcon_bi',options);
end
ffval = fval.*(props.fmax-props.fmin)+props.fmin; % convert to original values
%%
figure(1)
plot(ffval(:,1),ffval(:,2),'ko');
xlabel('Negative min(Q1,Q2) [W]',FontSize=18)
ylabel('Pressure drop [Pa]',FontSize=18)
title('goalattain',FontSize=18)
ylim([60 450]);
%xlim([-260 -100])
%saveas(gcf,'MutilObj_goalattain.png')