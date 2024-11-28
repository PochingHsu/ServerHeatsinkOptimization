function [LmG, LmH] = Lamda(minX, LmG, LmH, rP)
    [C, Ceq] = Nonlcon(minX);
    for i=1:length(C)
        LmG(i)=LmG(i)+2*rP*max(C(i),-LmG(i)/2/rP);
    end
    for j=1:length(Ceq)
        LmH(j)=LmH(j)+2*rP*Ceq(j);
    end

end