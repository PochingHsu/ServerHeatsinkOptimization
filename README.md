# Blade server CPU heatsinks optimization
![Sys_pic](https://github.com/user-attachments/assets/1a99af17-b0d7-454d-aade-dd8828da8344)
<br/>
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

**Objectives:**

1. **Maximize the heat removed from least heat removed CPU:**
```math
\underset{\overrightarrow{x}}{argmax}\left\{  min[Q_{CPU1}(\overrightarrow{x}), Q_{CPU2}(\overrightarrow{x})]\right\}
```
2. **Minimizing pressure drop of CPU heatsinks:**
```math
\underset{\overrightarrow{x}}{argmin}\left[\Delta P_{HS1}(\overrightarrow{x}) + \Delta P_{HS2}(\overrightarrow{x})\right]
```
**Design Variables:**

1. CPU1 heatsink:
   - Fin spacing [mm] $1\le b_{1}\le3$
   - Fin thickness [mm] $0.2\le t_{fin, 1}\le3$
2. CPU2 heatsink:
   - Fin spacing [mm] $1\le b_{2}\le3$
   - Fin thickness [mm] $0.2\le t_{fin, 2}\le3$
3. Air flow rate [m^3/s] $0\le \forall_{air}\le0.02$
4. Fin height for both heatsinks [mm] $H_{fin}$

**Constraints:**

1. CPU2 heatsink inlet [C] $T_{a2}\le T_{a3}-\epsilon_{T}$
2. CPU2 heatsink inlet [C] $T_{a2}\le T_{jc,cpu}$
3. GPU card airflow rate [m^3/s] $\forall_{air} \ge \forall_{min}=f_{GPU}(T_{a3})$
4. GPU card inlet temperature [C] $T_{a3}\le 50$
5. Heatsink total height [mm] $H_{fin} + H_{base} \le 44.45-H_{mb}-H_{cpu}-\epsilon$
6. Heatsink base height [mm] $H_{base}\ge 2$
7. Total pressure drop of CPU heatsinks [Pa] $dP_{total}\le 90$ (only used in single-obj optimization)

**Optimization methods:**

1. Single-Objective Optimization:
   - MATLAB "fmincon" function
   - Augmented Lagrangian Method (ALM)
2. Bi-Objective Optimization:
   - MATLAB "goalattain" function
   - Weight sum methods

# Results
![Results](https://github.com/user-attachments/assets/62347d9e-fe75-4a90-8a9a-4692eb09dab0)
| ----------------| $Q_1$     | $Q_2$      | $P_{total}$      | $t_{fin,1}$, $t_{fin,2}$ | $b_{fin,1}$, $b_{fin,2}$      | $H_{fin}$      | $\forall_{air}$     |
|-----------------|----------------|----------------|----------------|----------------|----------------|----------------|----------------|
| Row 1, Cell 1  | Row 1, Cell 2  | Row 1, Cell 3  | Row 1, Cell 3  | Row 1, Cell 3  | Row 1, Cell 3  | Row 1, Cell 3  |Row 1, Cell 3  |
| Row 2, Cell 1  | Row 2, Cell 2  | Row 2, Cell 3  | Row 1, Cell 3  | Row 1, Cell 3  | Row 1, Cell 3  | Row 1, Cell 3  |Row 1, Cell 3  |
| Row 3, Cell 1  | Row 3, Cell 2  | Row 3, Cell 3  | Row 1, Cell 3  | Row 1, Cell 3  | Row 1, Cell 3  | Row 1, Cell 3  |Row 1, Cell 3  |
**Reference**
[^1]: Culham, J.R., and Muzychka, Y.S. “Optimization of Plate Fin Heat Sinks Using Entropy Generation Minimization,” IEEE Trans. Components and Packaging Technologies, Vol. 24, No. 2, pp. 159-165, 2001.
