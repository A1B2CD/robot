/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * rot2euler.c
 *
 * Code generation for function 'rot2euler'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calculateTransformations.h"
#include "rot2euler.h"
#include "error.h"

/* Variable Definitions */
static emlrtRSInfo f_emlrtRSI = { 5, "rot2euler",
  "C:\\Users\\jorgesv\\Dropbox\\PhD documents\\Matlab code\\underwater swimming manipulators\\Utilities\\rot2euler.m"
};

static emlrtRSInfo g_emlrtRSI = { 13, "asin",
  "C:\\Program Files (x86)\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elfun\\asin.m"
};

/* Function Definitions */
void rot2euler(const emlrtStack *sp, const real_T R[9], real_T eulerangles[3])
{
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &f_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  if ((R[2] < -1.0) || (R[2] > 1.0)) {
    b_st.site = &g_emlrtRSI;
    error(&b_st);
  }

  eulerangles[0] = muDoubleScalarAtan2(R[5], R[8]);
  eulerangles[1] = -muDoubleScalarAsin(R[2]);
  eulerangles[2] = muDoubleScalarAtan2(R[1], R[0]);
}

/* End of code generation (rot2euler.c) */
