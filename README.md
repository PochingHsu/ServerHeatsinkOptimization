This project is working on optimizing the blade server CPU heatsinks <br/>

The thermal resustance of heatsink is calculated as: <br/>
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
V = \frac{\forall_{air}}{(N_{fin}-1)\cdot b \cdot H_{fin}}
Dimensionless numbers: <br/>
$Pr=\frac{\mu\cdot Cp}{k}$ <br/>
$Re_{b}^*=Re_{b}\cdot \frac{b}{L}=\frac{\rho\cdot V\cdot b}{\mu}\cdot \frac{b}{L}$ <br/>
$Nu_{b}=$

