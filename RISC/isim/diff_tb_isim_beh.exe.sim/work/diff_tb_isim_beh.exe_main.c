/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_01866880316019841167_1609004488_init();
    work_m_03196494373772107699_2965118897_init();
    work_m_07466776806077655429_2220136494_init();
    work_m_15460569669297279918_1887464097_init();
    work_m_14545083592777047522_1338720736_init();
    work_m_06475355751020445768_3948285920_init();
    work_m_06977998105512429373_0311818195_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_06977998105512429373_0311818195");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
