function minFuncValue = ALM(x, LmG, LmH, rP)
    [C, Ceq] = Nonlcon(x);
    minFuncValue = fminSinObj(x);
    for i = 1:length(C)
        minFuncValue = minFuncValue + LmG(i)*max(C(i),-LmG(i)/2/rP)+rP*max(C(i),-LmG(i)/2/rP);
    end
    for j = 1:length(Ceq)
        minFuncValue = minFuncValue + LmH(j)*Ceq(j)+rP*(Ceq(j))^2;
    end
end