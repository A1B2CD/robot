/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * rot2euler.h
 *
 * Code generation for function 'rot2euler'
 *
 */

#ifndef __ROT2EULER_H__
#define __ROT2EULER_H__

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
extern void rot2euler(const emlrtStack *sp, const real_T R[9], real_T
                      eulerangles[3]);

#endif

/* End of code generation (rot2euler.h) */
