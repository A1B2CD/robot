/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * calculateTransformations_initialize.c
 *
 * Code generation for function 'calculateTransformations_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calculateTransformations.h"
#include "calculateTransformations_initialize.h"
#include "_coder_calculateTransformations_mex.h"
#include "calculateTransformations_data.h"

/* Function Definitions */
void calculateTransformations_initialize(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (calculateTransformations_initialize.c) */
