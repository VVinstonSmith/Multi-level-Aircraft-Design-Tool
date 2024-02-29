import os
import os.path as pth
import openmdao.api as om
import logging
import shutil
import fastoad.api as oad
import numpy as np
from utils.data_output_funcs import mkdir, write_dict
p180 = np.pi/180.

DATA_FOLDER_PATH = "data"

WORK_FOLDER_PATH = "workdir"

CONFIGURATION_FILE = pth.join(DATA_FOLDER_PATH, "oad_process.yml")
SOURCE_FILE = pth.join(DATA_FOLDER_PATH, "CeRAS01_baseline.xml")

################################################################
# generate input file
oad.generate_inputs(CONFIGURATION_FILE, SOURCE_FILE, overwrite=True)

################################################################
# running optimization
prob = optim_problem = oad.optimize_problem(CONFIGURATION_FILE, overwrite=True)
om.n2(optim_problem)

print('#####################################')
print('variables:')
print('wing:aspect_ratio is', prob['data:geometry:wing:aspect_ratio'])
print('wing:virtual_taper_ratio is', prob['data:geometry:wing:virtual_taper_ratio'])
print('wing:kink:span_ratio is', prob['data:geometry:wing:kink:span_ratio'])
print('wing:MAC:at25percent:x is', prob['data:geometry:wing:MAC:at25percent:x'])
print('#####################################')
print('constraints:')
print('wing:span is', prob['data:geometry:wing:span'])
print('cruise:optimal_CL is', prob['data:aerodynamics:aircraft:cruise:optimal_CL'])
print('static_margin is', prob['data:handling_qualities:static_margin'])
print('#####################################')
print('objective:')
print('mission:block_fuel', prob['data:mission:sizing:block_fuel'])

# data extract:
################################################################
# wing_geometry:
half_span = prob["data:geometry:wing:span"][0] / 2
kink_span_ratio = prob["data:geometry:wing:kink:span_ratio"][0]

wing_MAC = prob["data:geometry:wing:MAC:length"][0]
x_MAC25_wing = prob["data:geometry:wing:MAC:at25percent:x"][0]
x_MAC_LE = x_MAC25_wing - 0.25*wing_MAC
x_root_LE_virtual = x_MAC_LE - prob["data:geometry:wing:MAC:leading_edge:x:local"][0]

y_kink = prob["data:geometry:wing:kink:y"][0]
c_kink = prob["data:geometry:wing:kink:chord"][0]
x_kink_LE = prob["data:geometry:wing:kink:leading_edge:x:local"][0] + x_root_LE_virtual
x_kink_TE = x_kink_LE + c_kink
x_kink_25 = x_kink_LE + 0.25*c_kink

y_tip = half_span
x_tip_LE = prob["data:geometry:wing:tip:leading_edge:x:local"][0] + x_root_LE_virtual
c_tip = prob["data:geometry:wing:tip:chord"][0]
x_tip_TE = x_tip_LE + c_tip
x_tip_25 = x_tip_LE + 0.25*c_tip

sweep_0_deg = prob["data:geometry:wing:sweep_0"][0]; sweep_0 = sweep_0_deg * p180
sweep_100_inner_deg = prob["data:geometry:wing:sweep_100_inner"][0]; sweep_100_inner = sweep_100_inner_deg * p180
sweep_100_outer_deg = prob["data:geometry:wing:sweep_100_outer"][0]; sweep_100_outer = sweep_100_outer_deg * p180
# np.tan(sweep_0) == (x_tip_LE - x_kink_LE) / (y_tip - y_kink)

x_root_LE = -y_kink * np.tan(sweep_0) + x_kink_LE
x_root_TE = -y_kink * np.tan(sweep_100_inner) + x_kink_TE
c_root = x_root_TE - x_root_LE
x_root_25 = x_root_LE + 0.25*c_root

sweep_25_inner_deg = np.arctan((x_kink_25-x_root_25)/y_kink) / p180
sweep_25_outer_deg = np.arctan((x_tip_25-x_kink_25)/(y_tip-y_kink)) / p180

toc_root = prob["data:geometry:wing:root:thickness_ratio"][0]
toc_kink = prob["data:geometry:wing:kink:thickness_ratio"][0]
toc_tip = prob["data:geometry:wing:tip:thickness_ratio"][0]

flap_span_ratio = prob["data:geometry:flap:span_ratio"][0]
flap_chord_ratio = prob["data:geometry:flap:chord_ratio"][0]
slat_span_ratio = prob["data:geometry:slat:span_ratio"][0]
slat_chord_ratio = prob["data:geometry:slat:chord_ratio"][0]

