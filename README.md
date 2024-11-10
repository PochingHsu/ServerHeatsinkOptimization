This project is working on optimizing the blade server CPU heatsinks

The thermal resustance of heatsink is calculated as: <br/>
$R_{hs}=\frac{1}{h(A_{base}+N_{fin}\eta_{fin}A_{fin})}$ <br/>
where <br/>
Heatsink base area $A_{base}=(N_{fin}-1)bL$ <br/>
Fin area $A_{fin}=2H_{fin}L$ <br/>
Fin effieiceny $\eta_{fin}=\frac{tanh(mH_{fin})}{mH_{fin}}$ <br/>
