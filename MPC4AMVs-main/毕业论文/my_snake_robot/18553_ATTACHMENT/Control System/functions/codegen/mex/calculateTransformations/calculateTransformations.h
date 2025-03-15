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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blas.h"
#include "rtwtypes.h"
#include "calculateTransformations_types.h"

/* Function Declarations */
extern void calculateTransformations(const emlrtStack *sp, const real_T q1[5],
  const real_T q2[5], const real_T eta_marker[6], const real_T g_marker2front[16],
  real_T controlCenterLink, real_T g_If[16], real_T R_If[9], real_T eta_f[6],
  real_T g_Ib[16], real_T R_Ib[9], real_T eta_b[6], real_T q[8], real_T
  g_joints_home[144], real_T g_moduleCM[144], real_T g_thrusters[112]);

#endif

/* End of code generation (calculateTransformations.h) */
