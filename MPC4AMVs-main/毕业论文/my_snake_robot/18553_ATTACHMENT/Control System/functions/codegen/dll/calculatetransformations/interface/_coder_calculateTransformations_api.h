/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_calculateTransformations_api.h
 *
 * Code generation for function '_coder_calculateTransformations_api'
 *
 */

#ifndef ___CODER_CALCULATETRANSFORMATIONS_API_H__
#define ___CODER_CALCULATETRANSFORMATIONS_API_H__

/* Include files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_calculateTransformations_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void calculateTransformations(real_T q1[5], real_T q2[5], real_T
    eta_marker[6], real_T g_marker2front[16], real_T controlCenterLink, real_T
    g_If[16], real_T R_If[9], real_T eta_f[6], real_T g_Ib[16], real_T R_Ib[9],
    real_T eta_b[6], real_T q[8], real_T g_joints_home[144], real_T g_moduleCM
    [144], real_T g_thrusters[112]);
  extern void calculateTransformations_api(const mxArray *prhs[5], const mxArray
    *plhs[10]);
  extern void calculateTransformations_atexit(void);
  extern void calculateTransformations_initialize(void);
  extern void calculateTransformations_terminate(void);
  extern void calculateTransformations_xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (_coder_calculateTransformations_api.h) */
