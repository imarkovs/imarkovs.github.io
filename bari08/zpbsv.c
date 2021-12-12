/* MEX function for calling the Lapack's function ZPBSV. 

Purpose: to solve a complex positive definite banded system of equations.
Calling sequence: x = zpbsv(F,r), where F is the upper part of the band and r is the right-hand-side. 

Windows sex command:
mex zpbsv.c C:\MATLAB7\extern\examples\refbook\fort.c -IC:\MATLAB7\extern\examples\refbook C:\MATLAB7\extern\lib\win32\lcc\libmwlapack.lib

Unix mex command:
mex zpbsv.c /usr/local/matlab73/extern/examples/refbook/fort.c -I/usr/local/matlab73/extern/examples/refbook -lmwlapack
*/

#include <stdio.h>
#include <string.h>
#include "mex.h"
#include "fort.h"

void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[] )

{
  double *f, *r;
  int    m, s, kd, d, info = 0; 
  char   *chu = "U", msg[50];

  /* Define constants */
  s  = mxGetM( prhs[0] );
  kd = s - 1;
  m  = mxGetM( prhs[1] );
  d  = mxGetN( prhs[1] );

  /* Get input data */
  f  = mat2fort( prhs[0], s, m );
  r  = mat2fort( prhs[1], m, d );
  
  /* Pass all arguments to Fortran by reference */
  zpbsv_( chu, &m, &kd, &d, f, &s, r, &m, &info ); /* suffix _ in Linux */
  
  if (info != 0) {
     sprintf(msg, "ZPBSV failed with an error: info = %d.\n", info);
     mexErrMsgTxt(msg);
  }
  plhs[0] = fort2mat(r, m, m, d);

  /* Free memory */
  mxFree(r);
  mxFree(f);
}
