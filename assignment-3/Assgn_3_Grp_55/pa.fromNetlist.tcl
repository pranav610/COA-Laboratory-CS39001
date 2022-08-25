
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name Assgn_3_Grp_55 -dir "/home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/planAhead_run_1" -part xc7a100tcsg324-1
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/full_adder_64_bit.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "full_adder_64_bit.ucf" [current_fileset -constrset]
add_files [list {full_adder_64_bit.ucf}] -fileset [get_property constrset [current_run]]
link_design
