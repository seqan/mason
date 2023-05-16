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
target_link_libraries (mason_genome mason_sim)

# Simulate methylation levels for gnome.
add_executable (mason_methylation src/mason_methylation.cpp)
target_link_libraries (mason_methylation mason_sim)

# Simulate sequencing of fragments.
add_executable (mason_frag_sequencing src/mason_frag_sequencing.cpp)
target_link_libraries (mason_frag_sequencing mason_sim)

# Simulation of structural variants into FASTA sequences.
add_executable (mason_variator src/mason_variator.cpp)
target_link_libraries (mason_variator mason_sim)

# The materializer reads in FASTA and VCF and writes out FASTA.
add_executable (mason_materializer src/mason_materializer.cpp)
target_link_libraries (mason_materializer mason_sim)

# The end-to-end read simulator includes materialization and fragment sampling.
add_executable (mason_simulator src/mason_simulator.cpp)
target_link_libraries (mason_simulator mason_sim)

# Simulation splicing given a reference, GFF/GTF file, and possibly VCF for variants.
add_executable (mason_splicing src/mason_splicing.cpp)
target_link_libraries (mason_splicing mason_sim)




# Tests for some of the library functionality.
enable_testing()
add_executable (mason_tests src/mason_tests.cpp)
target_link_libraries (mason_tests mason_sim)
add_test(mason_tests mason_tests)
add_test(NAME app_test_mason
        COMMAND python
                ${CMAKE_CURRENT_LIST_DIR}/tests/run_tests.py
                ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR})

# Install Mason binaries in ${PREFIX}/bin directory
install (TARGETS mason_genome
                 mason_methylation
                 mason_frag_sequencing
                 mason_variator
                 mason_materializer
                 mason_simulator
                 mason_splicing
         DESTINATION ${CMAKE_INSTALL_BINDIR})

# Install non-binary files for the package to "." for app builds and
# ${PREFIX}/share/doc/mason2 for SeqAn release builds.
install (FILES LICENSE
               README
               README.mason_frag_sequencing
               README.mason_genome
               README.mason_materializer
               README.mason_methylation
               README.mason_simulator
               README.mason_splicing
               README.mason_variator
         DESTINATION ${CMAKE_INSTALL_DATA_DIR}/doc/mason2})
install (FILES example/adeno_virus.fa
         DESTINATION ${CMAKE_INSTALL_DATA_DIR}/doc/mason2/example)

