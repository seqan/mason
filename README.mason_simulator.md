# Mason Simulator
## Overview

The program `mason_simulater` is the read simulator from the Mason package.

The simulator has the following features:

  * Single-end and paired-end data,
  * Illumina, 454, and Sanger error models,
  * simulate haplotypes directly from VCF file,
  * BS-Seq simulation, and
  * low main memory usage

### Simulation Process

The simulation process is depicted in the following picture:
```
   [Reference]
       +--------<----- (Optional VCF FILE)
       |
       V
   [Haplotype]
       |
       V
   [Fragment]
       |
       V
   [Single or Paired-End Read] + [Alignment]
```
The reference is loaded and optionally, variants from a VCF file can be
applied.  You can simulate such variants using `mason_variator`.  This results
in a haplotype that thus can differ from the reference sequence.

Next, fragments are simulated from the sequence (the molecules simulated by
the "Random Fragmentation" step in NGS protocols).  The fragments can then be
sequenced from either side or both side (single-end or paired-end reads).

When using BS-seq simulation, methylation levels are loaded together with the
reference and the variants are also applied to the VCF file (structural
variants might move parts of the level strings and at SNPs and around
breakpoints, the levels are recomputed since the context may have changed.

## Examples

There are example files in the `examples` directory.

### Help

The command:
```
  $ mason_simulator --help
```
prints the help for Mason Simulator.

### Single-End Illumina Simulation

Simulation of 1000 single-end Illumina reads of length 150bp (default is
100bp) from a genome.  Write out a FASTA file for the reads an a SAM file for
the alignments.
```
  mason_simulator -ir adeno_vrius.fa -n 1000 --illumina-read-length 150 \
    -o reads.fa -oa alignments.sam
```

### Paired-End Illumina Simulation, With Variants

Simulation of paired-end Illumina sequencing (1000 read pairs) from a genome,
including variation from a VCF file.  The result is written to FASTQ files and
alignments are written to a SAM file.
```
  mason_simulator -ir genome.fa -iv variants.vcf -n 1000 -o reads_1.fq \
    -or reads_2.fq -oa alignments.sam
```

### Paired-End Illumina Simulation, Without Variants

Simulation of mate-pair Illumina sequencing (1000 read pairs) from a genome
without a VCF file.  Write out results as FASTQ file and alignments as SAM
file.

```
  mason_simulator -ir genome.fa -n 1000 -o reads_1.fq -or reads_2.fq \
    -oa alignments.sam
```

### Single-End 454 Read Simulation

Simulation of single-end 454 sequencing (1000 reads) from a genome without a
VCF file, write out alignments as SAM file and reads as FASTQ file.  The read
length follows a normal distribution with mean 800 and standard deviation 200.

Note that we explicitely increas the fragment length otherwise the reads will
be longer than the simulated fragments (which by default follow a normal
distribution with mean 300 and deviation 30).
```
  mason_simulator -ir genome.fa -n 1000 --seq-technology 454 \
    --454-read-length-mean 800 --454-read-length-stddev 200  \
    --fragment-mean-size 2000 --fragment-size-std-dev 200 \
    -o reads.fq -oa alignments.sam
```
