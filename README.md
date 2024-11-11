This project is working on optimizing the blade server CPU heatsinks <br/>

**Thermal resustance of heatsink:** <br/>
```math
R_{hs}=\frac{1}{h\cdot (A_{base}+N_{fin}\cdot \eta_{fin}\cdot A_{fin})}
```
where heatsink base area 
$A_{base}=(N_{fin}-1)\cdot b\cdot L$, 
fin area 
$A_{fin}=2H_{fin}\cdot L$, 
fin effieiceny 
$\eta_{fin}=\frac{tanh(m\cdot H_{fin})}{m\cdot H_{fin}}$, 
$m=\sqrt{\frac{2h}{k_{fin}\cdot t_{fin}}}$, 
heat transfer coefficient 
$h=Nu_{b}\frac{k_{air}}{b}$, 
fin spacing 
$b=\frac{W-N\cdot t_{fin}}{N-1}$, 
air velocity between fins 
$V = \frac{\forall_{air}}{(N_{fin}-1)\cdot b \cdot H_{fin}}$ <br/><br/>
**Dimensionless numbers:**
```math
Pr=\frac{\mu\cdot Cp}{k}
```
```math
Re_{b}^*=Re_{b}\cdot \frac{b}{L}=\frac{\rho\cdot V\cdot b}{\mu}\cdot \frac{b}{L}
```
```math
Nu_{b}=\left[ (\frac{Re_{b}^*\cdot Pr}{2})^{-3}+\left(0.664\sqrt{Re_{b}^*}\cdot Pr^{1/3}\cdot \sqrt{1+\frac{3.65}{\sqrt{Re_{b}^*}}}  \right)^{-3} \right]^{-1/3}
```
