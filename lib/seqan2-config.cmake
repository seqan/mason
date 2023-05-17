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

# Optional for SeqAn2, need to be found before configuring SeqAn2
find_package (OpenMP QUIET)
find_package (ZLIB QUIET REQUIRED)
find_package (BZip2 QUIET REQUIRED)

# Find SeqAn2, needs 2 variables set
set (SeqAn_DIR "${CMAKE_CURRENT_LIST_DIR}/seqan/util/cmake")
set (SEQAN_INCLUDE_PATH "${CMAKE_CURRENT_LIST_DIR}/seqan/include")
find_package (SeqAn QUIET REQUIRED)

# Define a SeqAn2 interface
add_library (seqan2 INTERFACE)
target_include_directories (seqan2 SYSTEM INTERFACE ${SEQAN_INCLUDE_DIRS})
string (STRIP "${SEQAN_CXX_FLAGS}" SEQAN_CXX_FLAGS) # SEQAN_CXX_FLAGS may have a leading whitespace
target_compile_options (seqan2 INTERFACE ${SEQAN_CXX_FLAGS})
target_compile_definitions (seqan2 INTERFACE ${SEQAN_DEFINITIONS})
target_link_libraries (seqan2 INTERFACE ${SEQAN_LIBRARIES})
if (OpenMP_FOUND) # SeqAn2 does not link something
    target_link_libraries (seqan2 INTERFACE OpenMP::OpenMP_CXX)
endif ()
add_library (seqan2::seqan2 ALIAS seqan2)
