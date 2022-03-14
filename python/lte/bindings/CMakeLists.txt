# Copyright 2020 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

########################################################################
# Check if there is C++ code at all
########################################################################
if(NOT lte_sources)
    MESSAGE(STATUS "No C++ sources... skipping python bindings")
    return()
endif(NOT lte_sources)

########################################################################
# Check for pygccxml
########################################################################
GR_PYTHON_CHECK_MODULE_RAW(
    "pygccxml"
    "import pygccxml"
    PYGCCXML_FOUND
    )

include(GrPybind)

########################################################################
# Python Bindings
########################################################################

list(APPEND lte_python_files
    bch_crc_check_ant_chooser_bb_python.cc
    channel_estimator_vcvc_python.cc
    crc_check_vbvb_python.cc
    descrambler_vfvf_python.cc
    extract_subcarriers_vcvc_python.cc
    layer_demapper_vcvc_python.cc
    mib_unpack_vbm_python.cc
    mimo_pss_coarse_control_python.cc
    mimo_pss_coarse_sync_python.cc
    mimo_pss_fine_sync_python.cc
    mimo_pss_freq_sync_python.cc
    mimo_pss_tagger_python.cc
    mimo_remove_cp_python.cc
    mimo_sss_calculator_python.cc
    mimo_sss_symbol_selector_python.cc
    mimo_sss_tagger_python.cc
    pbch_demux_vcvc_python.cc
    pbch_descrambler_vfvf_python.cc
    pcfich_demux_vcvc_python.cc
    pcfich_unpack_vfm_python.cc
    pre_decoder_vcvc_python.cc
    pss_calculator_vcm_python.cc
    pss_symbol_selector_cvc_python.cc
    pss_tagger_cc_python.cc
    qpsk_soft_demod_vcvf_python.cc
    remove_cp_cvc_python.cc
    repeat_message_source_vf_python.cc
    rough_symbol_sync_cc_python.cc
    sss_calculator_vcm_python.cc
    sss_symbol_selector_cvc_python.cc
    sss_tagger_cc_python.cc
    subblock_deinterleaver_vfvf_python.cc
    sync_frequency_python.cc
    python_bindings.cc)

GR_PYBIND_MAKE_OOT(lte
   ../../..
   gr::lte
   "${lte_python_files}")

# copy in bindings .so file for use in QA test module
add_custom_target(
  copy_bindings_for_tests ALL
  COMMAND
    ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/*.so"
    ${CMAKE_BINARY_DIR}/test_modules/gnuradio/lte/
  DEPENDS lte_python)

install(TARGETS lte_python DESTINATION ${GR_PYTHON_DIR}/gnuradio/lte COMPONENT pythonapi)
