/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * calculateTransformations_terminate.c
 *
 * Code generation for function 'calculateTransformations_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calculateTransformations.h"
#include "calculateTransformations_terminate.h"
#include "_coder_calculateTransformations_mex.h"
#include "calculateTransformations_data.h"

/* Function Definitions */
void calculateTransformations_atexit(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void calculateTransformations_terminate(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (calculateTransformations_terminate.c) */