# fuselage_geometry:
fuselage_width = prob["data:geometry:fuselage:maximum_width"][0]
fuselage_length = prob["data:geometry:fuselage:length"][0]
fuselage_height = prob["data:geometry:fuselage:maximum_height"][0]

# htail_geometry:
x_from_wingMAC25 = prob['data:geometry:horizontal_tail:MAC:at25percent:x:from_wingMAC25'][0]
x_MAC25_htail = x_MAC25_wing + x_from_wingMAC25
x_root_LE_htail = x_MAC25_htail - prob['data:geometry:horizontal_tail:MAC:at25percent:x:local'][0]

y_tip_htail = prob["data:geometry:horizontal_tail:span"][0] / 2
c_tip_htail = prob["data:geometry:horizontal_tail:tip:chord"][0]
# c_tip_htail == y_tip_htail * (np.tan(sweep_100_htail) - np.tan(sweep_0_htail )) + c_root_htail
c_root_htail = prob["data:geometry:horizontal_tail:root:chord"][0]
x_root_25_htail = x_root_LE_htail + 0.25*c_root_htail
sweep_0_htail_deg = prob["data:geometry:horizontal_tail:sweep_0"][0]; sweep_0_htail = sweep_0_htail_deg * p180;
sweep_100_htail_deg = prob["data:geometry:horizontal_tail:sweep_100"][0]; sweep_100_htail = sweep_100_htail_deg * p180
sweep_25_htail_deg = prob["data:geometry:horizontal_tail:sweep_25"][0]

# others:
gear_height = prob["data:geometry:landing_gear:height"][0]
y_engine = prob["data:geometry:propulsion:nacelle:y"][0]
fuselage_length = prob["data:geometry:fuselage:length"][0]

fuselage_front_length = prob["data:geometry:fuselage:front_length"][0]
fuselage_rear_length = prob["data:geometry:fuselage:rear_length"][0]
fuselage_middle_length = fuselage_length - (fuselage_front_length + fuselage_rear_length)
cabin_middle_x = fuselage_front_length + 0.5*fuselage_middle_length

########################flight_condition##########################
cruise_mach = prob["data:TLAR:cruise_mach"][0]
Range = prob["data:TLAR:range"][0]
cruise_altitude = prob["data:mission:sizing:main_route:cruise:altitude"][0]
cruise_Re = prob["data:aerodynamics:wing:cruise:reynolds"][0]

########################structure##########################
spar_ratio_f_root = prob["data:geometry:wing:spar_ratio:front:root"][0]
spar_ratio_r_root = prob["data:geometry:wing:spar_ratio:rear:root"][0]
spar_ratio_f_kink = prob["data:geometry:wing:spar_ratio:front:kink"][0]
spar_ratio_r_kink = prob["data:geometry:wing:spar_ratio:rear:kink"][0]
spar_ratio_f_tip = prob["data:geometry:wing:spar_ratio:front:tip"][0]
spar_ratio_r_tip = prob["data:geometry:wing:spar_ratio:rear:tip"][0]

########################weight##########################
# airframes:
mass_wing = prob["data:weight:airframe:wing:mass"][0]
mass_flight_controls = prob["data:weight:airframe:flight_controls:mass"][0]
mass_main_gear = prob["data:weight:airframe:landing_gear:main:mass"][0]
mass_front_gear = prob["data:weight:airframe:landing_gear:front:mass"][0]

mass_wing_cg = prob["data:weight:airframe:wing:CG:x"][0]
mass_flight_controls_cg = prob["data:weight:airframe:flight_controls:CG:x"][0]
mass_main_gear_cg = prob["data:weight:airframe:landing_gear:main:CG:x"][0]
mass_front_gear_cg = prob["data:weight:airframe:landing_gear:front:CG:x"][0]
###above removed

