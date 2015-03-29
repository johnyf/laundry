venvname=clean_dev

which bison
which flex
pip install mercurial

# =================
# install SIP4
# =================

# link found from:
#    http://www.riverbankcomputing.com/software/sip/download
hg clone hg clone http://www.riverbankcomputing.com/hg/sip

# installation instructions here:
#    http://pyqt.sourceforge.net/Docs/sip4/installation.html
cd sip
python build.py prepare
python configure.py --incdir ~/.virtualenvs/$venvname/include/python2.7/
time make
make install

# ================
# install PyQt4
# ================
# download link found here:
#    http://www.riverbankcomputing.com/software/pyqt/download
select=mac # or x11
curl -LO http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.1/PyQt-$select-gpl-4.11.1.tar.gz
tar vzxf PyQt-*

# http://pyqt.sourceforge.net/Docs/PyQt4/installation.html
cd PyQt-*

# alternative:
# curl -LO http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.1/PyQt-mac-gpl-4.11.1.tar.gz
#
python configure-ng.py
time make
make install

# install dev packages
pip install -r requirements.txt
