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
    work_m_08585400206169137300_4251583159_init();
    work_m_06551832552653183114_1824703890_init();
    work_m_16034558943338889394_3144601628_init();
    work_m_01562868078816877642_3122724716_init();
    work_m_01562868078816877642_3812195933_init();
    work_m_01562868078816877642_1980419219_init();
    work_m_15543888234401009083_1935920357_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_15543888234401009083_1935920357");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
