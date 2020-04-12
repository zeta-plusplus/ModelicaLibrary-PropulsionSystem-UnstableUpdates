within PropulsionSystem.Elements.BasicElements;

model PropActDiskCharFixed00
  /********************************************************
          imports
      ********************************************************/
  import Modelica.Constants;
  import PropulsionSystem.Types.switches;
  /********************************************************
          Declaration
      ********************************************************/
  //********** Package **********
  //NONE
  //********** Parameters **********
  parameter Real effPropDes_def = 0.9 "propeller efficiency, design point, user-defined" annotation(
    Dialog(group = "characteristics"));
  //********** Internal variables **********
  Real effProp "propeller efficiency";
  Modelica.SIunits.Power pwr "power driving propeller";
  Modelica.SIunits.Power pwrPropulsive "propulsive power, defined by Fg*Vin";
  Modelica.SIunits.Torque trq "torque of drive shaft";
  Modelica.SIunits.AngularVelocity omega(start = 100.0) "mechanical rotation speed, rad/sec";
  Modelica.SIunits.Angle phi(start = 0.0) "mechanical rotation displacement, rad";
  Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm Nmech(start = 1000) "mechanical rotation speed, rpm";
  Modelica.SIunits.Force Fg "gross thrust generated by propeller";
  Modelica.SIunits.Velocity Vin "speed of freestream airflow";
  //----- Interfaces -----
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_1 annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_Fg annotation(
    Placement(visible = true, transformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_flowSpeed "speed of freestream flow" annotation(
    Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
//----- inputs -----
  Vin := u_flowSpeed;
  if Vin <= 0.0 then
    Vin := 0.1;
  end if;
  effProp := effPropDes_def;
//----- outputs -----
  y_Fg := Fg;
equation
//********** Equations **********
//----- interface <-> internal properties -----
  phi = flange_1.phi;
  trq = flange_1.tau;
//----- eqns describing physics -----
  der(phi) = omega;
  Nmech = Modelica.SIunits.Conversions.NonSIunits.to_rpm(omega);
  pwr = trq * omega;
  pwrPropulsive = pwr * effProp;
  pwrPropulsive = Fg * Vin;
//----- Internal Connections -----
/* none */
//********** Graphics **********
  annotation(
    Icon(graphics = {Rectangle(origin = {-43, 2}, fillPattern = FillPattern.Solid, extent = {{-1, 2}, {143, -6}}), Polygon(origin = {-57, 0}, fillPattern = FillPattern.Solid, points = {{-18, 0}, {10, 14}, {10, -14}, {-18, 0}}), Text(origin = {55, 84}, extent = {{-55, -4}, {45, -24}}, textString = "%name"), Polygon(origin = {-33, 44}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-12, -44}, {-8, 50}, {2, 56}, {10, -44}, {-12, -44}}), Polygon(origin = {-37, -44}, rotation = 180, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-12, -44}, {-8, 50}, {2, 56}, {8, -44}, {-12, -44}}), Ellipse(origin = {-33, 0}, extent = {{-47, 100}, {43, -100}}, endAngle = 360), Rectangle(origin = {-38, 1}, fillPattern = FillPattern.Solid, extent = {{-9, 13}, {15, -15}})}, coordinateSystem(initialScale = 0.1)));
end PropActDiskCharFixed00;