# mass_related_to_fuselage:
fuselage_mass_names = [
    "data:weight:airframe:fuselage:mass",
    "data:weight:airframe:landing_gear:front:mass",
    "data:weight:airframe:horizontal_tail:mass",
    "data:weight:airframe:vertical_tail:mass",
    "data:weight:airframe:paint:mass",
    "data:weight:systems:power:auxiliary_power_unit:mass",
    "data:weight:systems:power:electric_systems:mass",
    "data:weight:systems:power:hydraulic_systems:mass",
    "data:weight:systems:life_support:insulation:mass",
    "data:weight:systems:life_support:air_conditioning:mass",
    "data:weight:systems:life_support:de-icing:mass",
    "data:weight:systems:life_support:cabin_lighting:mass",
    "data:weight:systems:life_support:seats_crew_accommodation:mass",
    "data:weight:systems:life_support:oxygen:mass",
    "data:weight:systems:life_support:safety_equipment:mass",
    "data:weight:systems:navigation:mass",
    "data:weight:systems:transmission:mass",
    "data:weight:systems:operational:radar:mass",
    "data:weight:systems:operational:cargo_hold:mass",
    "data:weight:systems:flight_kit:mass",
    "data:weight:furniture:passenger_seats:mass",
    "data:weight:furniture:food_water:mass",
    "data:weight:furniture:security_kit:mass",
    "data:weight:furniture:toilets:mass",
]
fuselage_cg_names = [
    "data:weight:airframe:fuselage:CG:x",
    "data:weight:airframe:landing_gear:front:CG:x",
    "data:weight:airframe:horizontal_tail:CG:x",
    "data:weight:airframe:vertical_tail:CG:x",
    "data:weight:airframe:paint:CG:x",
    "data:weight:systems:power:auxiliary_power_unit:CG:x",
    "data:weight:systems:power:electric_systems:CG:x",
    "data:weight:systems:power:hydraulic_systems:CG:x",
    "data:weight:systems:life_support:insulation:CG:x",
    "data:weight:systems:life_support:air_conditioning:CG:x",
    "data:weight:systems:life_support:de-icing:CG:x",
    "data:weight:systems:life_support:cabin_lighting:CG:x",
    "data:weight:systems:life_support:seats_crew_accommodation:CG:x",
    "data:weight:systems:life_support:oxygen:CG:x",
    "data:weight:systems:life_support:safety_equipment:CG:x",
    "data:weight:systems:navigation:CG:x",
    "data:weight:systems:transmission:CG:x",
    "data:weight:systems:operational:radar:CG:x",
    "data:weight:systems:operational:cargo_hold:CG:x",
    "data:weight:systems:flight_kit:CG:x",
    "data:weight:furniture:passenger_seats:CG:x",
    "data:weight:furniture:food_water:CG:x",
    "data:weight:furniture:security_kit:CG:x",
    "data:weight:furniture:toilets:CG:x",
]
masses_fuselage = [prob[mass_name][0] for mass_name in fuselage_mass_names]
cgs_fuselage = [prob[cg_name][0] for cg_name in fuselage_cg_names]
mass_fuselage_group = np.sum(masses_fuselage)
cg_fuselage_group = np.dot(masses_fuselage, cgs_fuselage) / mass_fuselage_group
mass_fuselage_group += prob["data:weight:crew:mass"][0]

# mass_related_to_engine:
engine_mass_names = [
    "data:weight:airframe:pylon:mass",
    "data:weight:propulsion:engine:mass",
    "data:weight:propulsion:fuel_lines:mass",
    "data:weight:propulsion:unconsumables:mass",
]
engine_cg_names = [
    "data:weight:airframe:pylon:CG:x",
    "data:weight:propulsion:engine:CG:x",
    "data:weight:propulsion:fuel_lines:CG:x",
    "data:weight:propulsion:unconsumables:CG:x",
]
masses_engine = [prob[mass_name][0] for mass_name in engine_mass_names]
cgs_engine = [prob[cg_name][0] for cg_name in engine_cg_names]
mass_engines_group = np.sum(masses_engine)
cg_engines_group = np.dot(masses_engine, cgs_engine) / mass_engines_group

OEW = \
    mass_wing + mass_flight_controls + mass_main_gear + \
    mass_fuselage_group + mass_engines_group
# OEW = prob["data:weight:aircraft:OWE"][0]

payload = prob["data:weight:aircraft:payload"][0]
max_payload = prob["data:weight:aircraft:max_payload"][0]

MTO_thrust = prob["data:propulsion:MTO_thrust"][0]
MTOW = prob["data:weight:aircraft:MTOW"][0]
OEW = prob["data:weight:aircraft:OWE"][0]
ZFW = prob["data:mission:sizing:ZFW"][0]

################################fuel_weight#######################################
# ::sizing_breguet
main_route_fuel = prob["data:mission:sizing:main_route:fuel"][0]
# main_route_fuel = climb_fuel + cruise_fuel + descent_fuel
# climb_fuel = prob["data:mission:sizing:main_route:climb:fuel"][0]
# cruise_fuel = prob["data:mission:sizing:main_route:cruise:fuel"][0]
# descent_fuel = prob["data:mission:sizing:main_route:descent:fuel"][0]
reserve_fuel = prob["data:mission:sizing:global_reserve:fuel"][0]

