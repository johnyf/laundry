# to install cvxopt v1.1.7, linking to
# GLPK and ATLAS provided by MacPorts

export CVXOPT_BLAS_LIB="satlas,tatlas"
export CVXOPT_BLAS_LIB_DIR="/opt/local/lib"
export CVXOPT_LAPACK_LIB="lapack"

# to verify that you are using the correct
# "lib" and "include" directories, do:
#
#    ls /your/candidate/dir/ | grep glpk
#
# and you should find "glpk.h" and the
# the glpk libraries (otherwise paths are wrong).
export CVXOPT_BUILD_GLPK=1
export CVXOPT_GLPK_LIB_DIR="/opt/local/lib"
export CVXOPT_GLPK_INC_DIR="/opt/local/include"

pip install cvxopt
