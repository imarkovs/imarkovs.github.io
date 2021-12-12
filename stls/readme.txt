1. Contents of the archive stls.tar.gz

readme.txt	- this file
stls.m		- Matlab function for STLS estimation
demo.m		- Matlab demo file for STLS estimation
tls.m		- Matlab function for TLS estimation  (needed for demo.m)
gtls.m		- Matlab function for GTLS estimation (needed for demo.m)

mb02gd_.c	- mex file for calling MB02GD followed by DPBTRS
mb02gd.c	- mex file for calling MB02GD followed by DTBTRS
mb02md.c	- mex file for calling MB02MD

mb02gd_.dll	- Windows executable for mb02gd_.c
mb02gd.dll	- Windows executable for mb02gd.c
mb02md.dll	- Windows executable for mb02md.c
mb02gd_.mexglx	- Linux executable for mb02gd_.c 
mb02gd.mexglx	- Linux executable for mb02gd.c
mb02md.mexglx	- Linux executable for mb02md.c
mb02gd_.mexsol	- Solaris executable for mb02gd_.c
mb02gd.mexsol	- Solaris executable for mb02gd.c 
mb02md.mexsol	- Solaris executable for mb02md.c

MB02CU.f	- Fortran subroutine from the SLICOT library
MB02CV.f	- Fortran subroutine from the SLICOT library
MB02GD.f	- Fortran subroutine from the SLICOT library
MB02MD.f	- Fortran subroutine from the SLICOT library


2. Description of stls.m

STLS - Structured Total Least Squares estimation

Solves the structured system of equations A*X = B, with both A and B noisy.
The augmented data matrix C = [A B] is of the form C = [C1 ... Cq], where 
the blocks Ci are (block) Toeplitz or Hankel structured, unstructured, or 
constant. C depends affinely on a vector of parameters P, i.e., C = C(P). 
The STLS problem is:

  min_{Xh,Ph} (P-Ph)' * blkdiag(VP,...,VP) * (P-Ph) s.t. C(Ph) [ Xh ] = 0
                                                               [ -I ]

[ xh, ic, ch, ph ] = stls( a, b, struct, x0, method, tol, info, vp )

Input arguments:

A, B      - noisy data
STRUCT    - structure specification, a matrix with q rows and 4 columns
  STRUCT(i,1)   - structure type [ 1 | 2 | 3 | 4 ] of the i-th block
    1 - (block) Toeplitz, 2 - (block) Hankel, 3 - Unstructured, 4 - Noise free
  STRUCT(i,2)   - number of columns of the i-th block
  STRUCT(i,3:4) - dimension of the repeated blocks (for block Toeplitz/Hankel)  
X0        - initial approximation (default TLS)
METHOD    - solution method [ MVK | QN | LM | NM ] (default LM)
  MVK - new iterative method, QN - fminunc, LM - lsqnonlin, NM - fminsearch
TOL       - convergence tolerance (default 1e-5)
            exit condition: ||X(k+1)-X(k)||_F / ||X(0)||_F < TOL
INFO      - level of display [ off | iter | notify | final ] (default off)
VP        - noise covariance matrix (default I)

Output arguments:

XH        - STLS estimate
IC        - number of iterations for convergence, or -1 if not converged
CH        - corrected matrix C(Ph) (Ch = [Ah Bh] - structured, and Ah*Xh = Bh)
PH        - estimated parameter vector Ph 

Note: The program can not treat the case length(P) < size(A,1) * size(B,2).

See also the supplied demo file demo.m

Reference: I. Markovsky, S. Van Huffel, and A. Kukush, "On the computation of the 
structured total least squares estimator", Report #02--203, Dept. EE, K.U. Leuven.
URL: ftp://ftp.esat.kuleuven.ac.be/pub/SISTA/markovsky/abstracts/02-203.html

