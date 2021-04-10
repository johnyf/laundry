# Fetch, compile, and install `python` and `pip`.
#
# Assumes no `python` appears in `$PATH`
# earlier than `PYTHON_PATH`.
#
# macOS:
#   - modify path to have native `gcc` first.
#   - either:
#     - install OpenSSL using MacPorts, or
#     - install OpenSSL from source:
#       - git clone https://github.com/openssl/openssl
#       - install OpenSSL to default location (`/usr/local/`)
set -e
# define yourself
CFG_FILE=$HOME/.bashrc
PYTHON_PATH=$HOME/python37
PYTHON_VERSION=3.7.2
# auto
PYTHON_BIN=$PYTHON_PATH/bin
PYTHON_LIB=$PYTHON_PATH/lib
echo "will install python $PYTHON_VERSION at: $PYTHON_PATH"
# path
sed -i .bak '/# If not running interactively,/i \
    export PATH='"$PYTHON_BIN"':$PATH \
    export LD_LIBRARY_PATH='"$PYTHON_LIB" $CFG_FILE
source $CFG_FILE
# fetch
curl -LO https://www.python.org/ftp/python\
/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
mkdir -p tmp
tar xzf Python-*.tgz --directory tmp
cd tmp/Python-*/
# compile
make distclean
./configure --prefix=$PYTHON_PATH --enable-shared
make -j4
make test -j4
make install

ln -s $PYTHON_BIN/python3 $PYTHON_BIN/python
hash python
if [ $(command -v python) != "$PYTHON_BIN/python" ]; then
    echo "python not found where just installed,\
        have you updated your PATH ?"
    exit 1
fi
echo "done installing python"

# fetch and install `pip`
# unnecessary with latest python, which contains `pip`
# curl -LO https://bootstrap.pypa.io/get-pip.py
# python get-pip.py

ln -s $PYTHON_BIN/pip3 $PYTHON_BIN/pip
hash pip
if [ $(command -v pip) != "$PYTHON_BIN/pip" ]; then
    echo "pip not found where just installed"
    exit 1
fi

# install packages
cd ../
pip install -r global_requirements.txt
