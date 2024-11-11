This project is working on optimizing the blade server CPU heatsinks
**The Cauchy-Schwarz Inequality**
$$\left( \sum_{k=1}^n a_k b_k \right)^2 \leq \left( \sum_{k=1}^n a_k^2 \right) \left( \sum_{k=1}^n b_k^2 \right)$$
The thermal resustance of heatsink is calculated as: <br/>

$$R_{hs}=\frac{1}{h\cdot (A_{base}+N_{fin}\cdot \eta_{fin}\cdot A_{fin})}$$ <br/>
where <br/>
Heatsink base area $A_{base}=(N_{fin}-1)\cdot b\cdot L$ <br/>
Fin area $A_{fin}=2H_{fin}\cdot L$ <br/>
Fin effieiceny $\eta_{fin}=\frac{tanh(m\cdot H_{fin})}{m\cdot H_{fin}}$ where $m=\sqrt{\frac{2h}{k_{fin}\cdot t_{fin}}}$ <br/>
Heat transfer coefficient $h=Nu_{b}\frac{k_{air}}{b}$ <br/>
Fin spacing $b=\frac{W-N\cdot t_{fin}}{N-1}$

Air velocity between fins $V = \frac{\forall _{air}}{(N_{fin}-1)\cdot b\cdot H_{fin}}$ <br/> <br/>

Dimensionless numbers: <br/>
$Pr=\frac{\mu\cdot Cp}{k}$ <br/>
$Re_{b}^*=Re_{b}\cdot \frac{b}{L}=\frac{\rho\cdot V\cdot b}{\mu}\cdot \frac{b}{L}$ <br/>
$Nu_{b}=$

