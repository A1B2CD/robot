/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_calculateTransformations_api.c
 *
 * Code generation for function '_coder_calculateTransformations_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calculateTransformations.h"
#include "_coder_calculateTransformations_api.h"
#include "calculateTransformations_data.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[5];
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *eta_marker, const char_T *identifier))[6];
static const mxArray *c_emlrt_marshallOut(const real_T u[16]);
static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[6];
static const mxArray *d_emlrt_marshallOut(const real_T u[9]);
static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *g_marker2front, const char_T *identifier))[16];
static const mxArray *e_emlrt_marshallOut(const real_T u[6]);
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *q1, const
  char_T *identifier))[5];
static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[16];
static const mxArray *f_emlrt_marshallOut(const real_T u[8]);
static real_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *controlCenterLink, const char_T *identifier);
static const mxArray *g_emlrt_marshallOut(const real_T u[144]);
static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static const mxArray *h_emlrt_marshallOut(const real_T u[112]);
static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[5];
static real_T (*j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[6];
static real_T (*k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[16];
static real_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[5]
{
  real_T (*y)[5];
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *eta_marker, const char_T *identifier))[6]
{
  real_T (*y)[6];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(eta_marker), &thisId);
  emlrtDestroyArray(&eta_marker);
  return y;
}

static const mxArray *c_emlrt_marshallOut(const real_T u[16])
{
  const mxArray *y;
  static const int32_T iv5[2] = { 0, 0 };

  const mxArray *m2;
  static const int32_T iv6[2] = { 4, 4 };

  y = NULL;
  m2 = emlrtCreateNumericArray(2, iv5, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m2, (void *)u);
  emlrtSetDimensions((mxArray *)m2, iv6, 2);
  emlrtAssign(&y, m2);
  return y;
}

static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[6]
{
  real_T (*y)[6];
  y = j_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static const mxArray *d_emlrt_marshallOut(const real_T u[9])
{
  const mxArray *y;
  static const int32_T iv7[2] = { 0, 0 };

  const mxArray *m3;
  static const int32_T iv8[2] = { 3, 3 };

  y = NULL;
  m3 = emlrtCreateNumericArray(2, iv7, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m3, (void *)u);
  emlrtSetDimensions((mxArray *)m3, iv8, 2);
  emlrtAssign(&y, m3);
  return y;
}

static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *g_marker2front, const char_T *identifier))[16]
{
  real_T (*y)[16];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(g_marker2front), &thisId);
  emlrtDestroyArray(&g_marker2front);
  return y;
}
  static const mxArray *e_emlrt_marshallOut(const real_T u[6])
{
  const mxArray *y;
  static const int32_T iv9[1] = { 0 };

  const mxArray *m4;
  static const int32_T iv10[1] = { 6 };

  y = NULL;
  m4 = emlrtCreateNumericArray(1, iv9, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m4, (void *)u);
  emlrtSetDimensions((mxArray *)m4, iv10, 1);
  emlrtAssign(&y, m4);
  return y;
}

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *q1, const
  char_T *identifier))[5]
{
  real_T (*y)[5];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(q1), &thisId);
  emlrtDestroyArray(&q1);
  return y;
}
  static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[16]
{
  real_T (*y)[16];
  y = k_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *f_emlrt_marshallOut(const real_T u[8])
{
  const mxArray *y;
  static const int32_T iv11[1] = { 0 };

  const mxArray *m5;
  static const int32_T iv12[1] = { 8 };

  y = NULL;
  m5 = emlrtCreateNumericArray(1, iv11, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m5, (void *)u);
  emlrtSetDimensions((mxArray *)m5, iv12, 1);
  emlrtAssign(&y, m5);
  return y;
}

static real_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *controlCenterLink, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = h_emlrt_marshallIn(sp, emlrtAlias(controlCenterLink), &thisId);
  emlrtDestroyArray(&controlCenterLink);
  return y;
}

static const mxArray *g_emlrt_marshallOut(const real_T u[144])
{
  const mxArray *y;
  static const int32_T iv13[3] = { 0, 0, 0 };

  const mxArray *m6;
  static const int32_T iv14[3] = { 4, 4, 9 };

  y = NULL;
  m6 = emlrtCreateNumericArray(3, iv13, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m6, (void *)u);
  emlrtSetDimensions((mxArray *)m6, iv14, 3);
  emlrtAssign(&y, m6);
  return y;
}

