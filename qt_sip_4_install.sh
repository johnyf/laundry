# ATTENTION: mkvirtualenv --always-copy
# to avoid symlinked include/python2.7 that requires sudo
venvname=dev

set -e
which bison
which flex
pip install mercurial
mkdir -p temp
cd temp

# =================
# install SIP4
# =================
#    http://www.riverbankcomputing.com/software/sip/download
if [ -d "sip" ]; then
    echo "sip already cloned."
    cd sip
    hg pull
else
    hg clone http://www.riverbankcomputing.com/hg/sip
    cd sip
fi
# installation instructions here:
#    http://pyqt.sourceforge.net/Docs/sip4/installation.html
python build.py prepare
python configure.py \
    --incdir $HOME/.virtualenvs/$venvname/include/python2.7/
time make
make install
cd ../

# ================
# install PyQt5
# ================

# download link found here:
#    http://www.riverbankcomputing.com/software/pyqt/download
VERSION=5.5.1
if [ -d "PyQt-gpl-$VERSION" ]; then
	echo "PyQt already downloaded."
else
	curl -LO http://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-$VERSION/PyQt-gpl-$VERSION.tar.gz
	tar vzxf PyQt-gpl-$VERSION.tar.gz
fi
# http://pyqt.sourceforge.net/Docs/PyQt5/installation.html
# `qmake` symlinked to MacPorts `qt5` at `/opt/local/libexec/qt5/bin/qmake`
cd PyQt-gpl-$VERSION
python configure.py \
    --confirm-license \
    --qmake=$HOME/bin/qmake \
    --no-qml-plugin \
    --no-designer-plugin
time make
make install
cd ../..
python -c "import PyQt5"
python -c "from PyQt5 import QtGui"
python -c "from PyQt5 import QtCore"

# install dev packages
pip install -r requirements.txt

