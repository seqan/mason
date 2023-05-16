# -----------------------------------------------------------------------------------------------------
# Copyright (c) 2006-2023, Knut Reinert & Freie Universität Berlin
# Copyright (c) 2016-2023, Knut Reinert & MPI für molekulare Genetik
# This file may be used, modified and/or redistributed under the terms of the 3-clause BSD-License
# shipped with this file.
# -----------------------------------------------------------------------------------------------------

cmake_minimum_required (VERSION 3.12)

if (TARGET seqan2::seqan2)
    return ()
endif ()

find_package (OpenMP QUIET)
find_package (ZLIB REQUIRED)
find_package (BZip2 REQUIRED)

add_library (seqan2 INTERFACE)
target_include_directories (seqan2 SYSTEM INTERFACE ${CMAKE_CURRENT_LIST_DIR}/seqan/include)
if (OpenMP_FOUND)
    target_link_libraries (seqan2 INTERFACE OpenMP::OpenMP_CXX)
    target_compile_definitions (seqan2 INTERFACE -DSEQAN_HAS_OPENMP)
endif ()
target_link_libraries (seqan2 INTERFACE ZLIB::ZLIB BZip2::BZip2)
target_compile_definitions (seqan2 INTERFACE -DSEQAN_HAS_ZLIB -DSEQAN_HAS_BZIP2)
add_library (seqan2::seqan2 ALIAS seqan2)
