# Mason Genome
## Overview

The program `mason_genome` is a simple sequence simulator.

## Examples
### Help
The command:
```
  $ mason_genome --help
```
prints the help for Mason Genome.

### Simulating a Genome
We call `mason_genome` to simulate a genome with sequences of length 100,
200, and 1000.
```
  $ mason_genome -l 100 -l 200 -l 1000 -o simulated.fa
  ...
  $ head simulated.fa
  >1
  GGGTGTGTCGGCCCTATCCCTTGCGCTTACAGACTTTATTTCTTCGTGAGGGAGTTGACCCATGCAGAAC
  GAGAGCTTGCCGCTGAATGGGAACATCGCC
  >2
  GACGTTAGAGATGGCCCCAGACAGGCATATCGTAAGTGATTTCGTAGCGAACCTACCCAGCTCTAAGGGT
  CGGTATGATCCAGTAGGTCCACGGAATCAAGGCGGCTCATGCGTGGATTGCCTTGACTTCCGTAGCTTGG
  GGGGTAGCCGGCACCGGCCCGGCTAACAGCGGGAGTGCCATACACTTCTGGCAATCGCTT
  >3
  ATTAAGGAATTTTCGACAATGCCCGATCTATAATCTGGACGCACAAAATCATCTTGGGATAGGAGGATTC
  GGGTGTGTCGCAAAAATGGCCTAGCAAACCCTGTCGAGATAGGCCGGGTGTCACGTCAAATTCTCGGCTG
```