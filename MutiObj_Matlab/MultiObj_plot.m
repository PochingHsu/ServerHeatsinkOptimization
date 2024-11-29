clear all
% Parameters
props = getGeometryProperties();
% Initial points, upper boundary, lower boundary
% [tfin1, tfin2, bfin1, bfin2, Hfin, Vair]
x0=[1.5e-3,1.5e-3,1.5e-3,1.5e-3,0.022,0.01];
ub=[3e-3,3e-3,3e-3,3e-3,props.Hmax,0.015];
lb=[2e-4,2e-4,1e-3,1e-3,0,0];
% MutiObj_weightsum
options = optimoptions(@fmincon,'Display','iter','Algorithm','interior-point','MaxIter',1e5,'MaxFunEvals',1e5);
weights = 0:0.025:1;
for i=1:length(weights)
    wn=weights(i);
    [x,~,exitflag,output] = fmincon('fminBiObj_weightsum',x0,[],[],[],[],lb,ub, ...
        'Nonlcon_bi',options,wn);
    [phi,f] = fminBiObj_weightsum(x,wn);
    obj1_ws(i)=f(1);
    obj2_ws(i)=f(2);
end
%%
% MutiObj_goalattain
t=0:0.025:0.975; % t=1 will go to infeasible region
for i=1:length(t) 
    weight = [t(i),1-t(i)];
    goal = [0,0];
    options = optimoptions('fgoalattain','Display','iter','MaxIter',1e4,'MaxFunEvals',1e4);
    [x(i,:),fval(i,:)] = fgoalattain('fminBiObj_goalattain',x0,goal,weight,[],[],[],[],lb,ub,'Nonlcon_bi',options);
end
obj_ga = fval.*(props.fmax-props.fmin)+props.fmin; % convert to original values
%%
figure
plot(obj_ga(:,1),obj_ga(:,2),'ko');
hold on
plot(obj1_ws,obj2_ws,'bo');
plot(-1.583883861048995e+02,89.999956091243690,'r+'); % Single-obj:ALM
plot(-1.162902677906116e+02,89.972656497771470,'g+'); % Single-obj:fmincon
legend('Multi-obj: goalattain','Multi-obj: weightsum','Single-obj:ALM','Single-obj:fmincom',FontSize=12);
xlabel('Negative min(Q1,Q2) [W]',FontSize=18);
ylabel('Pressure drop [Pa]',FontSize=18);
ylim([60 400]);
%xlim([-260 -100])
%saveas(gcf,'MutilObj.png')
