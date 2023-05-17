# -----------------------------------------------------------------------------------------------------
# Copyright (c) 2006-2023, Knut Reinert & Freie Universität Berlin
# Copyright (c) 2016-2023, Knut Reinert & MPI für molekulare Genetik
# This file may be used, modified and/or redistributed under the terms of the 3-clause BSD-License
# shipped with this file.
# -----------------------------------------------------------------------------------------------------
cmake_minimum_required (VERSION 3.15.0)

project (mason
         LANGUAGES CXX
         VERSION 2.0.10
         DESCRIPTION "Mason -- Tools for Biological Sequence Simulation"
         HOMEPAGE_URL "https://github.com/seqan/mason"
)

set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

# ----------------------------------------------------------------------------
# Dependencies
# ----------------------------------------------------------------------------
find_package (SeqAn2 REQUIRED PATHS lib)

if (NOT TARGET mason_interface)
    add_library ("mason_interface" INTERFACE)
    target_link_libraries ("mason_interface" INTERFACE seqan2::seqan2)
    target_include_directories ("mason_interface" INTERFACE "${CMAKE_CURRENT_LIST_DIR}/include")
    target_compile_options ("mason_interface" INTERFACE "-pedantic" "-Wall" "-Wextra" "-flto=auto")
    target_link_options ("mason_interface" INTERFACE "-flto=auto")
    # This warning is suppressed in SeqAn2, but #pragma GCC diagnostic takes no effect with LTO (bug)
    if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        target_link_options ("mason_interface" INTERFACE "-Wno-alloc-size-larger-than")
    endif ()
    target_compile_definitions ("mason_interface" INTERFACE SEQAN_APP_VERSION="${CMAKE_PROJECT_VERSION}")
endif ()

# We define a library for the reusable parts of Mason.
add_library (mason_sim STATIC
             src/mason/external_split_merge.cpp
             src/mason/genomic_variants.cpp
             src/mason/mason_options.cpp
             src/mason/methylation_levels.cpp
             src/mason/simulate_454.cpp
             src/mason/simulate_base.cpp
             src/mason/simulate_genome.cpp
             src/mason/simulate_illumina.cpp
             src/mason/simulate_sanger.cpp
             src/mason/vcf_materialization.cpp
)
target_link_libraries (mason_sim mason_interface)

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
enable_testing ()
add_executable (mason_tests src/mason/mason_tests.cpp)
target_link_libraries (mason_tests mason_sim)
add_test (mason_tests ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/mason_tests)
add_test (NAME app_test_mason COMMAND python ${CMAKE_CURRENT_LIST_DIR}/tests/run_tests.py ${CMAKE_SOURCE_DIR}
                                      ${CMAKE_BINARY_DIR}
)

# Install Mason binaries in ${PREFIX}/bin directory
install (TARGETS mason_genome
                 mason_methylation
                 mason_frag_sequencing
                 mason_variator
                 mason_materializer
                 mason_simulator
                 mason_splicing
         RUNTIME
)

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
               example/adeno_virus.fa
         TYPE DOC
)