takeoff_onboard_fuel = main_route_fuel + reserve_fuel
# takeoff_onboard_fuel = prob["data:weight:aircraft:sizing_onboard_fuel_at_takeoff"][0]

taxi_out_fuel = prob["data:mission:sizing:taxi_out:fuel"][0]
takeoff_fuel = prob["data:mission:sizing:takeoff:fuel"][0]

sizing_block_fuel = takeoff_onboard_fuel + taxi_out_fuel + takeoff_fuel
# sizing_block_fuel = prob["data:weight:aircraft:sizing_block_fuel"][0]
#######################################################################
# ::sizing_mission
# initial_climb_fuel = prob["data:mission:sizing:main_route:initial_climb:fuel"][0]
# climb_fuel = prob["data:mission:sizing:main_route:climb:fuel"][0]
# cruise_fuel = prob["data:mission:sizing:main_route:cruise:fuel"][0]
# decent_fuel = prob["data:mission:sizing:main_route:descent:fuel"][0]
# reserve_fuel = prob["data:mission:sizing:global_reserve:fuel"][0]
# diversion_fuel = prob["data:mission:sizing:diversion:fuel"][0]
# # diversion_climb_fuel = prob["data:mission:sizing:diversion:diversion_climb:fuel"][0]
# # diversion_cruise_fuel = prob["data:mission:sizing:diversion:cruise:fuel"][0]
# # diversion_descent_fuel = prob["data:mission:sizing:diversion:descent:fuel"][0]
# taxi_in_fuel = prob["data:mission:sizing:taxi_in:fuel"][0]
# taxi_out_fuel = prob["data:mission:sizing:taxi_out:fuel"][0]
# holding_fuel = prob["data:mission:sizing:holding:fuel"][0]
# sizing_fuel = prob["data:mission:sizing:fuel"][0]
# sizing_block_fuel = prob["data:weight:aircraft:sizing_block_fuel"][0]
# onboard_fuel = prob["	data:weight:aircraft:sizing_onboard_fuel_at_takeoff"][0]


########################aerodynamic##########################
#airframes:
CL_table = prob["data:aerodynamics:aircraft:cruise:CL"]
CD0_fuselage_table = prob["data:aerodynamics:fuselage:cruise:CD0"]
CD0_wing_table = prob["data:aerodynamics:wing:cruise:CD0"]
CL_optimal = prob["data:aerodynamics:aircraft:cruise:optimal_CL"][0]

CD0_wing = np.interp(CL_optimal, CL_table, CD0_wing_table)
CD0_fuselage = np.interp(CL_optimal, CL_table, CD0_fuselage_table)
CD0_htail = prob["data:aerodynamics:horizontal_tail:cruise:CD0"][0]
CD0_vtail = prob["data:aerodynamics:vertical_tail:cruise:CD0"][0]
CD0_pylons = prob["data:aerodynamics:pylons:cruise:CD0"][0]
CD0_nacelles = prob["data:aerodynamics:nacelles:cruise:CD0"][0]

wet_area_total = prob["data:geometry:aircraft:wetted_area"][0]
k_parasite = (-2.39 * pow(10, -12) * wet_area_total ** 3
            + 2.58 * pow(10, -8) * wet_area_total ** 2
            - 0.89 * pow(10, -4) * wet_area_total
            + 0.163)
CD0_total = CD0_fuselage + CD0_htail + CD0_vtail + CD0_pylons + CD0_nacelles# + CD0_wing
CD0_total *= (1.0 + k_parasite)
# CD0_total_table = prob["data:aerodynamics:aircraft:cruise:CD0"]
# np.interp(CL_optimal, CL_table, CD0_total_table)

##################################################
# write_dictionary
# write_dict(file_name, '', )
dir_name = 'output_data_from_fastoad'
mkdir(dir_name)

file_name = dir_name+ '\\output_from_fastoad.txt'
if os.path.exists(file_name):
    os.remove(file_name)
    
##################################################
# geometry
write_dict(file_name, 'wing_MAC', wing_MAC)
write_dict(file_name, 'kink_span_ratio', kink_span_ratio)
write_dict(file_name, 'x_MAC25_wing', x_MAC25_wing)

write_dict(file_name, 'half_span', half_span)
write_dict(file_name, 'y_kink', y_kink)
write_dict(file_name, 'c_kink', c_kink)
write_dict(file_name, 'x_kink_LE', x_kink_LE)
write_dict(file_name, 'x_kink_TE', x_kink_TE)

