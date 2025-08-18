; RUN: llc -verify-machineinstrs -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_vector_compute %s -o - | FileCheck %s
; XFAIL:*

; CHECK-DAG: OpExtension "SPV_KHR_float_controls"
; CHECK-DAG: OpExtension "SPV_INTEL_float_controls2"
; CHECK-DAG: OpExtension "SPV_INTEL_vector_compute"
; CHECK-DAG: OpCapability Addresses
; CHECK-DAG: OpCapability Linkage
; CHECK-DAG: OpCapability Kernel
; CHECK-DAG: OpCapability DenormPreserve
; CHECK-DAG: OpCapability DenormFlushToZero
; CHECK-DAG: OpCapability RoundingModeRTE
; CHECK-DAG: OpCapability RoundingModeRTZ
; CHECK-DAG: OpCapability RoundToInfinityINTEL
; CHECK-DAG: OpCapability FloatingPointModeINTEL
; CHECK-DAG: OpCapability VectorComputeINTEL
; CHECK-DAG: OpCapability FunctionFloatControlINTEL
; CHECK-DAG: %[[#INT:]] = OpTypeInt 32 0
; CHECK-DAG: %[[#VOID:]] = OpTypeVoid
; CHECK-DAG: %[[#FUNC:]] = OpTypeFunction %[[#VOID]] %[[#INT]] %[[#INT]]
; CHECK-DAG: OpEntryPoint Kernel %[[#S_RTE:]] "k_rte"
; CHECK-DAG: OpExecutionMode %[[#S_RTE]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_RTE]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_RTE]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_RTE]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_RTE]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_RTE]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_RTE]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTE]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTE]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_RTE]] LinkageAttributes "k_rte" Export
; CHECK-DAG: OpDecorate %[[#S_RTE]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_RTE]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTE]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_RTE]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTE]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTE]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_RTE]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTE]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTE]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_RTE]] FunctionFloatingPointModeINTEL 16 IEEE

; CHECK-DAG: OpEntryPoint Kernel %[[#S_RTP:]] "k_rtp"
; CHECK-DAG: OpExecutionMode %[[#S_RTP]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_RTP]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_RTP]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_RTP]] RoundingModeRTPINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTP]] RoundingModeRTPINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTP]] RoundingModeRTPINTEL 16

; CHECK-DAG: OpExecutionMode %[[#S_RTP]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTP]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTP]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_RTP]] LinkageAttributes "k_rtp" Export
; CHECK-DAG: OpDecorate %[[#S_RTP]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_RTP]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTP]] FunctionRoundingModeINTEL 64 RTP
; CHECK-DAG: OpDecorate %[[#S_RTP]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTP]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTP]] FunctionRoundingModeINTEL 32 RTP
; CHECK-DAG: OpDecorate %[[#S_RTP]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTP]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTP]] FunctionRoundingModeINTEL 16 RTP
; CHECK-DAG: OpDecorate %[[#S_RTP]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_RTN:]] "k_rtn"

; CHECK-DAG: OpExecutionMode %[[#S_RTN]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_RTN]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_RTN]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_RTN]] RoundingModeRTNINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTN]] RoundingModeRTNINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTN]] RoundingModeRTNINTEL 16

; CHECK-DAG: OpExecutionMode %[[#S_RTN]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTN]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTN]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_RTN]] LinkageAttributes "k_rtn" Export
; CHECK-DAG: OpDecorate %[[#S_RTN]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_RTN]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTN]] FunctionRoundingModeINTEL 64 RTN
; CHECK-DAG: OpDecorate %[[#S_RTN]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTN]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTN]] FunctionRoundingModeINTEL 32 RTN
; CHECK-DAG: OpDecorate %[[#S_RTN]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTN]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTN]] FunctionRoundingModeINTEL 16 RTN
; CHECK-DAG: OpDecorate %[[#S_RTN]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_RTZ:]] "k_rtz"

; CHECK-DAG: OpExecutionMode %[[#S_RTZ]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_RTZ]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_RTZ]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_RTZ]] RoundingModeRTZ 64
; CHECK-DAG: OpExecutionMode %[[#S_RTZ]] RoundingModeRTZ 32
; CHECK-DAG: OpExecutionMode %[[#S_RTZ]] RoundingModeRTZ 16

; CHECK-DAG: OpExecutionMode %[[#S_RTZ]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTZ]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTZ]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_RTZ]] LinkageAttributes "k_rtz" Export
; CHECK-DAG: OpDecorate %[[#S_RTZ]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_RTZ]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTZ]] FunctionRoundingModeINTEL 64 RTZ
; CHECK-DAG: OpDecorate %[[#S_RTZ]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTZ]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTZ]] FunctionRoundingModeINTEL 32 RTZ
; CHECK-DAG: OpDecorate %[[#S_RTZ]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTZ]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTZ]] FunctionRoundingModeINTEL 16 RTZ
; CHECK-DAG: OpDecorate %[[#S_RTZ]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_FTZ:]] "k_ftz"

; CHECK-DAG: OpExecutionMode %[[#S_FTZ]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_FTZ]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_FTZ]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_FTZ]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_FTZ]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_FTZ]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_FTZ]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_FTZ]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_FTZ]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_FTZ]] LinkageAttributes "k_ftz" Export
; CHECK-DAG: OpDecorate %[[#S_FTZ]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_FTZ]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_FTZ]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_FTZ]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_FTZ]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_FTZ]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_FTZ]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_FTZ]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_FTZ]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_FTZ]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_DD:]] "k_dd"

; CHECK-DAG: OpExecutionMode %[[#S_DD]] DenormPreserve 64
; CHECK-DAG: OpExecutionMode %[[#S_DD]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_DD]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_DD]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_DD]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_DD]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_DD]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_DD]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_DD]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_DD]] LinkageAttributes "k_dd" Export
; CHECK-DAG: OpDecorate %[[#S_DD]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_DD]] FunctionDenormModeINTEL 64 Preserve
; CHECK-DAG: OpDecorate %[[#S_DD]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_DD]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_DD]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_DD]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_DD]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_DD]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_DD]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_DD]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_DF:]] "k_df"

; CHECK-DAG: OpExecutionMode %[[#S_DF]] DenormPreserve 32
; CHECK-DAG: OpExecutionMode %[[#S_DF]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_DF]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_DF]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_DF]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_DF]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_DF]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_DF]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_DF]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_DF]] LinkageAttributes "k_df" Export
; CHECK-DAG: OpDecorate %[[#S_DF]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_DF]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_DF]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_DF]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_DF]] FunctionDenormModeINTEL 32 Preserve
; CHECK-DAG: OpDecorate %[[#S_DF]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_DF]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_DF]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_DF]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_DF]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_DHF:]] "k_dhf"

; CHECK-DAG: OpExecutionMode %[[#S_DHF]] DenormPreserve 16
; CHECK-DAG: OpExecutionMode %[[#S_DHF]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_DHF]] DenormFlushToZero 32

; CHECK-DAG: OpExecutionMode %[[#S_DHF]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_DHF]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_DHF]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_DHF]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_DHF]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_DHF]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_DHF]] LinkageAttributes "k_dhf" Export
; CHECK-DAG: OpDecorate %[[#S_DHF]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_DHF]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_DHF]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_DHF]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_DHF]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_DHF]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_DHF]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_DHF]] FunctionDenormModeINTEL 16 Preserve
; CHECK-DAG: OpDecorate %[[#S_DHF]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_DHF]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_D:]] "k_d"

; CHECK-DAG: OpExecutionMode %[[#S_D]] DenormPreserve 64
; CHECK-DAG: OpExecutionMode %[[#S_D]] DenormPreserve 32
; CHECK-DAG: OpExecutionMode %[[#S_D]] DenormPreserve 16

; CHECK-DAG: OpExecutionMode %[[#S_D]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_D]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_D]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_D]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_D]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_D]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_D]] LinkageAttributes "k_d" Export
; CHECK-DAG: OpDecorate %[[#S_D]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_D]] FunctionDenormModeINTEL 64 Preserve
; CHECK-DAG: OpDecorate %[[#S_D]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_D]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_D]] FunctionDenormModeINTEL 32 Preserve
; CHECK-DAG: OpDecorate %[[#S_D]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_D]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_D]] FunctionDenormModeINTEL 16 Preserve
; CHECK-DAG: OpDecorate %[[#S_D]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_D]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_IEEE:]] "k_ieee"

; CHECK-DAG: OpExecutionMode %[[#S_IEEE]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_IEEE]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_IEEE]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_IEEE]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_IEEE]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_IEEE]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_IEEE]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_IEEE]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_IEEE]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_IEEE]] LinkageAttributes "k_ieee" Export
; CHECK-DAG: OpDecorate %[[#S_IEEE]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_IEEE]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_IEEE]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_IEEE]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_IEEE]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_IEEE]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_IEEE]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_IEEE]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_IEEE]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_IEEE]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_ALT:]] "k_alt"

; CHECK-DAG: OpExecutionMode %[[#S_ALT]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_ALT]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_ALT]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_ALT]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_ALT]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_ALT]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_ALT]] FloatingPointModeALTINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_ALT]] FloatingPointModeALTINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_ALT]] FloatingPointModeALTINTEL 16

; CHECK-DAG: OpDecorate %[[#S_ALT]] LinkageAttributes "k_alt" Export
; CHECK-DAG: OpDecorate %[[#S_ALT]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_ALT]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_ALT]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_ALT]] FunctionFloatingPointModeINTEL 64 ALT
; CHECK-DAG: OpDecorate %[[#S_ALT]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_ALT]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_ALT]] FunctionFloatingPointModeINTEL 32 ALT
; CHECK-DAG: OpDecorate %[[#S_ALT]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_ALT]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_ALT]] FunctionFloatingPointModeINTEL 16 ALT
; CHECK-DAG: OpEntryPoint Kernel %[[#S_RTP_RTN:]] "k_rtp_rtn"

; CHECK-DAG: OpExecutionMode %[[#S_RTP_RTN]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_RTP_RTN]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_RTP_RTN]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_RTP_RTN]] RoundingModeRTZ 64
; CHECK-DAG: OpExecutionMode %[[#S_RTP_RTN]] RoundingModeRTZ 32
; CHECK-DAG: OpExecutionMode %[[#S_RTP_RTN]] RoundingModeRTZ 16

; CHECK-DAG: OpExecutionMode %[[#S_RTP_RTN]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTP_RTN]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTP_RTN]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] LinkageAttributes "k_rtp_rtn" Export
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] FunctionRoundingModeINTEL 64 RTZ
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] FunctionRoundingModeINTEL 32 RTZ
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] FunctionRoundingModeINTEL 16 RTZ
; CHECK-DAG: OpDecorate %[[#S_RTP_RTN]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_DD_DF_DHF:]] "k_dd_df_dhf"

; CHECK-DAG: OpExecutionMode %[[#S_DD_DF_DHF]] DenormPreserve 64
; CHECK-DAG: OpExecutionMode %[[#S_DD_DF_DHF]] DenormPreserve 32
; CHECK-DAG: OpExecutionMode %[[#S_DD_DF_DHF]] DenormPreserve 16

; CHECK-DAG: OpExecutionMode %[[#S_DD_DF_DHF]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_DD_DF_DHF]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_DD_DF_DHF]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_DD_DF_DHF]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_DD_DF_DHF]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_DD_DF_DHF]] FloatingPointModeIEEEINTEL 16

; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] LinkageAttributes "k_dd_df_dhf" Export
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] FunctionDenormModeINTEL 64 Preserve
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] FunctionDenormModeINTEL 32 Preserve
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] FunctionDenormModeINTEL 16 Preserve
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_DD_DF_DHF]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_RTE_FTZ_IEEE:]] "k_rte_ftz_ieee"

; CHECK-DAG: OpExecutionMode %[[#S_RTE_FTZ_IEEE]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_RTE_FTZ_IEEE]] DenormFlushToZero 32
; CHECK-DAG: OpExecutionMode %[[#S_RTE_FTZ_IEEE]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_RTE_FTZ_IEEE]] RoundingModeRTE 64
; CHECK-DAG: OpExecutionMode %[[#S_RTE_FTZ_IEEE]] RoundingModeRTE 32
; CHECK-DAG: OpExecutionMode %[[#S_RTE_FTZ_IEEE]] RoundingModeRTE 16

; CHECK-DAG: OpExecutionMode %[[#S_RTE_FTZ_IEEE]] FloatingPointModeIEEEINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTE_FTZ_IEEE]] FloatingPointModeIEEEINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTE_FTZ_IEEE]] FloatingPointModeIEEEINTEL 16
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] LinkageAttributes "k_rte_ftz_ieee" Export
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] FunctionRoundingModeINTEL 64 RTE
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] FunctionFloatingPointModeINTEL 64 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] FunctionDenormModeINTEL 32 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] FunctionRoundingModeINTEL 32 RTE
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] FunctionFloatingPointModeINTEL 32 IEEE
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] FunctionRoundingModeINTEL 16 RTE
; CHECK-DAG: OpDecorate %[[#S_RTE_FTZ_IEEE]] FunctionFloatingPointModeINTEL 16 IEEE
; CHECK-DAG: OpEntryPoint Kernel %[[#S_RTP_DF_ALT:]] "k_rtp_df_alt"

; CHECK-DAG: OpExecutionMode %[[#S_RTP_DF_ALT]] DenormPreserve 32
; CHECK-DAG: OpExecutionMode %[[#S_RTP_DF_ALT]] DenormFlushToZero 64
; CHECK-DAG: OpExecutionMode %[[#S_RTP_DF_ALT]] DenormFlushToZero 16

; CHECK-DAG: OpExecutionMode %[[#S_RTP_DF_ALT]] RoundingModeRTPINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTP_DF_ALT]] RoundingModeRTPINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTP_DF_ALT]] RoundingModeRTPINTEL 16

; CHECK-DAG: OpExecutionMode %[[#S_RTP_DF_ALT]] FloatingPointModeALTINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTP_DF_ALT]] FloatingPointModeALTINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTP_DF_ALT]] FloatingPointModeALTINTEL 16

; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] LinkageAttributes "k_rtp_df_alt" Export
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] FunctionDenormModeINTEL 64 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] FunctionRoundingModeINTEL 64 RTP
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] FunctionFloatingPointModeINTEL 64 ALT
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] FunctionDenormModeINTEL 32 Preserve
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] FunctionRoundingModeINTEL 32 RTP
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] FunctionFloatingPointModeINTEL 32 ALT
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] FunctionDenormModeINTEL 16 FlushToZero
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] FunctionRoundingModeINTEL 16 RTP
; CHECK-DAG: OpDecorate %[[#S_RTP_DF_ALT]] FunctionFloatingPointModeINTEL 16 ALT
; CHECK-DAG: OpEntryPoint Kernel %[[#S_RTZ_D_ALT:]] "k_rtz_d_alt"

; CHECK-DAG: OpExecutionMode %[[#S_RTZ_D_ALT]] DenormPreserve 64
; CHECK-DAG: OpExecutionMode %[[#S_RTZ_D_ALT]] DenormPreserve 32
; CHECK-DAG: OpExecutionMode %[[#S_RTZ_D_ALT]] DenormPreserve 16

; CHECK-DAG: OpExecutionMode %[[#S_RTZ_D_ALT]] RoundingModeRTZ 64
; CHECK-DAG: OpExecutionMode %[[#S_RTZ_D_ALT]] RoundingModeRTZ 32
; CHECK-DAG: OpExecutionMode %[[#S_RTZ_D_ALT]] RoundingModeRTZ 16

; CHECK-DAG: OpExecutionMode %[[#S_RTZ_D_ALT]] FloatingPointModeALTINTEL 64
; CHECK-DAG: OpExecutionMode %[[#S_RTZ_D_ALT]] FloatingPointModeALTINTEL 32
; CHECK-DAG: OpExecutionMode %[[#S_RTZ_D_ALT]] FloatingPointModeALTINTEL 16

; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] LinkageAttributes "k_rtz_d_alt" Export
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] VectorComputeFunctionINTEL
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] FunctionDenormModeINTEL 64 Preserve
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] FunctionRoundingModeINTEL 64 RTZ
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] FunctionFloatingPointModeINTEL 64 ALT
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] FunctionDenormModeINTEL 32 Preserve
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] FunctionRoundingModeINTEL 32 RTZ
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] FunctionFloatingPointModeINTEL 32 ALT
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] FunctionDenormModeINTEL 16 Preserve
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] FunctionRoundingModeINTEL 16 RTZ
; CHECK-DAG: OpDecorate %[[#S_RTZ_D_ALT]] FunctionFloatingPointModeINTEL 16 ALT

define spir_kernel void @k_rte(i32 %ibuf, i32 %obuf) #0 {
entry:
ret void
}
define spir_kernel void @k_rtp(i32 %ibuf, i32 %obuf) #1 {
entry:
ret void
}
define spir_kernel void @k_rtn(i32 %ibuf, i32 %obuf) #2 {
entry:
ret void
}
define spir_kernel void @k_rtz(i32 %ibuf, i32 %obuf) #3 {
entry:
ret void
}
define spir_kernel void @k_ftz(i32 %ibuf, i32 %obuf) #0 {
entry:
ret void
}
define spir_kernel void @k_dd(i32 %ibuf, i32 %obuf) #4 {
entry:
ret void
}
define spir_kernel void @k_df(i32 %ibuf, i32 %obuf) #5 {
entry:
ret void
}
define spir_kernel void @k_dhf(i32 %ibuf, i32 %obuf) #6 {
entry:
ret void
}
define spir_kernel void @k_d(i32 %ibuf, i32 %obuf) #7 {
entry:
ret void
}
define spir_kernel void @k_ieee(i32 %ibuf, i32 %obuf) #0 {
entry:
ret void
}
define spir_kernel void @k_alt(i32 %ibuf, i32 %obuf) #8 {
entry:
ret void
}
define spir_kernel void @k_rtp_rtn(i32 %ibuf, i32 %obuf) #3 {
entry:
ret void
}
define spir_kernel void @k_dd_df_dhf(i32 %ibuf, i32 %obuf) #7 {
entry:
ret void
}
define spir_kernel void @k_rte_ftz_ieee(i32 %ibuf, i32 %obuf) #0 {
entry:
ret void
}
define spir_kernel void @k_rtp_df_alt(i32 %ibuf, i32 %obuf) #9 {
entry:
ret void
}
define spir_kernel void @k_rtz_d_alt(i32 %ibuf, i32 %obuf) #10 {
entry:
ret void
}
attributes #0 = { noinline norecurse nounwind readnone "VCFloatControl"="0" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline norecurse nounwind readnone "VCFloatControl"="16" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline norecurse nounwind readnone "VCFloatControl"="32" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline norecurse nounwind readnone "VCFloatControl"="48" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline norecurse nounwind readnone "VCFloatControl"="64" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noinline norecurse nounwind readnone "VCFloatControl"="128" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline norecurse nounwind readnone "VCFloatControl"="1024" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noinline norecurse nounwind readnone "VCFloatControl"="1216" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { noinline norecurse nounwind readnone "VCFloatControl"="1" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { noinline norecurse nounwind readnone "VCFloatControl"="145" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { noinline norecurse nounwind readnone "VCFloatControl"="1265" "VCMain" "VCFunction" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
!llvm.module.flags = !{!0}
!llvm.ident = !{!1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1"}