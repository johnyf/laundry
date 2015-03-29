# setup isolated virtualenv using MacPorts
# to install cvxopt v1.1.7, linking to
# GLPK and ATLAS provided by MacPorts

envname=tulipdev

if 0; then
mkvirtualenv $envname
pip install networkx
pip install pyparsing
pip install http://pydot.googlecode.com/files/pydot-1.0.28.tar.gz
pip install ply
pip install -q numpy
pip install -q scipy
pip install -q matplotlib

pip install -q ipython
pip install spyder
fi
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
