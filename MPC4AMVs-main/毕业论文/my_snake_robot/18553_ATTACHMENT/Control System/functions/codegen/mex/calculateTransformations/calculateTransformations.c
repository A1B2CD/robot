/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * calculateTransformations.c
 *
 * Code generation for function 'calculateTransformations'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calculateTransformations.h"
#include "rot2euler.h"
#include "calculateTransformations_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 29, "calculateTransformations",
  "C:\\Users\\jorgesv\\Dropbox\\PhD documents\\Matlab code\\underwater swimming manipulators\\Utilities\\calculateTransformations.m"
};

static emlrtRSInfo b_emlrtRSI = { 42, "calculateTransformations",
  "C:\\Users\\jorgesv\\Dropbox\\PhD documents\\Matlab code\\underwater swimming manipulators\\Utilities\\calculateTransformations.m"
};

static emlrtRSInfo c_emlrtRSI = { 45, "calculateTransformations",
  "C:\\Users\\jorgesv\\Dropbox\\PhD documents\\Matlab code\\underwater swimming manipulators\\Utilities\\calculateTransformations.m"
};

static emlrtRSInfo d_emlrtRSI = { 48, "calculateTransformations",
  "C:\\Users\\jorgesv\\Dropbox\\PhD documents\\Matlab code\\underwater swimming manipulators\\Utilities\\calculateTransformations.m"
};

static emlrtRSInfo e_emlrtRSI = { 74, "calculateTransformations",
  "C:\\Users\\jorgesv\\Dropbox\\PhD documents\\Matlab code\\underwater swimming manipulators\\Utilities\\calculateTransformations.m"
};

static emlrtBCInfo emlrtBCI = { 1, 8, 16, 42, "g_joints",
  "calculateModuleTransformations",
  "C:\\Users\\jorgesv\\Dropbox\\PhD documents\\Matlab code\\underwater swimming manipulators\\Utilities\\calculateModuleTransformations.m",
  0 };

static emlrtBCInfo b_emlrtBCI = { 1, 8, 30, 45, "g_joints",
  "calculateJointTransformations",
  "C:\\Users\\jorgesv\\Dropbox\\PhD documents\\Matlab code\\underwater swimming manipulators\\Utilities\\calculateJointTransformations.m",
  0 };

static emlrtBCInfo c_emlrtBCI = { 1, 8, 29, 40, "g_joints",
  "calculateJointTransformations",
  "C:\\Users\\jorgesv\\Dropbox\\PhD documents\\Matlab code\\underwater swimming manipulators\\Utilities\\calculateJointTransformations.m",
  0 };

