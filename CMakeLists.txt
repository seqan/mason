# -----------------------------------------------------------------------------------------------------
# Copyright (c) 2006-2023, Knut Reinert & Freie Universität Berlin
# Copyright (c) 2016-2023, Knut Reinert & MPI für molekulare Genetik
# This file may be used, modified and/or redistributed under the terms of the 3-clause BSD-License
# shipped with this file.
# -----------------------------------------------------------------------------------------------------
cmake_minimum_required (VERSION 3.15.0)

project (seqan_apps_mason2 CXX)
set (SEQAN_APP_VERSION "2.0.10")

# ----------------------------------------------------------------------------
# Dependencies
# ----------------------------------------------------------------------------
find_package (OpenMP)
find_package (SeqAn2 REQUIRED HINTS lib)

# We define a library for the reusable parts of Mason.
add_library (mason_sim
             src/external_split_merge.h
             src/external_split_merge.cpp
             src/fragment_generation.h
             src/genomic_variants.h
             src/genomic_variants.cpp
             src/individual_genome.h
             src/mason_options.cpp
             src/mason_options.h
             src/mason_types.h
             src/methylation_levels.cpp
             src/methylation_levels.h
             src/omp_wrapper.h
             src/sequencing.h
             src/simulate_454.cpp
             src/simulate_base.cpp
             src/simulate_genome.cpp
             src/simulate_genome.h
             src/simulate_illumina.cpp
             src/simulate_sanger.cpp
             src/variation_size_tsv.h
             src/vcf_materialization.cpp
             src/vcf_materialization.h)
target_link_libraries (mason_sim seqan2::seqan2)

# Simulate random genomes.
add_executable (mason_genome src/mason_genome.cpp)

# Simulate methylation levels for gnome.
add_executable (mason_methylation src/mason_methylation.cpp)

# Simulate sequencing of fragments.
add_executable (mason_frag_sequencing src/mason_frag_sequencing.cpp)

# Simulation of structural variants into FASTA sequences.
add_executable (mason_variator src/mason_variator.cpp)

# The materializer reads in FASTA and VCF and writes out FASTA.
add_executable (mason_materializer src/mason_materializer.cpp)

# The end-to-end read simulator includes materialization and fragment sampling.
add_executable (mason_simulator src/mason_simulator.cpp)

# Simulation splicing given a reference, GFF/GTF file, and possibly VCF for variants.
add_executable (mason_splicing src/mason_splicing.cpp)

# Tests for some of the library functionality.
add_executable (mason_tests src/mason_tests.cpp)

# Add dependencies found by find_package (SeqAn).
target_link_libraries (mason_frag_sequencing mason_sim)
target_link_libraries (mason_genome mason_sim)
target_link_libraries (mason_materializer mason_sim)
target_link_libraries (mason_methylation mason_sim)
target_link_libraries (mason_simulator mason_sim)
target_link_libraries (mason_splicing mason_sim)
target_link_libraries (mason_tests mason_sim)
target_link_libraries (mason_variator mason_sim)
