function props = getGeometryProperties()
    % CPU
    props.A_cpu = 0.062 * 0.082; % CPU area [m^2]
    props.Hcpu = 0.01543; % CPU height [m]
    props.t_TIM = 25e-06; % thickness of thermal interface material (TIM) [m]
    props.k_TIM = 6; % thermal conductivity of TIM [W/(m*K)]
    props.R_jc = 0.025; % thermal resistance of CPU junction to case [C/W]
    props.R_TIM = props.t_TIM/(props.k_TIM*props.A_cpu); % thermal resistance of TIM [C/W]
    props.Tcpu = 70; % CPU max temp.
    % Heatsink
    props.L = 0.108; % length of heatsink[m]
    props.W = 0.078; % width of heatsink[m]
    props.H_server = 0.04445; % height of 1U server [m]
    props.Ta1 = 24; % server inlet air temperature [C]
    props.Hmb = 0.0016; % thickness of mother board [m] 
    props.kfin = 398; % thermal conductivity of fin (copper) [W/(m-K)]
    props.kair = 0.025; % thermal conductivity of air [W/(m-K)]
    props.rou_air = 1.23 ; % density of air[kg/m^3]
    props.Cp_air = 1007 ; % specific heat of air[J/kg-K]
    props.mu_air = 1.802e-5; % viscosity of air [kg/m-s]
    props.esp = 0.0005; % gap btw chassis and device
    props.espT = 0;
    props.Hmax = props.H_server - props.Hmb - props.Hcpu - props.esp; % maximum height of heatsink [m]
    %espT = 0;
end