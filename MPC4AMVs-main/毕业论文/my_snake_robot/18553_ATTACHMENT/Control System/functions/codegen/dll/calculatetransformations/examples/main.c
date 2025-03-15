/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * main.c
 *
 * Code generation for function 'main'
 *
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
/* Include files */
#include "rt_nonfinite.h"
#include "calculateTransformations.h"
#include "main.h"
#include "calculateTransformations_terminate.h"
#include "calculateTransformations_initialize.h"

/* Function Declarations */
static void argInit_4x4_real_T(double result[16]);
static void argInit_5x1_real_T(double result[5]);
static void argInit_6x1_real_T(double result[6]);
static double argInit_real_T(void);
static void main_calculateTransformations(void);

/* Function Definitions */
static void argInit_4x4_real_T(double result[16])
{
  int idx0;
  int idx1;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 4; idx0++) {
    for (idx1 = 0; idx1 < 4; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result[idx0 + (idx1 << 2)] = argInit_real_T();
    }
  }
}

static void argInit_5x1_real_T(double result[5])
{
  int idx0;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 5; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

static void argInit_6x1_real_T(double result[6])
{
  int idx0;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 6; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

static double argInit_real_T(void)
{
  return 0.0;
}

static void main_calculateTransformations(void)
{
  double dv0[5];
  double dv1[5];
  double dv2[6];
  double dv3[16];
  double g_thrusters[112];
  double g_moduleCM[144];
  double g_joints_home[144];
  double q[8];
  double eta_b[6];
  double R_Ib[9];
  double g_Ib[16];
  double eta_f[6];
  double R_If[9];
  double g_If[16];

  /* Initialize function 'calculateTransformations' input arguments. */
  /* Initialize function input argument 'q1'. */
  /* Initialize function input argument 'q2'. */
  /* Initialize function input argument 'eta_marker'. */
  /* Initialize function input argument 'g_marker2front'. */
  /* Call the entry-point 'calculateTransformations'. */
  argInit_5x1_real_T(dv0);
  argInit_5x1_real_T(dv1);
  argInit_6x1_real_T(dv2);
  argInit_4x4_real_T(dv3);
  calculateTransformations(dv0, dv1, dv2, dv3, argInit_real_T(), g_If, R_If,
    eta_f, g_Ib, R_Ib, eta_b, q, g_joints_home, g_moduleCM, g_thrusters);
}

int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* Initialize the application.
     You do not need to do this more than one time. */
  calculateTransformations_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_calculateTransformations();

  /* Terminate the application.
     You do not need to do this more than one time. */
  calculateTransformations_terminate();
  return 0;
}

/* End of code generation (main.c) */