write_dict(file_name, 'y_tip', y_tip)
write_dict(file_name, 'c_tip', c_tip)
write_dict(file_name, 'x_tip_LE', x_tip_LE)
write_dict(file_name, 'x_tip_TE', x_tip_TE)

write_dict(file_name, 'x_root_LE', x_root_LE)
write_dict(file_name, 'x_root_TE', x_root_TE)
write_dict(file_name, 'c_root', c_root)

write_dict(file_name, 'sweep_0', sweep_0)
write_dict(file_name, 'sweep_100_inner', sweep_100_inner)
write_dict(file_name, 'sweep_100_outer', sweep_100_outer)
write_dict(file_name, 'sweep_25_inner_deg', sweep_25_inner_deg)
write_dict(file_name, 'sweep_25_outer_deg', sweep_25_outer_deg)

write_dict(file_name, 'toc_root', toc_root)
write_dict(file_name, 'toc_kink', toc_kink)
write_dict(file_name, 'toc_tip', toc_tip)

write_dict(file_name, 'flap_span_ratio', flap_span_ratio)
write_dict(file_name, 'flap_chord_ratio', flap_chord_ratio)
write_dict(file_name, 'slat_span_ratio', slat_span_ratio)
write_dict(file_name, 'slat_chord_ratio', slat_chord_ratio)

write_dict(file_name, 'fuselage_width', fuselage_width)
write_dict(file_name, 'fuselage_length', fuselage_length)
write_dict(file_name, 'fuselage_height', fuselage_height)

write_dict(file_name, 'y_tip_htail', y_tip_htail)
write_dict(file_name, 'c_tip_htail', c_tip_htail)
write_dict(file_name, 'c_root_htail', c_root_htail)
write_dict(file_name, 'sweep_0_htail', sweep_0_htail)
write_dict(file_name, 'sweep_100_htail', sweep_100_htail)
write_dict(file_name, 'x_root_LE_htail', x_root_LE_htail)
write_dict(file_name, 'x_root_25_htail', x_root_25_htail)
write_dict(file_name, 'x_MAC25_htail', x_MAC25_htail)
write_dict(file_name, 'sweep_25_htail_deg', sweep_25_htail_deg)

write_dict(file_name, 'gear_height', gear_height)
write_dict(file_name, 'y_engine', y_engine)
write_dict(file_name, 'fuselage_length', fuselage_length)
write_dict(file_name, 'cabin_middle_x', cabin_middle_x)

##################################################
# structure
write_dict(file_name, 'spar_ratio_f_root', spar_ratio_f_root)
write_dict(file_name, 'spar_ratio_r_root', spar_ratio_r_root)
write_dict(file_name, 'spar_ratio_f_kink', spar_ratio_f_kink)
write_dict(file_name, 'spar_ratio_r_kink', spar_ratio_r_kink)
write_dict(file_name, 'spar_ratio_f_tip', spar_ratio_f_tip)
write_dict(file_name, 'spar_ratio_r_tip', spar_ratio_r_tip)

##################################################
# TLAR
write_dict(file_name, 'cruise_mach', cruise_mach)
write_dict(file_name, 'Range', Range)
write_dict(file_name, 'cruise_altitude', cruise_altitude)
write_dict(file_name, 'cruise_Re', cruise_Re)

##################################################
# weight
write_dict(file_name, 'mass_fuselage_group', mass_fuselage_group)
write_dict(file_name, 'cg_fuselage_group', cg_fuselage_group)

write_dict(file_name, 'mass_engines_group', mass_engines_group)
write_dict(file_name, 'cg_engines_group', cg_engines_group)

write_dict(file_name, 'mass_front_gear', mass_front_gear)
write_dict(file_name, 'mass_front_gear_cg', mass_front_gear_cg)
write_dict(file_name, 'mass_main_gear', mass_main_gear)

write_dict(file_name, 'payload', payload)
write_dict(file_name, 'max_payload', max_payload)

write_dict(file_name, 'MTO_thrust', MTO_thrust)
write_dict(file_name, 'MTOW', MTOW)
write_dict(file_name, 'OEW', OEW)
write_dict(file_name, 'ZFW', ZFW)

write_dict(file_name, 'main_route_fuel', main_route_fuel)
write_dict(file_name, 'reserve_fuel', reserve_fuel)
write_dict(file_name, 'taxi_out_fuel', taxi_out_fuel)
write_dict(file_name, 'takeoff_fuel', takeoff_fuel)
write_dict(file_name, 'sizing_block_fuel', sizing_block_fuel)

##################################################
# drag
write_dict(file_name, 'CD0_total', CD0_total)

