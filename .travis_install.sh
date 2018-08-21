#!/usr/bin/env bash
# Deactivate the travis-provided virtual environment and setup a conda-based environment instead
deactivate

pushd .
cd
mkdir -p download
cd download
echo "Cached in $HOME/download :"
ls -l
echo
if [[ ! -f miniconda.sh ]]
   then
   wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
       -O miniconda.sh
   fi
chmod +x miniconda.sh && ./miniconda.sh -b
cd ..
export PATH=/home/travis/miniconda3/bin:$PATH
conda update --yes conda
popd

conda create -n testenv --yes python=$TRAVIS_PYTHON_VERSION pip pytest hdf5 \
      numpy=$NUMPY_VERSION scipy=$SCIPY_VERSION numba scikit-learn statsmodels

source activate testenv
