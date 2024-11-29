function dP = dP_hs(props, N, t, b, Hfin, V)
    % Pressure drop:
    sg=1-((N-1).*t)./props.W;
    Kc = 0.42.*(1-sg.^2);
    Ke = (1-sg.^2).^2;
    DH = 2.*(b.*Hfin)./(b+Hfin);
    ReDh = props.rou_air.*V.*DH./props.mu_air;
    L_star=props.L./(DH.*ReDh);
    f=(24-32.527.*(b./Hfin)+46.721.*(b./Hfin).^2-40.829.*(b./Hfin).^3+22.954.*(b./Hfin).^4-6.089.*(b./Hfin).^5)./ReDh;
    fapp=sqrt((3.44./sqrt(L_star)).^2+(f.*ReDh).^2)./ReDh;
    dP = (Kc+4.*fapp.*props.L./DH+Ke).*props.rou_air.*V.^2./2;
end