# Mason
This tool is build on top of the **[SeqAn Project](https://www.seqan.de/)**.
* **Description**: Tools for Biological Sequence Simulation
* **Version**: 2.0.10
* **Date**: February, 2014
* **Author**: Manuel Holtgrewe


## Overview

Mason is a collection of tools for the simulation of biological sequences.
The collection consists of the following tools.
 * `mason_frag_sequencing`:
       Simulation of fragment sampling from a genome ([documentation](README.mason_frag_sequencing.md)).
 * `mason_genome`:
       Simulation of random genomic sequences ([documentation](README.mason_genome.md)).
 * `mason_materializer`:
       Apply the variation from a VCF file to a genome in a FASTA file ([documentation](README.mason_materializer.md)).
 * `mason_methylation`:
       Simulate methylation levels for a genome dependent on the context for
       each possible site ([documentation](README.mason_methylation.md)).
 * `mason_simulator`:
       Simulate NGS reads given a genome and optionally also a VCF file with
       variants for a given donor to use as the source ([documentation](README.mason_simulator.md)).
 * `mason_splicing`: Compute the transcriptome from a genome FASTA file and a GFF file with
       the genes ([documentation](README.mason_splicing.md)).
 * `mason_variator`: Simulate SNPs, small indels, and structural variants for genomic data.
       The result is written out as a VCF file. Optionally, the resulting
       modified sequence can also be written out ([documentation](README.mason_variator)).

## Examples

The binaries `mason_*` can be found in the directory build directory.

### Help

Each program has a verbose built-in help that you can view using the `--help`
option.  For example,
```
  $ mason_genome --help
```

prints the help for Mason Genome.

### Simulation of Variants and Reads

In the following, we will give a quick example of how to simulate variants
into a genome, write the variants into a VCF file and then use this VCF file
as the input of the read simulator to simulate reads of the genome with
variants.  Note that there are separated README files for the mason_variator
and the mason_simulator programs.

Let us first simulate variants into the FASTA sequence adeno_virus.fa (from
the "example" folder).  The variants are written to adeno_out.vcf.
```
  $ mason_variator -ir adeno_virus.fa -ov adeno_out.vcf
```
Next, we simulate 100 read pairreads from the input genome and the variants
VCF file:
```
  $ mason_simulator -ir adeno_virus.fa -n 100 -o left.fq -or right.fq
```

## Changelog
### main
 * Extracted mason from the [SeqAn2](https://github.com/seqan/seqan/commit/8ce355dd960bbf7a5fa0292b49f7342f7e456da6) repository.
 * Updated the READMEs
### 2.0.10
 * Original release
