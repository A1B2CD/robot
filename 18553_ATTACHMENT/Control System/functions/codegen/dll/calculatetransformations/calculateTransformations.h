/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * calculateTransformations.h
 *
 * Code generation for function 'calculateTransformations'
 *
 */

#ifndef __CALCULATETRANSFORMATIONS_H__
#define __CALCULATETRANSFORMATIONS_H__

/* Include files */
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rt_defines.h"
#include "rt_nonfinite.h"
#include "rtwtypes.h"
#include "calculateTransformations_types.h"

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void calculateTransformations(const double q1[5], const double q2[5],
    const double eta_marker[6], const double g_marker2front[16], double
    controlCenterLink, double g_If[16], double R_If[9], double eta_f[6], double
    g_Ib[16], double R_Ib[9], double eta_b[6], double q[8], double
    g_joints_home[144], double g_moduleCM[144], double g_thrusters[112]);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (calculateTransformations.h) */
