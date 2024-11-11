This project is working on optimizing the blade server CPU heatsinks <br/>
# Heatink modeling
We are using the heat sink model from Culham and Muzychka (2001) [^1] <br/><br/>
**Thermal resistance of heatsink:** <br/>
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
$b=\frac{W-N\cdot t_{fin}}{N-1}$
<br/><br/>
**Nusselt number:**
```math
Nu_{b}=\left[ (\frac{Re_{b}^*\cdot Pr}{2})^{-3}+\left(0.664\sqrt{Re_{b}^*}\cdot Pr^{1/3}\cdot \sqrt{1+\frac{3.65}{\sqrt{Re_{b}^*}}}  \right)^{-3} \right]^{-1/3}
```
where 
```math
Pr=\frac{\mu\cdot Cp}{k}
```
```math
Re_{b}^*=Re_{b}\cdot \frac{b}{L}=\frac{\rho\cdot V\cdot b}{\mu}\cdot \frac{b}{L}
```
```math
V = \frac{\forall_{air}}{(N_{fin}-1)\cdot b \cdot H_{fin}}
```
**Pressure drop of heatsink:** <br/>
```math
\Delta P=(K_{c}+4\cdot f_{app}\cdot\frac{L}{D_{h}}+K_{e})\frac{\rho V^{2}}{2}
```
$K_{c}=0.42(1-\sigma^{2})$ and $K_{e}=(1-\sigma^{2})^{2}$ are the pressure loss due to sudden contraction and expansion, respectively, where $\sigma=1-\frac{N\cdot t}{W}$
<br/>
<br/>
Apparent friction factor:
```math
f_{app}=\frac{\left[ \left(  \frac{3.44}{\sqrt{L^*}}\right)^2+(f\cdot Re_{D_{h}})^2 \right]^{1/2}}{Re_{D_{h}}}
```
Fully developed flow friction factor:
```math
f=\frac{24-32.527(\frac{b}{H_{fin}})+46.721(\frac{b}{H_{fin}})^2-40.829(\frac{b}{H_{fin}})^3+22.954(\frac{b}{H_{fin}})^4-6.089(\frac{b}{H_{fin}})^5}{Re_{D_{h}}}
```
where $Re_{D_{h}}=\frac{\rho VD_{h}}{\mu}$, $L^*=\frac{L}{D_{h}Re_{D_{h}}}$
<br/>
# Optimization
Objectives:
<br/>
1. Minimizing CPU temperatures: Tcpu1+Tcpu2
2. Minimizing pressure drop of heatsinks: dP_hs1+dP_hs2
Design Variables:
1.
2.
3.
4. Air flow rate ($\forall_{air}$)
5. Fin height of two heatsinks ($H_{fin}$)
Variables
CPU1 
Fin spacing b1
Fin thickness tf,1
CPU2
Fin spacing b2
Fin thickness tf,2

<br/>
<br/>
**Reference**
[^1]: Culham, J.R., and Muzychka, Y.S. “Optimization of Plate Fin Heat Sinks Using Entropy Generation Minimization,” IEEE Trans. Components and Packaging Technologies, Vol. 24, No. 2, pp. 159-165, 2001.