static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = l_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *h_emlrt_marshallOut(const real_T u[112])
{
  const mxArray *y;
  static const int32_T iv15[3] = { 0, 0, 0 };

  const mxArray *m7;
  static const int32_T iv16[3] = { 4, 4, 7 };

  y = NULL;
  m7 = emlrtCreateNumericArray(3, iv15, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m7, (void *)u);
  emlrtSetDimensions((mxArray *)m7, iv16, 3);
  emlrtAssign(&y, m7);
  return y;
}

static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[5]
{
  real_T (*ret)[5];
  static const int32_T dims[1] = { 5 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  ret = (real_T (*)[5])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T (*j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[6]
{
  real_T (*ret)[6];
  static const int32_T dims[1] = { 6 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  ret = (real_T (*)[6])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[16]
{
  real_T (*ret)[16];
  static const int32_T dims[2] = { 4, 4 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[16])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void calculateTransformations_api(const mxArray * const prhs[5], const mxArray
  *plhs[10])
{
  real_T (*g_If)[16];
  real_T (*R_If)[9];
  real_T (*eta_f)[6];
  real_T (*g_Ib)[16];
  real_T (*R_Ib)[9];
  real_T (*eta_b)[6];
  real_T (*q)[8];
  real_T (*g_joints_home)[144];
  real_T (*g_moduleCM)[144];
  real_T (*g_thrusters)[112];
  real_T (*q1)[5];
  real_T (*q2)[5];
  real_T (*eta_marker)[6];
  real_T (*g_marker2front)[16];
  real_T controlCenterLink;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  g_If = (real_T (*)[16])mxMalloc(sizeof(real_T [16]));
  R_If = (real_T (*)[9])mxMalloc(sizeof(real_T [9]));
  eta_f = (real_T (*)[6])mxMalloc(sizeof(real_T [6]));
  g_Ib = (real_T (*)[16])mxMalloc(sizeof(real_T [16]));
  R_Ib = (real_T (*)[9])mxMalloc(sizeof(real_T [9]));
  eta_b = (real_T (*)[6])mxMalloc(sizeof(real_T [6]));
  q = (real_T (*)[8])mxMalloc(sizeof(real_T [8]));
  g_joints_home = (real_T (*)[144])mxMalloc(sizeof(real_T [144]));
  g_moduleCM = (real_T (*)[144])mxMalloc(sizeof(real_T [144]));
  g_thrusters = (real_T (*)[112])mxMalloc(sizeof(real_T [112]));

  /* Marshall function inputs */
  q1 = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "q1");
  q2 = emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "q2");
  eta_marker = c_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "eta_marker");
  g_marker2front = e_emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "g_marker2front");
  controlCenterLink = g_emlrt_marshallIn(&st, emlrtAliasP(prhs[4]),
    "controlCenterLink");

  /* Invoke the target function */
  calculateTransformations(&st, *q1, *q2, *eta_marker, *g_marker2front,
    controlCenterLink, *g_If, *R_If, *eta_f, *g_Ib, *R_Ib, *eta_b, *q,
    *g_joints_home, *g_moduleCM, *g_thrusters);

  /* Marshall function outputs */
  plhs[0] = c_emlrt_marshallOut(*g_If);
  plhs[1] = d_emlrt_marshallOut(*R_If);
  plhs[2] = e_emlrt_marshallOut(*eta_f);
  plhs[3] = c_emlrt_marshallOut(*g_Ib);
  plhs[4] = d_emlrt_marshallOut(*R_Ib);
  plhs[5] = e_emlrt_marshallOut(*eta_b);
  plhs[6] = f_emlrt_marshallOut(*q);
  plhs[7] = g_emlrt_marshallOut(*g_joints_home);
  plhs[8] = g_emlrt_marshallOut(*g_moduleCM);
  plhs[9] = h_emlrt_marshallOut(*g_thrusters);
}

/* End of code generation (_coder_calculateTransformations_api.c) */
