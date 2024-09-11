# A Brief Overview Of Specification Files

Please understand that is was created for lab members and shared freely. This is by no means a definative guide. Please refer to the [conda site for more information](https://docs.conda.io/projects/conda-build/en/latest/index.html). You can also refer to this site [here for command specific information](https://docs.conda.io/projects/conda/en/latest/commands/list.html)

## Can You Tell Me About Specification Files?

It is a file with the exact packages used in a conda environment at the time the specification file is created. This can be useful in re-created a conda environment to run scripts such as when you hand off a script to a lab member.
It looks something like the header of the file below:

**A Specification File We Used:**

```python
# This file may be used to create an environment using:
# $ conda create --name <env> --file <this file>
# platform: linux-64
@EXPLICIT
https://conda.anaconda.org/conda-forge/linux-64/_libgcc_mutex-0.1-conda_forge.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/ca-certificates-2023.11.17-hbcca054_0.conda
https://conda.anaconda.org/conda-forge/linux-64/ld_impl_linux-64-2.40-h41732ed_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-ng-13.2.0-h7e041cc_3.conda
https://conda.anaconda.org/conda-forge/linux-64/python_abi-3.11-4_cp311.conda
https://conda.anaconda.org/conda-forge/noarch/tzdata-2023d-h0c530f3_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libgomp-13.2.0-h807b86a_3.conda
https://conda.anaconda.org/conda-forge/linux-64/_openmp_mutex-4.5-2_gnu.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libgcc-ng-13.2.0-h807b86a_3.conda
https://conda.anaconda.org/conda-forge/linux-64/bzip2-1.0.8-hd590300_5.conda
https://conda.anaconda.org/conda-forge/linux-64/libexpat-2.5.0-hcb278e6_1.conda
https://conda.anaconda.org/conda-forge/linux-64/libffi-3.4.2-h7f98852_5.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libgfortran5-13.2.0-ha4646dd_3.conda
https://conda.anaconda.org/conda-forge/linux-64/libnsl-2.0.1-hd590300_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libuuid-2.38.1-h0b41bf4_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libzlib-1.2.13-hd590300_5.conda
https://conda.anaconda.org/conda-forge/linux-64/ncurses-6.4-h59595ed_2.conda
https://conda.anaconda.org/conda-forge/linux-64/openssl-3.2.0-hd590300_1.conda
https://conda.anaconda.org/conda-forge/linux-64/xz-5.2.6-h166bdaf_0.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/libgfortran-ng-13.2.0-h69a702a_3.conda
https://conda.anaconda.org/conda-forge/linux-64/libsqlite-3.44.2-h2797004_0.conda
https://conda.anaconda.org/conda-forge/linux-64/readline-8.2-h8228510_1.conda
https://conda.anaconda.org/conda-forge/linux-64/tk-8.6.13-noxft_h4845f30_101.conda
https://conda.anaconda.org/conda-forge/linux-64/libopenblas-0.3.25-pthreads_h413a1c8_0.conda
https://conda.anaconda.org/conda-forge/linux-64/python-3.11.5-hab00c5b_0_cpython.conda
https://conda.anaconda.org/conda-forge/linux-64/libblas-3.9.0-20_linux64_openblas.conda
https://conda.anaconda.org/conda-forge/noarch/packaging-23.2-pyhd8ed1ab_0.conda
https://conda.anaconda.org/conda-forge/noarch/python-tzdata-2023.4-pyhd8ed1ab_0.conda
https://conda.anaconda.org/conda-forge/noarch/pytz-2023.3.post1-pyhd8ed1ab_0.conda
https://conda.anaconda.org/conda-forge/noarch/setuptools-68.2.2-pyhd8ed1ab_0.conda
https://conda.anaconda.org/conda-forge/noarch/six-1.16.0-pyh6c4a22f_0.tar.bz2
https://conda.anaconda.org/conda-forge/noarch/wheel-0.42.0-pyhd8ed1ab_0.conda
https://conda.anaconda.org/conda-forge/linux-64/libcblas-3.9.0-20_linux64_openblas.conda
https://conda.anaconda.org/conda-forge/linux-64/liblapack-3.9.0-20_linux64_openblas.conda
https://conda.anaconda.org/conda-forge/noarch/pip-23.3.2-pyhd8ed1ab_0.conda
https://conda.anaconda.org/conda-forge/noarch/python-dateutil-2.8.2-pyhd8ed1ab_0.tar.bz2
https://conda.anaconda.org/conda-forge/linux-64/numpy-1.26.2-py311h64a7726_0.conda
https://conda.anaconda.org/conda-forge/linux-64/pandas-2.1.4-py311h320fe9a_0.conda
https://conda.anaconda.org/conda-forge/noarch/patsy-0.5.5-pyhd8ed1ab_0.conda
https://conda.anaconda.org/conda-forge/linux-64/scipy-1.11.4-py311h64a7726_0.conda
https://conda.anaconda.org/conda-forge/linux-64/statsmodels-0.14.1-py311h1f0f07a_0.conda
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
