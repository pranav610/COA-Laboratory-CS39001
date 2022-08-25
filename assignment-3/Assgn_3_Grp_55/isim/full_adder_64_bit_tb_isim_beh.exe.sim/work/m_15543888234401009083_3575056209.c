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

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/pranav/KGP/5th Sem/COA LAB/COA-Laboratory-CS39001/assignment-3/Assgn_3_Grp_55/full_adder_64_bit_tb.v";
static unsigned int ng1[] = {345U, 0U, 0U, 0U};
static unsigned int ng2[] = {473U, 0U, 0U, 0U};



static void Initial_45_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;

LAB0:    t1 = (t0 + 2840U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(45, ng0);

LAB4:    xsi_set_current_line(49, ng0);
    t2 = (t0 + 2648);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(49, ng0);
    t3 = ((char*)((ng1)));
    t4 = (t0 + 1608);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    xsi_set_current_line(49, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 64);
    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2648);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(50, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

}


extern void work_m_15543888234401009083_3575056209_init()
{
	static char *pe[] = {(void *)Initial_45_0};
	xsi_register_didat("work_m_15543888234401009083_3575056209", "isim/full_adder_64_bit_tb_isim_beh.exe.sim/work/m_15543888234401009083_3575056209.didat");
	xsi_register_executes(pe);
}
