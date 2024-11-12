function [R_hs, N, V] = TR_hs(props, t, b, Hfin, Va)
    Pr = props.mu_air.*props.Cp_air./props.kair;
    N = round((props.W+b)/(b+t)); % Fin number
    V = Va./((N-1).*b.*Hfin);
    Re = props.rou_air.*V.*b./props.mu_air.*b./props.L;
    Nu = [1./(Re.*Pr./2).^3+1./(0.664.*sqrt(Re).*Pr.^0.33.*sqrt(1+3.65./sqrt(Re))).^3].^(-0.33);
    h=Nu.*props.kair./b; % Heat transfer coefficient[W/(m^2*K)]
    m = sqrt(2.*h./(props.kfin.*t));
    Abase = (N-1).*b.*props.L;
    Afin = 2.*Hfin.*props.L;
    eff_fin1 = tanh(m.*Hfin)./(m.*Hfin);
    R_hs = 1./(h.*(Abase+N.*eff_fin1.*Afin));
end

