# MCMCTree

## Installation

Download mcmctree
```
conda create -n paml -c bioconda paml
conda activate paml
```

## Preparing input files

Three input files are required:
1. Control file `mcmctree.ctl`
2. Tree with calibrations `pf16_noAbInit_mcmc.tree`
3. Alignment (protein) `pf16_noAbInit_concat.fa`

Prepare and configure the control file and trees according to the [mcmctree tutorial](http://abacus.gene.ucl.ac.uk/software/MCMCtree.Tutorials.pdf).

Key fields to change in `mcmctree.ctl` are:
- `seqfile`
- `treefile`
- `usedata`

## Running MCMCTree

### Initial run

Ensure the three files are in the same directory.

First, generate temporary files for approximate likelihood calculation.

**Ensure `usedata=3` in `.ctl` file.**

Run:
```
mcmctree mcmctree.ctl
```
(This took ~ 5 minutes)

### Approximate likelihood estimation

Rename `out.BV`:
```
mv out.BV in.BV
```

**Change `usedata=2` in `.ctl` file.**

Run:
```
mcmctree mcmctree.ctl
```
(Took ~30 secs)


## References
1. [mcmctree tutorials](http://abacus.gene.ucl.ac.uk/software/MCMCtree.Tutorials.pdf)
2. [mcmctree manual](http://nebc.nerc.ac.uk/bioinformatics/documentation/paml/doc/MCMCtreeDoc.pdf)
