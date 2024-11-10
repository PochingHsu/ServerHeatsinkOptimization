This project is working on optimizing the blade server CPU heatsinks

The thermal resustance of heatsink is calculated as: <br/>
$R_{hs}=\frac{1}{h\cdot (A_{base}+N_{fin}\cdot \eta_{fin}\cdot A_{fin})}$ <br/>
where <br/>
Heatsink base area $A_{base}=(N_{fin}-1)\cdot b\cdot L$ <br/>
Fin area $A_{fin}=2H_{fin}\cdot L$ <br/>
Fin effieiceny $\eta_{fin}=\frac{tanh(m\cdot H_{fin})}{m\cdot H_{fin}}$ <br/>
$m=\sqrt{\frac{2h}{k_{fin}\cdot t_{fin}}}$, $h=Nu_{b}\frac{k_{air}}{b}$ <br/>
$b=\frac{W-N\cdot t_{fin}}{N-1}$

