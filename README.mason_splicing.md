# Mason Splicing
## Overview

The program `mason_splicing` allows one to construct transcripts from a GFF/GTF file, a
reference sequence and an optional variant file.

## Examples

There are example files in the `examples` directory.

### Help
The command:
```
  $ mason_splicing --help
```
prints the help for Mason Splicing.

### Transcript Simulation

We can use mason_splicing to simulate the transcript from a GFF file and its
reference.  Note that this would also work with a GTF file:
```
  $ mason_splicing -ir adeno_virus_b.fa -ig adeno_virus_b.gff -o out.fa \
      --gff-type cds --gff-group-by translation_id
  ...
  $ head out.fa
  >pro.1
  TTATGGCCTGGGGCGTTTACAGCTCAAGTCCAAAGGTTGCCCAGACTCGTTAAGCAAGTCCTCGATACAT
  TCCACAGCCTGGCGACGCCCACCAACTCTCACGGCAACTGGTTTAATGGGGCACAGCGGGACCACCGGGT
  GTATCTCAGGAGGTGTGTTAGAAGGACCGGAGTCACAGCTATCCGTACTACTATTGCATTCTCTAGACAC
  AGGTGATGTCGGGCGTCTCAGGATAGCAGGCACCAATTTAGGACGCCGGGTAGGTCTTGCAGGCTCCGGT
  TCTGGCTCGGGCTCAGGCTCAGGTTCAGACACAGGACCTTTTAAAAAATCACAATACAAAATTCTTTAAA
  CCACAAAACTGTAAAAATTAAAAAAAAATTACCACACCAAACCCACCACTCTATCACCGACTGCCCATAA
  TTTTCACTTACTGTAGACAAACATGCCACAGGTCCTCATATAGCAAAGCGAACACATAATATCTGGGTCC
  CCCGTATTCCTCCGGTGATAATGACAAGACCTGCAACCGTGCCCGGGGTGCTCCACATAATCTAACACAA
  ACTCCTCACCCTCTTCATCCTCGTCGTCACTGGGTGGAAAGCCAGCCTCGTGGCAGGTAAGATCGATCAC
```

Besides the path to the input FASTA and GFF file and the output FASTA file, we
also give the parameters --gff-type and --gff-group-by.

The GFF type is the value of the third column (in both GFF and GTF) to filter
for.  Here, we use "cds", another value could be "exon".

The GFF group-by key is the name of a key/tag from the last column of the
GTF/GTF file.  Here, this is transcript_id, for your data this could also be
"Parent", for example.

mason_splicing will read in the reference FASTA file and the GFF file.  For
each group of GFF/GTF records with the same "group-by" key, it will generate
one sequence in the output FASTA file.  For this, it will take all records
with the type given by --gff-type and concatenate the sequence from these
features in the order that they occur in in the genome.
