# A Brief Overview Of Specification Files

Please understand that is was created for lab members and shared freely. This is by no means a definative guide. Please refer to the [conda site for more information](https://docs.conda.io/projects/conda-build/en/latest/index.html). You can also refer to this site [here for command specific information](https://docs.conda.io/projects/conda/en/latest/commands/list.html)

## Can You Tell Me About Specification Files?

It is a file with the exact packages used in a conda environment at the time the specification file is created. This can be useful in re-created a conda environment to run scripts such as when you hand off a script to a lab member.
It looks something like the header of the file below:

**A Look Into The Specification File We Used For REDItools:**

```python
# This file may be used to create an environment using:
# $ conda create --name <env> --file <this file>
# platform: linux-64
@EXPLICIT
https://conda.anaconda.org/conda-forge/linux-64/_libgcc_mutex-0.1-conda_forge.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/ca-certificates-2023.11.17-hbcca054_0.conda
https://conda.anaconda.org/conda-forge/linux-64/ld_impl_linux-64-2.40-h41732ed_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-ng-13.2.0-h7e041cc_3.conda
https://conda.anaconda.org/conda-forge/linux-64/libgomp-13.2.0-h807b86a_3.conda
https://conda.anaconda.org/conda-forge/linux-64/_openmp_mutex-4.5-2_gnu.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libgcc-ng-13.2.0-h807b86a_3.conda
https://conda.anaconda.org/conda-forge/linux-64/bzip2-1.0.8-hd590300_5.conda
https://conda.anaconda.org/conda-forge/linux-64/c-ares-1.24.0-hd590300_0.conda
https://conda.anaconda.org/conda-forge/linux-64/keyutils-1.6.1-h166bdaf_0.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libdeflate-1.13-h166bdaf_0.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libev-4.33-hd590300_2.conda
https://conda.anaconda.org/conda-forge/linux-64/libffi-3.2.1-he1b5a44_1007.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libgfortran5-13.2.0-ha4646dd_3.conda
https://conda.anaconda.org/conda-forge/linux-64/libzlib-1.2.13-hd590300_5.conda
https://conda.anaconda.org/conda-forge/linux-64/ncurses-6.4-h59595ed_2.conda
https://conda.anaconda.org/conda-forge/linux-64/openssl-1.1.1w-hd590300_0.conda
https://conda.anaconda.org/conda-forge/linux-64/xz-5.2.6-h166bdaf_0.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libedit-3.1.20191231-he28a2e2_2.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libgfortran-ng-13.2.0-h69a702a_3.conda
https://conda.anaconda.org/conda-forge/linux-64/libnghttp2-1.51.0-hdcd2b5c_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libsqlite-3.44.2-h2797004_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libssh2-1.10.0-haa6b8db_3.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/readline-8.2-h8228510_1.conda
https://conda.anaconda.org/conda-forge/linux-64/tk-8.6.13-noxft_h4845f30_101.conda
https://conda.anaconda.org/conda-forge/linux-64/zlib-1.2.13-hd590300_5.conda
https://conda.anaconda.org/conda-forge/linux-64/krb5-1.20.1-hf9c8cef_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libopenblas-0.3.25-pthreads_h413a1c8_0.conda
https://conda.anaconda.org/conda-forge/linux-64/sqlite-3.44.2-h2c6b66d_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libblas-3.9.0-20_linux64_openblas.conda
https://conda.anaconda.org/conda-forge/linux-64/libcurl-7.87.0-h6312ad2_0.conda
https://conda.anaconda.org/conda-forge/linux-64/python-2.7.15-h5a48372_1011_cpython.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libcblas-3.9.0-20_linux64_openblas.conda
https://conda.anaconda.org/conda-forge/linux-64/liblapack-3.9.0-20_linux64_openblas.conda
https://conda.anaconda.org/conda-forge/linux-64/python_abi-2.7-1_cp27mu.tar.bz2
https://conda.anaconda.org/conda-forge/noarch/wheel-0.37.1-pyhd8ed1ab_0.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/certifi-2019.11.28-py27h8c360ce_1.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/numpy-1.16.5-py27h95a1406_0.tar.bz2
https://conda.anaconda.org/bioconda/linux-64/pysam-0.20.0-py27h7835474_0.tar.bz2
https://conda.anaconda.org/bioconda/linux-64/fisher-0.1.4-py27h24bf2e0_1.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/setuptools-44.0.0-py27_0.tar.bz2
https://conda.anaconda.org/conda-forge/noarch/pip-20.1.1-pyh9f0ad1d_0.tar.bz2

```

## How Do I Create A Specification File? 

Once you have activated the conda environment of your choice, and installed the packages you need you can used this command to create the specification file:

*Scaffold:*
```bash
conda list --explicit > NameYouChooseForYourSpecificationList.txt
```

You can deactivate your conda environment after creating this file.

## How Do I Use A Specification File?

You can use a specification file to create a conda envrionment. If you are given one the scaffold of the command you can use to create a conda environment based on a specification list is below:

*Scaffold:*

```bash
conda create --name NameYouChooseForYourNewCondaEnvrionment --file ProvidedSpecListFile.txt
```
