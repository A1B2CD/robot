/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_calculateTransformations_mex.c
 *
 * Code generation for function '_coder_calculateTransformations_mex'
 *
 */

/* Include files */
#include "_coder_calculateTransformations_api.h"
#include "_coder_calculateTransformations_mex.h"

/* Function Declarations */
static void c_calculateTransformations_mexF(int32_T nlhs, mxArray *plhs[10],
  int32_T nrhs, const mxArray *prhs[5]);

/* Function Definitions */
static void c_calculateTransformations_mexF(int32_T nlhs, mxArray *plhs[10],
  int32_T nrhs, const mxArray *prhs[5])
{
  int32_T n;
  const mxArray *inputs[5];
  const mxArray *outputs[10];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 5) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 5, 4,
                        24, "calculateTransformations");
  }

  if (nlhs > 10) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 24,
                        "calculateTransformations");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
  }

  /* Call the function. */
  calculateTransformations_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  calculateTransformations_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(calculateTransformations_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  calculateTransformations_initialize();

  /* Dispatch the entry-point. */
  c_calculateTransformations_mexF(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_calculateTransformations_mex.c) */
