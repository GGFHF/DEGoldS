# DEGoldS

DEGoldS (Differential Expression analysis pipelines benchmarking
workflow based on Gold Standard construction) is a workflow to test
pipelines for DE analysis that can accommodate to a wide range of
situations. DEGoldS is implemented as sequential Bash and R scripts
that can run in any OS supporting UNIX.

Refer to the manual DEGoldS_manual.pdf for installation instructions,
workflow description and using instructions. You can also refer to the
pre-print manuscript doi: https://doi.org/10.1101/2022.09.13.507753


### DISCLAIMER

DEGoldS is available for free download from the GitHub
software repository (https://github.com/GGFHF/DEGoldS) under GNU
General Public License v3.0.
This software has been developed in memoriam of Dr. Pablo G. Goicoechea
who initiated this research along with researchers from NEIKER,
Departamento de Sistemas y Recursos Naturales (Universidad Politécnica
de Madrid) and Universidad del País Vasco (UPV/EHU).


### INSTALLATION INSTRUCTIONS

_Miniconda3_

    $ cd /PATH_TO_YOUR_APPS_DIRECTORY (where you will install Miniconda3) 
    $ wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh 
    $ chmod u+x Miniconda3-latest-Linux-x86_64.sh 
    $ ./Miniconda3-latest-Linux-x86_64.sh -b -p /PATH_TO_YOUR_APPS_DIRECTORY/Miniconda3 
    $ rm Miniconda3-latest-Linux-x86_64.sh 
    $ cd /PATH_TO_YOUR_APPS_DIRECTORY/Miniconda3/bin 
    $ ./conda config --add channels defaults 
    $ ./conda config --add channels conda-forge 
    $ ./conda config --add channels r 
    $ ./conda config --add channels bioconda 
    $ cd /PATH_TO_YOUR_APPS_DIRECTORY/Miniconda3/bin 
    $ ./conda install --yes --name base mamba

_FastQC (Bioconda installation)_

    $ cd /PATH_TO_YOUR_APPS_DIRECTORY/Miniconda3/bin
    $ ./mamba create --yes --name fastqc fastqc

_Trinity (Bioconda installation)_

    $ cd /PATH_TO_YOUR_APPS_DIRECTORY/Miniconda3/bin
    $ ./mamba create --yes --name trinity trinity

_BUSCO (Bioconda installation)_

    $ cd /PATH_TO_YOUR_APPS_DIRECTORY/Miniconda3/bin
    $ ./mamba create --yes --name busco busco

_QUAST (Bioconda installation)_

    $ cd /PATH_TO_YOUR_APPS_DIRECTORY/Miniconda3/bin
    $ ./mamba create --yes --name quast quast

_GMAP (Bioconda installation)_

    $ cd /PATH_TO_YOUR_APPS_DIRECTORY/Miniconda3/bin
    $ ./mamba create --yes --name gmap gmap

_Bowtie2 (Bioconda installation)_

    $ cd /PATH_TO_YOUR_APPS_DIRECTORY/Miniconda3/bin
    $ ./mamba create --yes --name bowtie2 bowtie2

_NGShelper_

Installation instruction in https://github.com/GGFHF/NGShelper. These
 instructions don´t make NGShelper available from PATH variable.
 However, this is not necessary as software directory has to be
     specified in NGSHELPER_DIR variable in the scripts.

_RSEM_

Although RSEM can be installed also from Bioconda repositories, issues
regarding to reads simulations have been experienced. For this reason,
installation from source code is suggested (instruction in
https://github.com/deweylab/RSEM).These instructions make RSEM
available from PATH variable, necessary to run the scripts as they are.

_GffCompare_

Although GffCompare can be installed also from Bioconda repositories
some issues have been experienced when running. For this reason,
installation from source code is suggested (instruction in
https://github.com/gpertea/gffcompare). These instructions don´t make
GffCompare available from PATH variable. However, this is not necessary
as software directory has to be specified in GFFCOMPARE_DIR variable in
the scripts.

_R scripts (.R files)_

The following R packages are necessary to run R scripts (.R files).
All scripts have been tested in R version 4.

- _DESeq2_

        if (!require("BiocManager", quietly = TRUE))
            install.packages("BiocManager")
        BiocManager::install("DESeq2")

- _edgeR_

        if (!require("BiocManager", quietly = TRUE))
            install.packages("BiocManager")
        BiocManager::install("edgeR")

- _Tximport_

        if (!require("BiocManager", quietly = TRUE))
            install.packages("BiocManager")
        BiocManager::install("tximport")

- _readr_

        install.packages("readr")

- _IHW_

        if (!require("BiocManager", quietly = TRUE))
            install.packages("BiocManager")
        BiocManager::install("IHW")

- _Apeglm_

        if (!require("BiocManager", quietly = TRUE))
            install.packages("BiocManager")
        BiocManager::install("apeglm")

### WORKFLOW PROCEDURE

_General description_

DEGoldS (Differential Expression analysis pipelines benchmarking
workflow based on Gold-Standard construction) is divided into 4 main
steps which are divided at the same time into different substeps
consisting on different scripts. It is suggested to create a different
directory for every script during the workflow. This simulation-based
workflow is designed for testing DE pipelines using two group of
samples and 3 samples per group starting from real reads so results
can be optimized for a particular set of samples. Although any DE
analyser could be used for benchmarking this workflow pretends to use
DESeq2 and edgeR, so in case user wants to test any other new scripts
should be used. This workflow requires that the pipeline being tested
outputs a GTF/GFF assembly (e. g. Stringtie) so transcripts IDs
conversion can be done. If this is not possible a transcriptome to
genome alignment with GMAP is suggested (e. g. script 1d-03) as it can
output results in GFF file.
Two different simulation pipelines covering from a simpler and less
realistic simulation (Sim1) to a more realistic but more complex one
(Sim2) are described. Both procedures share all the steps except
Step 2b as Sim2 gets expression values from real data while Sim1 has
unrealistic expression values with no dispersion between samples.
Step 2b consists on 4 modules: A-selectable transcripts pool
construction, B-helper scripts for selectable counts pool matrix
construction, C-Sim1 TPM tables construction and D-Sim2 TPM tables
construction. "A" module is used before either "C" (Sim1) or "D" (Sim2)
modules, however "B" module is only used before "D" module. "B" module
together with 2b-D01, 2b-D02, 2b-D03 and 2b-D04 helps to get a reliable
gold-standard. 

_Gold-standard construction_

The gold-standard is built from differential gene expression analysis
(scripts 2d) of the count values taken from script 2c-01. At this point
the gold-standard is called “simulation gold-standard” (simGS) because
gene and transcripts IDs belong to the transcriptome where simulated
reads come from. On the contrary, when this IDs are converted into IDs
from the assembly of the tested DE pipeline (script 4a-02) is called
“pipeline gold-standard” (pipelineGS).  A reliable or suitable
gold-standard for benchmarking means that simGS contains most of the
“upregulated” transcripts requested in simulation but does not contain
any “filler” transcripts as these should not show any significant
differences in a DE expression analysis. Using real expression values
(i.e. Sim2) could lead into a gold-standard with upregulated genes
other than the desired ones or hiding those desired ones. Provided
scripts optimize the chances (so the times to repeat the procedure) to
get a count matrix with potential interesting real counts for
upregulated and filler transcripts for DESeq2 and edgeR. However, after
every simulation simGS should be checked to make sure that most of the
genes corresponding to upregulated transcripts are recovered while no
genes corresponding to filler transcripts are in it (scripts 2d).
The rationale of this step consists on removing counts from a real
matrix that could be in the limit between significant and
non-significant differentially expressed values so increasing chances
for getting a suitable gold-standard. The only thing the user has to do
is to define the number of sequences (line of count in a matrix) to
remove up and down significance limit according to the total number of
transcripts within the transcriptome (script 2b-D02). This would reduce
the times a simulation has to be performed until a suitable
gold-standard is reached.
It is important to make sure that when converting simGS into pipelineGS
there are no multiple pipeline genes corresponding to simulated
“upregulated” transcripts in file
“03-DESeq2_simGS_correspondence_table.csv” in script 4a-02. This should
not be usual but in case this happens user should decide how to proceed
with benchmarking process. One solution could be to consider all the
possible genes but counting +1TP (True Positive) in the scoring process.

_Scripts considerations_

The scripts have to be only modified in the section
"Variables definition" with the required strings provided. The strings
should be placed between quotes (“”). Usually strings are characters
strings, but if specified in instructions a number should be placed.
If there are no quotes it means a number should be placed. Explanation
of every variable can be seen in section 5 (variables instructions) as
well as in the upper part of every script.