/* Function Definitions */
void calculateTransformations(const emlrtStack *sp, const real_T q1[5], const
  real_T q2[5], const real_T eta_marker[6], const real_T g_marker2front[16],
  real_T controlCenterLink, real_T g_If[16], real_T R_If[9], real_T eta_f[6],
  real_T g_Ib[16], real_T R_Ib[9], real_T eta_b[6], real_T q[8], real_T
  g_joints_home[144], real_T g_moduleCM[144], real_T g_thrusters[112])
{
  real_T cphi;
  real_T sphi;
  real_T cth;
  real_T sth;
  real_T cpsi;
  real_T spsi;
  real_T b_cpsi[16];
  int32_T k;
  static const int8_T iv0[4] = { 0, 0, 0, 1 };

  int32_T i0;
  int32_T i1;
  real_T b_g_If[9];
  real_T b_g_joints_home[3];
  real_T g_joints[128];
  int32_T i;
  boolean_T b_bool;
  static const char_T joint_ax[8] = { 'Z', 'Y', 'Z', 'Y', 'Z', 'Y', 'Z', 'Y' };

  real_T cos_angle;
  real_T sin_angle;
  real_T g_front2back[16];
  static const int8_T iv1[3] = { 0, 1, 0 };

  static const real_T joint_tr[27] = { 0.62, 0.1, 0.59, 0.1, 0.8, 0.1, 0.59, 0.1,
    0.37, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0 };

  int8_T I[9];
  real_T g_center2back[16];
  static const int8_T iv2[3] = { 0, 0, 1 };

  static const real_T g_ne[16] = { 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.37, 0.0, 0.0, 1.0 };

  static const int8_T iv3[9] = { 1, 0, 0, 0, 1, 0, 0, 0, 1 };

  static const real_T module_cm[27] = { 0.31, 0.05, 0.295, 0.05, 0.4, 0.05,
    0.295, 0.05, 0.185, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

  static const char_T thruster_ax[7] = { 'Z', 'Y', 'Z', 'X', 'X', 'Y', 'Z' };

  static const real_T rotZ[9] = { 6.123233995736766E-17, 1.0, 0.0, -1.0,
    6.123233995736766E-17, 0.0, 0.0, 0.0, 1.0 };

  static const real_T thruster_pos[21] = { 0.24, 0.35000000000000003, 0.24, 0.53,
    0.53, 0.24, 0.35000000000000003, 0.0, 0.0, 0.0, 0.15, -0.15, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

  static const real_T rotY[9] = { 6.123233995736766E-17, 0.0, 1.0, 0.0, 1.0, 0.0,
    -1.0, 0.0, 6.123233995736766E-17 };

  static const int8_T iv4[7] = { 3, 3, 5, 5, 5, 7, 7 };

  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;

  /*  [EELY] Specific code for Eely */
  /*  Measured: Position and Euler angles for the markers, eta_marker */
  /*  R = Rzyx(phi,theta,psi) computes the Euler angle */
  /*  rotation matrix R in SO(3) using the zyx convention */
  /*  */
  /*  Author:   Thor I. Fossen */
  /*  Date:     14th June 2001 */
  /*  Revisions:  */
  /*  ________________________________________________________________ */
  /*  */
  /*  MSS GNC is a Matlab toolbox for guidance, navigation and control. */
  /*  The toolbox is part of the Marine Systems Simulator (MSS). */
  /*  */
  /*  Copyright (C) 2008 Thor I. Fossen and Tristan Perez */
  /*   */
  /*  This program is free software: you can redistribute it and/or modify */
  /*  it under the terms of the GNU General Public License as published by */
  /*  the Free Software Foundation, either version 3 of the License, or */
  /*  (at your option) any later version. */
  /*   */
  /*  This program is distributed in the hope that it will be useful, but */
  /*  WITHOUT ANY WARRANTY; without even the implied warranty of */
  /*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  */
  /*  GNU General Public License for more details. */
  /*   */
  /*  You should have received a copy of the GNU General Public License */
  /*  along with this program.  If not, see <http://www.gnu.org/licenses/>. */
  /*   */
  /*  E-mail: contact@marinecontrol.org */
  /*  URL:    <http://www.marinecontrol.org> */
  cphi = muDoubleScalarCos(eta_marker[3]);
  sphi = muDoubleScalarSin(eta_marker[3]);
  cth = muDoubleScalarCos(eta_marker[4]);
  sth = muDoubleScalarSin(eta_marker[4]);
  cpsi = muDoubleScalarCos(eta_marker[5]);
  spsi = muDoubleScalarSin(eta_marker[5]);
  b_cpsi[0] = cpsi * cth;
  b_cpsi[4] = -spsi * cphi + cpsi * sth * sphi;
  b_cpsi[8] = spsi * sphi + cpsi * cphi * sth;
  b_cpsi[1] = spsi * cth;
  b_cpsi[5] = cpsi * cphi + sphi * sth * spsi;
  b_cpsi[9] = -cpsi * sphi + sth * spsi * cphi;
  b_cpsi[2] = -sth;
  b_cpsi[6] = cth * sphi;
  b_cpsi[10] = cth * cphi;
  for (k = 0; k < 3; k++) {
    b_cpsi[12 + k] = eta_marker[k];
  }

  for (k = 0; k < 4; k++) {
    b_cpsi[3 + (k << 2)] = iv0[k];
  }

  for (k = 0; k < 4; k++) {
    for (i0 = 0; i0 < 4; i0++) {
      g_If[k + (i0 << 2)] = 0.0;
      for (i1 = 0; i1 < 4; i1++) {
        g_If[k + (i0 << 2)] += b_cpsi[k + (i1 << 2)] * g_marker2front[i1 + (i0 <<
          2)];
      }
    }
  }

  for (k = 0; k < 3; k++) {
    for (i0 = 0; i0 < 3; i0++) {
      R_If[i0 + 3 * k] = g_If[i0 + (k << 2)];
      b_g_If[i0 + 3 * k] = g_If[i0 + (k << 2)];
    }
  }

  st.site = &emlrtRSI;
  rot2euler(&st, b_g_If, b_g_joints_home);
  for (k = 0; k < 3; k++) {
    eta_f[k] = g_If[12 + k];
    eta_f[k + 3] = b_g_joints_home[k];
  }

  /*  Code to convert the joint angle inputs q1 and q2 from the Eely robot */
  /*  to the definition used in this code by reorganizing the vector elements. */
  q[0] = q2[3] * 3.1415926535897931 / 180.0;
  q[1] = q1[3] * 3.1415926535897931 / 180.0;
  q[2] = q2[2] * 3.1415926535897931 / 180.0;
  q[3] = q1[2] * 3.1415926535897931 / 180.0;
  q[4] = q2[1] * 3.1415926535897931 / 180.0;
  q[5] = q1[1] * 3.1415926535897931 / 180.0;
  q[6] = q2[4] * 3.1415926535897931 / 180.0;
  q[7] = q1[4] * 3.1415926535897931 / 180.0;

  /* % TRANSFORMATIONS */
  /*  Calculate the sequential transformations from base frame to the joint */
  /*  frames */
  st.site = &b_emlrtRSI;

  /*  Calculates the transformation matrices from  */
  /*  the USM base frame, F_b = F_0, to the joint frames F_i (i=1..n) */
  /*  From the tail module and forward */
  /*  JOINT FRAMES */
  memset(&g_joints[0], 0, sizeof(real_T) << 7);
  memset(&g_joints_home[0], 0, 144U * sizeof(real_T));

  /*  size = num_joint+1 to include F_e */
  i = 0;
  while (i < 8) {
    b_bool = false;
    if (joint_ax[i] != 'Y') {
    } else {
      b_bool = true;
    }

    if (b_bool) {
      cos_angle = muDoubleScalarCos(q[i]);
      sin_angle = muDoubleScalarSin(q[i]);
      g_front2back[0] = cos_angle;
      g_front2back[4] = 0.0;
      g_front2back[8] = sin_angle;
      g_front2back[2] = -sin_angle;
      g_front2back[6] = 0.0;
      g_front2back[10] = cos_angle;
      for (k = 0; k < 3; k++) {
        g_front2back[1 + (k << 2)] = iv1[k];
        g_front2back[12 + k] = joint_tr[i + 9 * k];
      }

      for (k = 0; k < 4; k++) {
        g_front2back[3 + (k << 2)] = iv0[k];
      }

      for (k = 0; k < 9; k++) {
        I[k] = 0;
      }

      for (k = 0; k < 3; k++) {
        I[k + 3 * k] = 1;
      }

      for (k = 0; k < 3; k++) {
        for (i0 = 0; i0 < 3; i0++) {
          g_center2back[i0 + (k << 2)] = I[i0 + 3 * k];
        }

        g_center2back[12 + k] = joint_tr[i + 9 * k];
      }

      for (k = 0; k < 4; k++) {
        g_center2back[3 + (k << 2)] = iv0[k];
      }
    } else {
      b_bool = false;
      if (joint_ax[i] != 'Z') {
      } else {
        b_bool = true;
      }

      if (b_bool) {
        cos_angle = muDoubleScalarCos(q[i]);
        sin_angle = muDoubleScalarSin(q[i]);
        g_front2back[0] = cos_angle;
        g_front2back[4] = -sin_angle;
        g_front2back[8] = 0.0;
        g_front2back[1] = sin_angle;
        g_front2back[5] = cos_angle;
        g_front2back[9] = 0.0;
        for (k = 0; k < 3; k++) {
          g_front2back[2 + (k << 2)] = iv2[k];
          g_front2back[12 + k] = joint_tr[i + 9 * k];
        }

        for (k = 0; k < 4; k++) {
          g_front2back[3 + (k << 2)] = iv0[k];
        }

        for (k = 0; k < 9; k++) {
          I[k] = 0;
        }

        for (k = 0; k < 3; k++) {
          I[k + 3 * k] = 1;
        }

        for (k = 0; k < 3; k++) {
          for (i0 = 0; i0 < 3; i0++) {
            g_center2back[i0 + (k << 2)] = I[i0 + 3 * k];
          }

          g_center2back[12 + k] = joint_tr[i + 9 * k];
        }

        for (k = 0; k < 4; k++) {
          g_center2back[3 + (k << 2)] = iv0[k];
        }
      } else {
        memset(&g_front2back[0], 0, sizeof(real_T) << 4);
        for (k = 0; k < 4; k++) {
          g_front2back[k + (k << 2)] = 1.0;
        }

        memset(&g_center2back[0], 0, sizeof(real_T) << 4);
        for (k = 0; k < 4; k++) {
          g_center2back[k + (k << 2)] = 1.0;
        }
      }
    }

    if (1 + i == 1) {
      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          g_joints[(i0 + (k << 2)) + (i << 4)] = g_front2back[i0 + (k << 2)];
          g_joints_home[(i0 + (k << 2)) + (i << 4)] = g_center2back[i0 + (k << 2)];
        }
      }
    } else {
      k = i;
      if (!(k >= 1)) {
        emlrtDynamicBoundsCheckR2012b(0, 1, 8, &c_emlrtBCI, &st);
      }

      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          b_cpsi[k + (i0 << 2)] = 0.0;
          for (i1 = 0; i1 < 4; i1++) {
            b_cpsi[k + (i0 << 2)] += g_joints[(k + (i1 << 2)) + ((i - 1) << 4)] *
              g_front2back[i1 + (i0 << 2)];
          }
        }
      }

      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          g_joints[(i0 + (k << 2)) + (i << 4)] = b_cpsi[i0 + (k << 2)];
        }
      }

      k = i;
      if (!(k >= 1)) {
        emlrtDynamicBoundsCheckR2012b(0, 1, 8, &b_emlrtBCI, &st);
      }

      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          g_joints_home[(k + (i0 << 2)) + (i << 4)] = 0.0;
          for (i1 = 0; i1 < 4; i1++) {
            g_joints_home[(k + (i0 << 2)) + (i << 4)] += g_joints[(k + (i1 << 2))
              + ((i - 1) << 4)] * g_center2back[i1 + (i0 << 2)];
          }
        }
      }
    }

    i++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  for (k = 0; k < 4; k++) {
    for (i0 = 0; i0 < 4; i0++) {
      g_joints_home[128 + (k + (i0 << 2))] = 0.0;
      for (i1 = 0; i1 < 4; i1++) {
        g_joints_home[128 + (k + (i0 << 2))] += g_joints[112 + (k + (i1 << 2))] *
          g_ne[i1 + (i0 << 2)];
      }
    }
  }

  /*  Calculate transformations for the CM of each module */
  st.site = &c_emlrtRSI;

  /*  Calculating the transformations from the USM base frame, F_b = F_0, */
  /*  to the MODULE CENTER OF MASS FRAMES, F_CM_i */
  /*  From the tail module and forward */
  memset(&g_moduleCM[0], 0, 144U * sizeof(real_T));
  i = 0;
  while (i < 9) {
    for (k = 0; k < 3; k++) {
      for (i0 = 0; i0 < 3; i0++) {
        g_front2back[i0 + (k << 2)] = iv3[i0 + 3 * k];
      }

      g_front2back[12 + k] = module_cm[i + 9 * k];
    }

    for (k = 0; k < 4; k++) {
      g_front2back[3 + (k << 2)] = iv0[k];
    }

    if (1 + i == 1) {
      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          g_moduleCM[(i0 + (k << 2)) + (i << 4)] = g_front2back[i0 + (k << 2)];
        }
      }
    } else {
      k = i;
      if (!(k >= 1)) {
        emlrtDynamicBoundsCheckR2012b(0, 1, 8, &emlrtBCI, &st);
      }

      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          g_moduleCM[(k + (i0 << 2)) + (i << 4)] = 0.0;
          for (i1 = 0; i1 < 4; i1++) {
            g_moduleCM[(k + (i0 << 2)) + (i << 4)] += g_joints[(k + (i1 << 2)) +
              ((i - 1) << 4)] * g_front2back[i1 + (i0 << 2)];
          }
        }
      }
    }

    i++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /*  Calculate transformations for the thrusters */
  st.site = &d_emlrtRSI;

  /*  Calculating the transformations from the back frame to the thruster */
  /*  frames */
  /*  From the tail module and forward */
  /*  THRUSTER FRAMES */
  memset(&g_thrusters[0], 0, 112U * sizeof(real_T));
  i = 0;
  while (i < 7) {
    b_bool = false;
    if (thruster_ax[i] != 'Y') {
    } else {
      b_bool = true;
    }

    if (b_bool) {
      k = 0;
    } else {
      b_bool = false;
      if (thruster_ax[i] != 'Z') {
      } else {
        b_bool = true;
      }

      if (b_bool) {
        k = 1;
      } else {
        k = -1;
      }
    }

    switch (k) {
     case 0:
      for (k = 0; k < 3; k++) {
        for (i0 = 0; i0 < 3; i0++) {
          g_front2back[i0 + (k << 2)] = rotZ[i0 + 3 * k];
        }

        g_front2back[12 + k] = thruster_pos[i + 7 * k];
      }

      for (k = 0; k < 4; k++) {
        g_front2back[3 + (k << 2)] = iv0[k];
      }
      break;

     case 1:
      for (k = 0; k < 3; k++) {
        for (i0 = 0; i0 < 3; i0++) {
          g_front2back[i0 + (k << 2)] = rotY[i0 + 3 * k];
        }

        g_front2back[12 + k] = thruster_pos[i + 7 * k];
      }

      for (k = 0; k < 4; k++) {
        g_front2back[3 + (k << 2)] = iv0[k];
      }
      break;

     default:
      memset(&g_front2back[0], 0, sizeof(real_T) << 4);
      for (k = 0; k < 4; k++) {
        g_front2back[k + (k << 2)] = 1.0;
      }
      break;
    }

    for (k = 0; k < 4; k++) {
      for (i0 = 0; i0 < 4; i0++) {
        g_center2back[i0 + (k << 2)] = g_joints[(i0 + (k << 2)) + ((iv4[i] - 2) <<
          4)];
      }
    }

    for (k = 0; k < 4; k++) {
      for (i0 = 0; i0 < 4; i0++) {
        g_thrusters[(k + (i0 << 2)) + (i << 4)] = 0.0;
        for (i1 = 0; i1 < 4; i1++) {
          g_thrusters[(k + (i0 << 2)) + (i << 4)] += g_center2back[k + (i1 << 2)]
            * g_front2back[i1 + (i0 << 2)];
        }
      }
    }

    i++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /*  Calculate the transformation from the front end to the back end */
  for (k = 0; k < 3; k++) {
    for (i0 = 0; i0 < 3; i0++) {
      b_g_If[i0 + 3 * k] = -g_joints_home[128 + (k + (i0 << 2))];
    }
  }

  for (k = 0; k < 3; k++) {
    b_g_joints_home[k] = 0.0;
    for (i0 = 0; i0 < 3; i0++) {
      g_front2back[i0 + (k << 2)] = g_joints_home[128 + (k + (i0 << 2))];
      b_g_joints_home[k] += b_g_If[k + 3 * i0] * g_joints_home[140 + i0];
    }

    g_front2back[12 + k] = b_g_joints_home[k];
  }

  for (k = 0; k < 4; k++) {
    g_front2back[3 + (k << 2)] = iv0[k];
  }

  /*  Transformation from inertial frame to base frame */
  if (controlCenterLink != 0.0) {
    /*  Calculate the transformation from the back end to the center module */
    /*  (module number 5) */
    for (k = 0; k < 3; k++) {
      for (i0 = 0; i0 < 3; i0++) {
        b_g_If[i0 + 3 * k] = -g_moduleCM[64 + (k + (i0 << 2))];
      }
    }

    for (k = 0; k < 3; k++) {
      b_g_joints_home[k] = 0.0;
      for (i0 = 0; i0 < 3; i0++) {
        g_center2back[i0 + (k << 2)] = g_moduleCM[64 + (k + (i0 << 2))];
        b_g_joints_home[k] += b_g_If[k + 3 * i0] * g_moduleCM[76 + i0];
      }

      g_center2back[12 + k] = b_g_joints_home[k];
    }

    for (k = 0; k < 4; k++) {
      g_center2back[3 + (k << 2)] = iv0[k];
      for (i0 = 0; i0 < 4; i0++) {
        b_cpsi[k + (i0 << 2)] = 0.0;
        for (i1 = 0; i1 < 4; i1++) {
          b_cpsi[k + (i0 << 2)] += g_If[k + (i1 << 2)] * g_front2back[i1 + (i0 <<
            2)];
        }
      }

      for (i0 = 0; i0 < 4; i0++) {
        g_Ib[k + (i0 << 2)] = 0.0;
        for (i1 = 0; i1 < 4; i1++) {
          g_Ib[k + (i0 << 2)] += b_cpsi[k + (i1 << 2)] * g_moduleCM[64 + (i1 +
            (i0 << 2))];
        }
      }
    }

    i = 0;
    while (i < 7) {
      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          b_cpsi[k + (i0 << 2)] = 0.0;
          for (i1 = 0; i1 < 4; i1++) {
            b_cpsi[k + (i0 << 2)] += g_center2back[k + (i1 << 2)] * g_thrusters
              [(i1 + (i0 << 2)) + (i << 4)];
          }
        }
      }

      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          g_thrusters[(i0 + (k << 2)) + (i << 4)] = b_cpsi[i0 + (k << 2)];
        }
      }

      i++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    i = 0;
    while (i < 9) {
      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          b_cpsi[k + (i0 << 2)] = 0.0;
          for (i1 = 0; i1 < 4; i1++) {
            b_cpsi[k + (i0 << 2)] += g_center2back[k + (i1 << 2)] * g_moduleCM
              [(i1 + (i0 << 2)) + (i << 4)];
          }
        }
      }

      for (k = 0; k < 4; k++) {
        for (i0 = 0; i0 < 4; i0++) {
          g_moduleCM[(i0 + (k << 2)) + (i << 4)] = b_cpsi[i0 + (k << 2)];
        }
      }

      i++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }
  } else {
    for (k = 0; k < 4; k++) {
      for (i0 = 0; i0 < 4; i0++) {
        g_Ib[k + (i0 << 2)] = 0.0;
        for (i1 = 0; i1 < 4; i1++) {
          g_Ib[k + (i0 << 2)] += g_If[k + (i1 << 2)] * g_front2back[i1 + (i0 <<
            2)];
        }
      }
    }
  }

  for (k = 0; k < 3; k++) {
    for (i0 = 0; i0 < 3; i0++) {
      R_Ib[i0 + 3 * k] = g_Ib[i0 + (k << 2)];
      b_g_If[i0 + 3 * k] = g_Ib[i0 + (k << 2)];
    }
  }

  st.site = &e_emlrtRSI;
  rot2euler(&st, b_g_If, b_g_joints_home);
  for (k = 0; k < 3; k++) {
    eta_b[k] = g_Ib[12 + k];
    eta_b[k + 3] = b_g_joints_home[k];
  }
}

/* End of code generation (calculateTransformations.c) */
