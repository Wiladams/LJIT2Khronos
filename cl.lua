--[[
/*******************************************************************************
 * Copyright (c) 2011 The Khronos Group Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and/or associated documentation files (the
 * "Materials"), to deal in the Materials without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Materials, and to
 * permit persons to whom the Materials are furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Materials.
 *
 * THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
 ******************************************************************************/
--]]

local ffi = require "ffi"
local bit = require "bit"
local lshift = bit.lshift

ffi.cdef[[
typedef struct _cl_platform_id *    cl_platform_id;
typedef struct _cl_device_id *      cl_device_id;
typedef struct _cl_context *        cl_context;
typedef struct _cl_command_queue *  cl_command_queue;
typedef struct _cl_mem *            cl_mem;
typedef struct _cl_program *        cl_program;
typedef struct _cl_kernel *         cl_kernel;
typedef struct _cl_event *          cl_event;
typedef struct _cl_sampler *        cl_sampler;
]]

ffi.cdef[[
typedef cl_uint             cl_bool;                     /* WARNING!  Unlike cl_ types in cl_platform.h, cl_bool is not guaranteed to be the same size as the bool in kernels. */
typedef cl_ulong            cl_bitfield;
typedef cl_bitfield         cl_device_type;
typedef cl_uint             cl_platform_info;
typedef cl_uint             cl_device_info;
typedef cl_bitfield         cl_device_fp_config;
typedef cl_uint             cl_device_mem_cache_type;
typedef cl_uint             cl_device_local_mem_type;
typedef cl_bitfield         cl_device_exec_capabilities;
typedef cl_bitfield         cl_command_queue_properties;
typedef intptr_t            cl_device_partition_property;
typedef cl_bitfield         cl_device_affinity_domain;

typedef intptr_t            cl_context_properties;
typedef cl_uint             cl_context_info;
typedef cl_uint             cl_command_queue_info;
typedef cl_uint             cl_channel_order;
typedef cl_uint             cl_channel_type;
typedef cl_bitfield         cl_mem_flags;
typedef cl_uint             cl_mem_object_type;
typedef cl_uint             cl_mem_info;
typedef cl_bitfield         cl_mem_migration_flags;
typedef cl_uint             cl_image_info;
typedef cl_uint             cl_buffer_create_type;
typedef cl_uint             cl_addressing_mode;
typedef cl_uint             cl_filter_mode;
typedef cl_uint             cl_sampler_info;
typedef cl_bitfield         cl_map_flags;
typedef cl_uint             cl_program_info;
typedef cl_uint             cl_program_build_info;
typedef cl_uint             cl_program_binary_type;
typedef cl_int              cl_build_status;
typedef cl_uint             cl_kernel_info;
typedef cl_uint             cl_kernel_arg_info;
typedef cl_uint             cl_kernel_arg_address_qualifier;
typedef cl_uint             cl_kernel_arg_access_qualifier;
typedef cl_bitfield         cl_kernel_arg_type_qualifier;
typedef cl_uint             cl_kernel_work_group_info;
typedef cl_uint             cl_event_info;
typedef cl_uint             cl_command_type;
typedef cl_uint             cl_profiling_info;


typedef struct _cl_image_format {
    cl_channel_order        image_channel_order;
    cl_channel_type         image_channel_data_type;
} cl_image_format;

typedef struct _cl_image_desc {
    cl_mem_object_type      image_type;
    size_t                  image_width;
    size_t                  image_height;
    size_t                  image_depth;
    size_t                  image_array_size;
    size_t                  image_row_pitch;
    size_t                  image_slice_pitch;
    cl_uint                 num_mip_levels;
    cl_uint                 num_samples;
    cl_mem                  buffer;
} cl_image_desc;

typedef struct _cl_buffer_region {
    size_t                  origin;
    size_t                  size;
} cl_buffer_region;
]]




-- Error Codes
CL_SUCCESS                                  = 0
CL_DEVICE_NOT_FOUND                         = -1
CL_DEVICE_NOT_AVAILABLE                     = -2
CL_COMPILER_NOT_AVAILABLE                   = -3
CL_MEM_OBJECT_ALLOCATION_FAILURE            = -4
CL_OUT_OF_RESOURCES                         = -5
CL_OUT_OF_HOST_MEMORY                       = -6
CL_PROFILING_INFO_NOT_AVAILABLE             = -7
CL_MEM_COPY_OVERLAP                         = -8
CL_IMAGE_FORMAT_MISMATCH                    = -9
CL_IMAGE_FORMAT_NOT_SUPPORTED               = -10
CL_BUILD_PROGRAM_FAILURE                    = -11
CL_MAP_FAILURE                              = -12
CL_MISALIGNED_SUB_BUFFER_OFFSET             = -13
CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST = -14
CL_COMPILE_PROGRAM_FAILURE                  = -15
CL_LINKER_NOT_AVAILABLE                     = -16
CL_LINK_PROGRAM_FAILURE                     = -17
CL_DEVICE_PARTITION_FAILED                  = -18
CL_KERNEL_ARG_INFO_NOT_AVAILABLE            = -19

CL_INVALID_VALUE                            = -30
CL_INVALID_DEVICE_TYPE                      = -31
CL_INVALID_PLATFORM                         = -32
CL_INVALID_DEVICE                           = -33
CL_INVALID_CONTEXT                          = -34
CL_INVALID_QUEUE_PROPERTIES                 = -35
CL_INVALID_COMMAND_QUEUE                    = -36
CL_INVALID_HOST_PTR                         = -37
CL_INVALID_MEM_OBJECT                       = -38
CL_INVALID_IMAGE_FORMAT_DESCRIPTOR          = -39
CL_INVALID_IMAGE_SIZE                       = -40
CL_INVALID_SAMPLER                          = -41
CL_INVALID_BINARY                           = -42
CL_INVALID_BUILD_OPTIONS                    = -43
CL_INVALID_PROGRAM                          = -44
CL_INVALID_PROGRAM_EXECUTABLE               = -45
CL_INVALID_KERNEL_NAME                      = -46
CL_INVALID_KERNEL_DEFINITION                = -47
CL_INVALID_KERNEL                           = -48
CL_INVALID_ARG_INDEX                        = -49
CL_INVALID_ARG_VALUE                        = -50
CL_INVALID_ARG_SIZE                         = -51
CL_INVALID_KERNEL_ARGS                      = -52
CL_INVALID_WORK_DIMENSION                   = -53
CL_INVALID_WORK_GROUP_SIZE                  = -54
CL_INVALID_WORK_ITEM_SIZE                   = -55
CL_INVALID_GLOBAL_OFFSET                    = -56
CL_INVALID_EVENT_WAIT_LIST                  = -57
CL_INVALID_EVENT                            = -58
CL_INVALID_OPERATION                        = -59
CL_INVALID_GL_OBJECT                        = -60
CL_INVALID_BUFFER_SIZE                      = -61
CL_INVALID_MIP_LEVEL                        = -62
CL_INVALID_GLOBAL_WORK_SIZE                 = -63
CL_INVALID_PROPERTY                         = -64
CL_INVALID_IMAGE_DESCRIPTOR                 = -65
CL_INVALID_COMPILER_OPTIONS                 = -66
CL_INVALID_LINKER_OPTIONS                   = -67
CL_INVALID_DEVICE_PARTITION_COUNT           = -68

-- OpenCL Version
CL_VERSION_1_0                              = 1
CL_VERSION_1_1                              = 1
CL_VERSION_1_2                              = 1

-- cl_bool
CL_FALSE                                    = 0
CL_TRUE                                     = 1
CL_BLOCKING                                 = CL_TRUE
CL_NON_BLOCKING                             = CL_FALSE

-- cl_platform_info
CL_PLATFORM_PROFILE                         = 0x0900
CL_PLATFORM_VERSION                         = 0x0901
CL_PLATFORM_NAME                            = 0x0902
CL_PLATFORM_VENDOR                          = 0x0903
CL_PLATFORM_EXTENSIONS                      = 0x0904

-- cl_device_type - bitfield
CL_DEVICE_TYPE_DEFAULT                      = lshift(1, 0)
CL_DEVICE_TYPE_CPU                          = lshift(1, 1)
CL_DEVICE_TYPE_GPU                          = lshift(1, 2)
CL_DEVICE_TYPE_ACCELERATOR                  = lshift(1, 3)
CL_DEVICE_TYPE_CUSTOM                       = lshift(1, 4)
CL_DEVICE_TYPE_ALL                          = 0xFFFFFFFF

-- cl_device_info
CL_DEVICE_TYPE                              = 0x1000
CL_DEVICE_VENDOR_ID                         = 0x1001
CL_DEVICE_MAX_COMPUTE_UNITS                 = 0x1002
CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS          = 0x1003
CL_DEVICE_MAX_WORK_GROUP_SIZE               = 0x1004
CL_DEVICE_MAX_WORK_ITEM_SIZES               = 0x1005
CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR       = 0x1006
CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT      = 0x1007
CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT        = 0x1008
CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG       = 0x1009
CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT      = 0x100A
CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE     = 0x100B
CL_DEVICE_MAX_CLOCK_FREQUENCY               = 0x100C
CL_DEVICE_ADDRESS_BITS                      = 0x100D
CL_DEVICE_MAX_READ_IMAGE_ARGS               = 0x100E
CL_DEVICE_MAX_WRITE_IMAGE_ARGS              = 0x100F
CL_DEVICE_MAX_MEM_ALLOC_SIZE                = 0x1010
CL_DEVICE_IMAGE2D_MAX_WIDTH                 = 0x1011
CL_DEVICE_IMAGE2D_MAX_HEIGHT                = 0x1012
CL_DEVICE_IMAGE3D_MAX_WIDTH                 = 0x1013
CL_DEVICE_IMAGE3D_MAX_HEIGHT                = 0x1014
CL_DEVICE_IMAGE3D_MAX_DEPTH                 = 0x1015
CL_DEVICE_IMAGE_SUPPORT                     = 0x1016
CL_DEVICE_MAX_PARAMETER_SIZE                = 0x1017
CL_DEVICE_MAX_SAMPLERS                      = 0x1018
CL_DEVICE_MEM_BASE_ADDR_ALIGN               = 0x1019
CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE          = 0x101A
CL_DEVICE_SINGLE_FP_CONFIG                  = 0x101B
CL_DEVICE_GLOBAL_MEM_CACHE_TYPE             = 0x101C
CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE         = 0x101D
CL_DEVICE_GLOBAL_MEM_CACHE_SIZE             = 0x101E
CL_DEVICE_GLOBAL_MEM_SIZE                   = 0x101F
CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE          = 0x1020
CL_DEVICE_MAX_CONSTANT_ARGS                 = 0x1021
CL_DEVICE_LOCAL_MEM_TYPE                    = 0x1022
CL_DEVICE_LOCAL_MEM_SIZE                    = 0x1023
CL_DEVICE_ERROR_CORRECTION_SUPPORT          = 0x1024
CL_DEVICE_PROFILING_TIMER_RESOLUTION        = 0x1025
CL_DEVICE_ENDIAN_LITTLE                     = 0x1026
CL_DEVICE_AVAILABLE                         = 0x1027
CL_DEVICE_COMPILER_AVAILABLE                = 0x1028
CL_DEVICE_EXECUTION_CAPABILITIES            = 0x1029
CL_DEVICE_QUEUE_PROPERTIES                  = 0x102A
CL_DEVICE_NAME                              = 0x102B
CL_DEVICE_VENDOR                            = 0x102C
CL_DRIVER_VERSION                           = 0x102D
CL_DEVICE_PROFILE                           = 0x102E
CL_DEVICE_VERSION                           = 0x102F
CL_DEVICE_EXTENSIONS                        = 0x1030
CL_DEVICE_PLATFORM                          = 0x1031
CL_DEVICE_DOUBLE_FP_CONFIG                  = 0x1032
-- = 0x1033 reserved for CL_DEVICE_HALF_FP_CONFIG
CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF       = 0x1034
CL_DEVICE_HOST_UNIFIED_MEMORY               = 0x1035
CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR          = 0x1036
CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT         = 0x1037
CL_DEVICE_NATIVE_VECTOR_WIDTH_INT           = 0x1038
CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG          = 0x1039
CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT         = 0x103A
CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE        = 0x103B
CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF          = 0x103C
CL_DEVICE_OPENCL_C_VERSION                  = 0x103D
CL_DEVICE_LINKER_AVAILABLE                  = 0x103E
CL_DEVICE_BUILT_IN_KERNELS                  = 0x103F
CL_DEVICE_IMAGE_MAX_BUFFER_SIZE             = 0x1040
CL_DEVICE_IMAGE_MAX_ARRAY_SIZE              = 0x1041
CL_DEVICE_PARENT_DEVICE                     = 0x1042
CL_DEVICE_PARTITION_MAX_SUB_DEVICES         = 0x1043
CL_DEVICE_PARTITION_PROPERTIES              = 0x1044
CL_DEVICE_PARTITION_AFFINITY_DOMAIN         = 0x1045
CL_DEVICE_PARTITION_TYPE                    = 0x1046
CL_DEVICE_REFERENCE_COUNT                   = 0x1047
CL_DEVICE_PREFERRED_INTEROP_USER_SYNC       = 0x1048
CL_DEVICE_PRINTF_BUFFER_SIZE                = 0x1049

-- cl_device_fp_config - bitfield
CL_FP_DENORM                                = lshift(1, 0)
CL_FP_INF_NAN                               = lshift(1, 1)
CL_FP_ROUND_TO_NEAREST                      = lshift(1, 2)
CL_FP_ROUND_TO_ZERO                         = lshift(1, 3)
CL_FP_ROUND_TO_INF                          = lshift(1, 4)
CL_FP_FMA                                   = lshift(1, 5)
CL_FP_SOFT_FLOAT                            = lshift(1, 6)
CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT         = lshift(1, 7)

-- cl_device_mem_cache_type
CL_NONE                                     = 0x0
CL_READ_ONLY_CACHE                          = 0x1
CL_READ_WRITE_CACHE                         = 0x2

-- cl_device_local_mem_type
CL_LOCAL                                    = 0x1
CL_GLOBAL                                   = 0x2

-- cl_device_exec_capabilities - bitfield
CL_EXEC_KERNEL                              = lshift(1, 0)
CL_EXEC_NATIVE_KERNEL                       = lshift(1, 1)

-- cl_command_queue_properties - bitfield
CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE      = lshift(1, 0)
CL_QUEUE_PROFILING_ENABLE                   = lshift(1, 1)

-- cl_context_info
CL_CONTEXT_REFERENCE_COUNT                  = 0x1080
CL_CONTEXT_DEVICES                          = 0x1081
CL_CONTEXT_PROPERTIES                       = 0x1082
CL_CONTEXT_NUM_DEVICES                      = 0x1083

-- cl_context_properties
CL_CONTEXT_PLATFORM                         = 0x1084
CL_CONTEXT_INTEROP_USER_SYNC                = 0x1085

-- cl_device_partition_property
CL_DEVICE_PARTITION_EQUALLY                 = 0x1086
CL_DEVICE_PARTITION_BY_COUNTS               = 0x1087
CL_DEVICE_PARTITION_BY_COUNTS_LIST_END      = 0x0
CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN      = 0x1088

-- cl_device_affinity_domain
CL_DEVICE_AFFINITY_DOMAIN_NUMA                     = lshift(1, 0)
CL_DEVICE_AFFINITY_DOMAIN_L4_CACHE                 = lshift(1, 1)
CL_DEVICE_AFFINITY_DOMAIN_L3_CACHE                 = lshift(1, 2)
CL_DEVICE_AFFINITY_DOMAIN_L2_CACHE                 = lshift(1, 3)
CL_DEVICE_AFFINITY_DOMAIN_L1_CACHE                 = lshift(1, 4)
CL_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE       = lshift(1, 5)

-- cl_command_queue_info
CL_QUEUE_CONTEXT                            = 0x1090
CL_QUEUE_DEVICE                             = 0x1091
CL_QUEUE_REFERENCE_COUNT                    = 0x1092
CL_QUEUE_PROPERTIES                         = 0x1093

-- cl_mem_flags - bitfield
CL_MEM_READ_WRITE                           = lshift(1, 0)
CL_MEM_WRITE_ONLY                           = lshift(1, 1)
CL_MEM_READ_ONLY                            = lshift(1, 2)
CL_MEM_USE_HOST_PTR                         = lshift(1, 3)
CL_MEM_ALLOC_HOST_PTR                       = lshift(1, 4)
CL_MEM_COPY_HOST_PTR                        = lshift(1, 5)
-- reserved                                         (1 << 6)
CL_MEM_HOST_WRITE_ONLY                      = lshift(1, 7)
CL_MEM_HOST_READ_ONLY                       = lshift(1, 8)
CL_MEM_HOST_NO_ACCESS                       = lshift(1, 9)

-- cl_mem_migration_flags - bitfield
CL_MIGRATE_MEM_OBJECT_HOST                  = lshift(1, 0)
CL_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED     = lshift(1, 1)

-- cl_channel_order
CL_R                                        = 0x10B0
CL_A                                        = 0x10B1
CL_RG                                       = 0x10B2
CL_RA                                       = 0x10B3
CL_RGB                                      = 0x10B4
CL_RGBA                                     = 0x10B5
CL_BGRA                                     = 0x10B6
CL_ARGB                                     = 0x10B7
CL_INTENSITY                                = 0x10B8
CL_LUMINANCE                                = 0x10B9
CL_Rx                                       = 0x10BA
CL_RGx                                      = 0x10BB
CL_RGBx                                     = 0x10BC

-- cl_channel_type
CL_SNORM_INT8                               = 0x10D0
CL_SNORM_INT16                              = 0x10D1
CL_UNORM_INT8                               = 0x10D2
CL_UNORM_INT16                              = 0x10D3
CL_UNORM_SHORT_565                          = 0x10D4
CL_UNORM_SHORT_555                          = 0x10D5
CL_UNORM_INT_101010                         = 0x10D6
CL_SIGNED_INT8                              = 0x10D7
CL_SIGNED_INT16                             = 0x10D8
CL_SIGNED_INT32                             = 0x10D9
CL_UNSIGNED_INT8                            = 0x10DA
CL_UNSIGNED_INT16                           = 0x10DB
CL_UNSIGNED_INT32                           = 0x10DC
CL_HALF_FLOAT                               = 0x10DD
CL_FLOAT                                    = 0x10DE

-- cl_mem_object_type
CL_MEM_OBJECT_BUFFER                        = 0x10F0
CL_MEM_OBJECT_IMAGE2D                       = 0x10F1
CL_MEM_OBJECT_IMAGE3D                       = 0x10F2
CL_MEM_OBJECT_IMAGE2D_ARRAY                 = 0x10F3
CL_MEM_OBJECT_IMAGE1D                       = 0x10F4
CL_MEM_OBJECT_IMAGE1D_ARRAY                 = 0x10F5
CL_MEM_OBJECT_IMAGE1D_BUFFER                = 0x10F6

-- cl_mem_info
CL_MEM_TYPE                                 = 0x1100
CL_MEM_FLAGS                                = 0x1101
CL_MEM_SIZE                                 = 0x1102
CL_MEM_HOST_PTR                             = 0x1103
CL_MEM_MAP_COUNT                            = 0x1104
CL_MEM_REFERENCE_COUNT                      = 0x1105
CL_MEM_CONTEXT                              = 0x1106
CL_MEM_ASSOCIATED_MEMOBJECT                 = 0x1107
CL_MEM_OFFSET                               = 0x1108

-- cl_image_info
CL_IMAGE_FORMAT                             = 0x1110
CL_IMAGE_ELEMENT_SIZE                       = 0x1111
CL_IMAGE_ROW_PITCH                          = 0x1112
CL_IMAGE_SLICE_PITCH                        = 0x1113
CL_IMAGE_WIDTH                              = 0x1114
CL_IMAGE_HEIGHT                             = 0x1115
CL_IMAGE_DEPTH                              = 0x1116
CL_IMAGE_ARRAY_SIZE                         = 0x1117
CL_IMAGE_BUFFER                             = 0x1118
CL_IMAGE_NUM_MIP_LEVELS                     = 0x1119
CL_IMAGE_NUM_SAMPLES                        = 0x111A

-- cl_addressing_mode
CL_ADDRESS_NONE                             = 0x1130
CL_ADDRESS_CLAMP_TO_EDGE                    = 0x1131
CL_ADDRESS_CLAMP                            = 0x1132
CL_ADDRESS_REPEAT                           = 0x1133
CL_ADDRESS_MIRRORED_REPEAT                  = 0x1134

-- cl_filter_mode
CL_FILTER_NEAREST                           = 0x1140
CL_FILTER_LINEAR                            = 0x1141

-- cl_sampler_info
CL_SAMPLER_REFERENCE_COUNT                  = 0x1150
CL_SAMPLER_CONTEXT                          = 0x1151
CL_SAMPLER_NORMALIZED_COORDS                = 0x1152
CL_SAMPLER_ADDRESSING_MODE                  = 0x1153
CL_SAMPLER_FILTER_MODE                      = 0x1154

-- cl_map_flags - bitfield
CL_MAP_READ                                 = lshift(1, 0)
CL_MAP_WRITE                                = lshift(1, 1)
CL_MAP_WRITE_INVALIDATE_REGION              = lshift(1, 2)

-- cl_program_info
CL_PROGRAM_REFERENCE_COUNT                  = 0x1160
CL_PROGRAM_CONTEXT                          = 0x1161
CL_PROGRAM_NUM_DEVICES                      = 0x1162
CL_PROGRAM_DEVICES                          = 0x1163
CL_PROGRAM_SOURCE                           = 0x1164
CL_PROGRAM_BINARY_SIZES                     = 0x1165
CL_PROGRAM_BINARIES                         = 0x1166
CL_PROGRAM_NUM_KERNELS                      = 0x1167
CL_PROGRAM_KERNEL_NAMES                     = 0x1168

-- cl_program_build_info
CL_PROGRAM_BUILD_STATUS                     = 0x1181
CL_PROGRAM_BUILD_OPTIONS                    = 0x1182
CL_PROGRAM_BUILD_LOG                        = 0x1183
CL_PROGRAM_BINARY_TYPE                      = 0x1184

-- cl_program_binary_type
CL_PROGRAM_BINARY_TYPE_NONE                 = 0x0
CL_PROGRAM_BINARY_TYPE_COMPILED_OBJECT      = 0x1
CL_PROGRAM_BINARY_TYPE_LIBRARY              = 0x2
CL_PROGRAM_BINARY_TYPE_EXECUTABLE           = 0x4

-- cl_build_status
CL_BUILD_SUCCESS                            = 0
CL_BUILD_NONE                               = -1
CL_BUILD_ERROR                              = -2
CL_BUILD_IN_PROGRESS                        = -3

-- cl_kernel_info
CL_KERNEL_FUNCTION_NAME                     = 0x1190
CL_KERNEL_NUM_ARGS                          = 0x1191
CL_KERNEL_REFERENCE_COUNT                   = 0x1192
CL_KERNEL_CONTEXT                           = 0x1193
CL_KERNEL_PROGRAM                           = 0x1194
CL_KERNEL_ATTRIBUTES                        = 0x1195

-- cl_kernel_arg_info
CL_KERNEL_ARG_ADDRESS_QUALIFIER             = 0x1196
CL_KERNEL_ARG_ACCESS_QUALIFIER              = 0x1197
CL_KERNEL_ARG_TYPE_NAME                     = 0x1198
CL_KERNEL_ARG_TYPE_QUALIFIER                = 0x1199
CL_KERNEL_ARG_NAME                          = 0x119A

-- cl_kernel_arg_address_qualifier
CL_KERNEL_ARG_ADDRESS_GLOBAL                = 0x119B
CL_KERNEL_ARG_ADDRESS_LOCAL                 = 0x119C
CL_KERNEL_ARG_ADDRESS_CONSTANT              = 0x119D
CL_KERNEL_ARG_ADDRESS_PRIVATE               = 0x119E

-- cl_kernel_arg_access_qualifier
CL_KERNEL_ARG_ACCESS_READ_ONLY              = 0x11A0
CL_KERNEL_ARG_ACCESS_WRITE_ONLY             = 0x11A1
CL_KERNEL_ARG_ACCESS_READ_WRITE             = 0x11A2
CL_KERNEL_ARG_ACCESS_NONE                   = 0x11A3

-- cl_kernel_arg_type_qualifer
CL_KERNEL_ARG_TYPE_NONE                     = 0
CL_KERNEL_ARG_TYPE_CONST                    = lshift(1, 0)
CL_KERNEL_ARG_TYPE_RESTRICT                 = lshift(1, 1)
CL_KERNEL_ARG_TYPE_VOLATILE                 = lshift(1, 2)

-- cl_kernel_work_group_info
CL_KERNEL_WORK_GROUP_SIZE                   = 0x11B0
CL_KERNEL_COMPILE_WORK_GROUP_SIZE           = 0x11B1
CL_KERNEL_LOCAL_MEM_SIZE                    = 0x11B2
CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = 0x11B3
CL_KERNEL_PRIVATE_MEM_SIZE                  = 0x11B4
CL_KERNEL_GLOBAL_WORK_SIZE                  = 0x11B5

-- cl_event_info
CL_EVENT_COMMAND_QUEUE                      = 0x11D0
CL_EVENT_COMMAND_TYPE                       = 0x11D1
CL_EVENT_REFERENCE_COUNT                    = 0x11D2
CL_EVENT_COMMAND_EXECUTION_STATUS           = 0x11D3
CL_EVENT_CONTEXT                            = 0x11D4

-- cl_command_type
CL_COMMAND_NDRANGE_KERNEL                   = 0x11F0
CL_COMMAND_TASK                             = 0x11F1
CL_COMMAND_NATIVE_KERNEL                    = 0x11F2
CL_COMMAND_READ_BUFFER                      = 0x11F3
CL_COMMAND_WRITE_BUFFER                     = 0x11F4
CL_COMMAND_COPY_BUFFER                      = 0x11F5
CL_COMMAND_READ_IMAGE                       = 0x11F6
CL_COMMAND_WRITE_IMAGE                      = 0x11F7
CL_COMMAND_COPY_IMAGE                       = 0x11F8
CL_COMMAND_COPY_IMAGE_TO_BUFFER             = 0x11F9
CL_COMMAND_COPY_BUFFER_TO_IMAGE             = 0x11FA
CL_COMMAND_MAP_BUFFER                       = 0x11FB
CL_COMMAND_MAP_IMAGE                        = 0x11FC
CL_COMMAND_UNMAP_MEM_OBJECT                 = 0x11FD
CL_COMMAND_MARKER                           = 0x11FE
CL_COMMAND_ACQUIRE_GL_OBJECTS               = 0x11FF
CL_COMMAND_RELEASE_GL_OBJECTS               = 0x1200
CL_COMMAND_READ_BUFFER_RECT                 = 0x1201
CL_COMMAND_WRITE_BUFFER_RECT                = 0x1202
CL_COMMAND_COPY_BUFFER_RECT                 = 0x1203
CL_COMMAND_USER                             = 0x1204
CL_COMMAND_BARRIER                          = 0x1205
CL_COMMAND_MIGRATE_MEM_OBJECTS              = 0x1206
CL_COMMAND_FILL_BUFFER                      = 0x1207
CL_COMMAND_FILL_IMAGE                       = 0x1208

-- command execution status
CL_COMPLETE                                 = 0x0
CL_RUNNING                                  = 0x1
CL_SUBMITTED                                = 0x2
CL_QUEUED                                   = 0x3

-- cl_buffer_create_type
CL_BUFFER_CREATE_TYPE_REGION                = 0x1220

-- cl_profiling_info
CL_PROFILING_COMMAND_QUEUED                 = 0x1280
CL_PROFILING_COMMAND_SUBMIT                 = 0x1281
CL_PROFILING_COMMAND_START                  = 0x1282
CL_PROFILING_COMMAND_END                    = 0x1283

ffi.cdef[[

/* Platform API */
cl_int clGetPlatformIDs(cl_uint, cl_platform_id * , cl_uint *);
//CL_API_SUFFIX__VERSION_1_0;

cl_int clGetPlatformInfo(cl_platform_id   /* platform */,
                  cl_platform_info /* param_name */,
                  size_t           /* param_value_size */,
                  void *           /* param_value */,
                  size_t *         /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;

/* Device APIs */
 cl_int
clGetDeviceIDs(cl_platform_id   /* platform */,
               cl_device_type   /* device_type */,
               cl_uint          /* num_entries */,
               cl_device_id *   /* devices */,
               cl_uint *        /* num_devices */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetDeviceInfo(cl_device_id    /* device */,
                cl_device_info  /* param_name */,
                size_t          /* param_value_size */,
                void *          /* param_value */,
                size_t *        /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;
]]



ffi.cdef[[
cl_int clCreateSubDevices(cl_device_id                         /* in_device */,
                   const cl_device_partition_property * /* properties */,
                   cl_uint                              /* num_devices */,
                   cl_device_id *                       /* out_devices */,
                   cl_uint *                            /* num_devices_ret */);
//CL_API_SUFFIX__VERSION_1_2;

 cl_int
clRetainDevice(cl_device_id /* device */);
//CL_API_SUFFIX__VERSION_1_2;

cl_int clReleaseDevice(cl_device_id /* device */);
//CL_API_SUFFIX__VERSION_1_2;

/* Context APIs  */
//typedef (* pfn_notify)(const char *, const void *, size_t, void *);
]]


ffi.cdef[[

cl_context
clCreateContext(const cl_context_properties * /* properties */,
                cl_uint ,
                const cl_device_id * ,
                void (* pfn_notify)(const char *, const void *, size_t, void *),
                void *user_data,
				cl_int *errcode_ret);
//CL_API_SUFFIX__VERSION_1_0;


cl_context
clCreateContextFromType(const cl_context_properties * /* properties */,
                        cl_device_type          /* device_type */,
                        void (* pfn_notify)(const char *, const void *, size_t, void *),
                        void *                  /* user_data */,
                        cl_int *                /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clRetainContext(cl_context /* context */);
// CL_API_SUFFIX__VERSION_1_0;

 cl_int
clReleaseContext(cl_context /* context */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetContextInfo(cl_context         /* context */,
                 cl_context_info    /* param_name */,
                 size_t             /* param_value_size */,
                 void *             /* param_value */,
                 size_t *           /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;

/* Command Queue APIs */
 cl_command_queue
clCreateCommandQueue(cl_context                     /* context */,
                     cl_device_id                   /* device */,
                     cl_command_queue_properties    /* properties */,
                     cl_int *                       /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clRetainCommandQueue(cl_command_queue /* command_queue */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clReleaseCommandQueue(cl_command_queue /* command_queue */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetCommandQueueInfo(cl_command_queue      /* command_queue */,
                      cl_command_queue_info /* param_name */,
                      size_t                /* param_value_size */,
                      void *                /* param_value */,
                      size_t *              /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;

/* Memory Object APIs */
 cl_mem
clCreateBuffer(cl_context   /* context */,
               cl_mem_flags /* flags */,
               size_t       /* size */,
               void *       /* host_ptr */,
               cl_int *     /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_0;
]]


ffi.cdef[[
 cl_mem
clCreateSubBuffer(cl_mem                   /* buffer */,
                  cl_mem_flags             /* flags */,
                  cl_buffer_create_type    /* buffer_create_type */,
                  const void *             /* buffer_create_info */,
                  cl_int *                 /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_1;
]]

ffi.cdef[[
 cl_mem
clCreateImage(cl_context              /* context */,
              cl_mem_flags            /* flags */,
              const cl_image_format * /* image_format */,
              const cl_image_desc *   /* image_desc */,
              void *                  /* host_ptr */,
              cl_int *                /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_2;
]]

ffi.cdef[[
 cl_int
clRetainMemObject(cl_mem /* memobj */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clReleaseMemObject(cl_mem /* memobj */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetSupportedImageFormats(cl_context           /* context */,
                           cl_mem_flags         /* flags */,
                           cl_mem_object_type   /* image_type */,
                           cl_uint              /* num_entries */,
                           cl_image_format *    /* image_formats */,
                           cl_uint *            /* num_image_formats */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetMemObjectInfo(cl_mem           /* memobj */,
                   cl_mem_info      /* param_name */,
                   size_t           /* param_value_size */,
                   void *           /* param_value */,
                   size_t *         /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetImageInfo(cl_mem           /* image */,
               cl_image_info    /* param_name */,
               size_t           /* param_value_size */,
               void *           /* param_value */,
               size_t *         /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;
]]

ffi.cdef[[
 cl_int
clSetMemObjectDestructorCallback(  cl_mem /* memobj */,
                                    void ( * /*pfn_notify*/)( cl_mem /* memobj */, void* /*user_data*/),
                                    void * /*user_data */ );
//CL_API_SUFFIX__VERSION_1_1;
]]


ffi.cdef[[
/* Sampler APIs */
 cl_sampler
clCreateSampler(cl_context          /* context */,
                cl_bool             /* normalized_coords */,
                cl_addressing_mode  /* addressing_mode */,
                cl_filter_mode      /* filter_mode */,
                cl_int *            /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clRetainSampler(cl_sampler /* sampler */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clReleaseSampler(cl_sampler /* sampler */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetSamplerInfo(cl_sampler         /* sampler */,
                 cl_sampler_info    /* param_name */,
                 size_t             /* param_value_size */,
                 void *             /* param_value */,
                 size_t *           /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;

/* Program Object APIs  */
 cl_program
clCreateProgramWithSource(cl_context        /* context */,
                          cl_uint           /* count */,
                          char **     /* strings */,
                          const size_t *    /* lengths */,
                          cl_int *          /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_program
clCreateProgramWithBinary(cl_context                     /* context */,
                          cl_uint                        /* num_devices */,
                          const cl_device_id *           /* device_list */,
                          const size_t *                 /* lengths */,
                          const unsigned char **         /* binaries */,
                          cl_int *                       /* binary_status */,
                          cl_int *                       /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_0;
]]

ffi.cdef[[
 cl_program
clCreateProgramWithBuiltInKernels(cl_context            /* context */,
                                  cl_uint               /* num_devices */,
                                  const cl_device_id *  /* device_list */,
                                  const char *          /* kernel_names */,
                                  cl_int *              /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_2;
]]

ffi.cdef[[
 cl_int
clRetainProgram(cl_program /* program */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clReleaseProgram(cl_program /* program */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clBuildProgram(cl_program           /* program */,
               cl_uint              /* num_devices */,
               const cl_device_id * /* device_list */,
               const char *         /* options */,
               void ( *  /* pfn_notify */)(cl_program /* program */, void * /* user_data */),
               void *               /* user_data */);
//CL_API_SUFFIX__VERSION_1_0;
]]

ffi.cdef[[
cl_int
clCompileProgram(cl_program           /* program */,
                 cl_uint              /* num_devices */,
                 const cl_device_id * /* device_list */,
                 const char *         /* options */,
                 cl_uint              /* num_input_headers */,
                 const cl_program *   /* input_headers */,
                 const char **        /* header_include_names */,
                 void ( *  /* pfn_notify */)(cl_program /* program */, void * /* user_data */),
                 void *               /* user_data */);
//CL_API_SUFFIX__VERSION_1_2;

cl_program
clLinkProgram(cl_context           /* context */,
              cl_uint              /* num_devices */,
              const cl_device_id * /* device_list */,
              const char *         /* options */,
              cl_uint              /* num_input_programs */,
              const cl_program *   /* input_programs */,
              void ( *  /* pfn_notify */)(cl_program /* program */, void * /* user_data */),
              void *               /* user_data */,
              cl_int *             /* errcode_ret */ );
//CL_API_SUFFIX__VERSION_1_2;


 cl_int
clUnloadPlatformCompiler(cl_platform_id /* platform */);
// CL_API_SUFFIX__VERSION_1_2;
]]


ffi.cdef[[
 cl_int
clGetProgramInfo(cl_program         /* program */,
                 cl_program_info    /* param_name */,
                 size_t             /* param_value_size */,
                 void *             /* param_value */,
                 size_t *           /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetProgramBuildInfo(cl_program            /* program */,
                      cl_device_id          /* device */,
                      cl_program_build_info /* param_name */,
                      size_t                /* param_value_size */,
                      void *                /* param_value */,
                      size_t *              /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;

/* Kernel Object APIs */
 cl_kernel
clCreateKernel(cl_program      /* program */,
               const char *    /* kernel_name */,
               cl_int *        /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clCreateKernelsInProgram(cl_program     /* program */,
                         cl_uint        /* num_kernels */,
                         cl_kernel *    /* kernels */,
                         cl_uint *      /* num_kernels_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clRetainKernel(cl_kernel    /* kernel */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clReleaseKernel(cl_kernel   /* kernel */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clSetKernelArg(cl_kernel    /* kernel */,
               cl_uint      /* arg_index */,
               size_t       /* arg_size */,
               void * /* arg_value */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetKernelInfo(cl_kernel       /* kernel */,
                cl_kernel_info  /* param_name */,
                size_t          /* param_value_size */,
                void *          /* param_value */,
                size_t *        /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;
]]


ffi.cdef[[
 cl_int
clGetKernelArgInfo(cl_kernel       /* kernel */,
                   cl_uint         /* arg_indx */,
                   cl_kernel_arg_info  /* param_name */,
                   size_t          /* param_value_size */,
                   void *          /* param_value */,
                   size_t *        /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_2;
]]


ffi.cdef[[
 cl_int
clGetKernelWorkGroupInfo(cl_kernel                  /* kernel */,
                         cl_device_id               /* device */,
                         cl_kernel_work_group_info  /* param_name */,
                         size_t                     /* param_value_size */,
                         void *                     /* param_value */,
                         size_t *                   /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;

/* Event Object APIs */
 cl_int
clWaitForEvents(cl_uint             /* num_events */,
                const cl_event *    /* event_list */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clGetEventInfo(cl_event         /* event */,
               cl_event_info    /* param_name */,
               size_t           /* param_value_size */,
               void *           /* param_value */,
               size_t *         /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;
]]


ffi.cdef[[
 cl_event
clCreateUserEvent(cl_context    /* context */,
                  cl_int *      /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_1;
]]

ffi.cdef[[
 cl_int
clRetainEvent(cl_event /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clReleaseEvent(cl_event /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clSetUserEventStatus(cl_event   /* event */,
                     cl_int     /* execution_status */);
//CL_API_SUFFIX__VERSION_1_1;

 cl_int
clSetEventCallback( cl_event    /* event */,
                    cl_int      /* command_exec_callback_type */,
                    void ( * /* pfn_notify */)(cl_event, cl_int, void *),
                    void *      /* user_data */);
//CL_API_SUFFIX__VERSION_1_1;

/* Profiling APIs */
 cl_int
clGetEventProfilingInfo(cl_event            /* event */,
                        cl_profiling_info   /* param_name */,
                        size_t              /* param_value_size */,
                        void *              /* param_value */,
                        size_t *            /* param_value_size_ret */);
//CL_API_SUFFIX__VERSION_1_0;

/* Flush and Finish APIs */
 cl_int
clFlush(cl_command_queue /* command_queue */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clFinish(cl_command_queue /* command_queue */);
//CL_API_SUFFIX__VERSION_1_0;

/* Enqueued Commands APIs */
 cl_int
clEnqueueReadBuffer(cl_command_queue    /* command_queue */,
                    cl_mem              /* buffer */,
                    cl_bool             /* blocking_read */,
                    size_t              /* offset */,
                    size_t              /* size */,
                    void *              /* ptr */,
                    cl_uint             /* num_events_in_wait_list */,
                    const cl_event *    /* event_wait_list */,
                    cl_event *          /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueReadBufferRect(cl_command_queue    /* command_queue */,
                        cl_mem              /* buffer */,
                        cl_bool             /* blocking_read */,
                        const size_t *      /* buffer_offset */,
                        const size_t *      /* host_offset */,
                        const size_t *      /* region */,
                        size_t              /* buffer_row_pitch */,
                        size_t              /* buffer_slice_pitch */,
                        size_t              /* host_row_pitch */,
                        size_t              /* host_slice_pitch */,
                        void *              /* ptr */,
                        cl_uint             /* num_events_in_wait_list */,
                        const cl_event *    /* event_wait_list */,
                        cl_event *          /* event */);
//CL_API_SUFFIX__VERSION_1_1;

 cl_int
clEnqueueWriteBuffer(cl_command_queue   /* command_queue */,
                     cl_mem             /* buffer */,
                     cl_bool            /* blocking_write */,
                     size_t             /* offset */,
                     size_t             /* size */,
                     const void *       /* ptr */,
                     cl_uint            /* num_events_in_wait_list */,
                     const cl_event *   /* event_wait_list */,
                     cl_event *         /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueWriteBufferRect(cl_command_queue    /* command_queue */,
                         cl_mem              /* buffer */,
                         cl_bool             /* blocking_write */,
                         const size_t *      /* buffer_offset */,
                         const size_t *      /* host_offset */,
                         const size_t *      /* region */,
                         size_t              /* buffer_row_pitch */,
                         size_t              /* buffer_slice_pitch */,
                         size_t              /* host_row_pitch */,
                         size_t              /* host_slice_pitch */,
                         const void *        /* ptr */,
                         cl_uint             /* num_events_in_wait_list */,
                         const cl_event *    /* event_wait_list */,
                         cl_event *          /* event */);
//CL_API_SUFFIX__VERSION_1_1;

 cl_int
clEnqueueFillBuffer(cl_command_queue   /* command_queue */,
                    cl_mem             /* buffer */,
                    const void *       /* pattern */,
                    size_t             /* pattern_size */,
                    size_t             /* offset */,
                    size_t             /* size */,
                    cl_uint            /* num_events_in_wait_list */,
                    const cl_event *   /* event_wait_list */,
                    cl_event *         /* event */);
//CL_API_SUFFIX__VERSION_1_2;

 cl_int
clEnqueueCopyBuffer(cl_command_queue    /* command_queue */,
                    cl_mem              /* src_buffer */,
                    cl_mem              /* dst_buffer */,
                    size_t              /* src_offset */,
                    size_t              /* dst_offset */,
                    size_t              /* size */,
                    cl_uint             /* num_events_in_wait_list */,
                    const cl_event *    /* event_wait_list */,
                    cl_event *          /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueCopyBufferRect(cl_command_queue    /* command_queue */,
                        cl_mem              /* src_buffer */,
                        cl_mem              /* dst_buffer */,
                        const size_t *      /* src_origin */,
                        const size_t *      /* dst_origin */,
                        const size_t *      /* region */,
                        size_t              /* src_row_pitch */,
                        size_t              /* src_slice_pitch */,
                        size_t              /* dst_row_pitch */,
                        size_t              /* dst_slice_pitch */,
                        cl_uint             /* num_events_in_wait_list */,
                        const cl_event *    /* event_wait_list */,
                        cl_event *          /* event */);
//CL_API_SUFFIX__VERSION_1_1;

 cl_int
clEnqueueReadImage(cl_command_queue     /* command_queue */,
                   cl_mem               /* image */,
                   cl_bool              /* blocking_read */,
                   const size_t *       /* origin[3] */,
                   const size_t *       /* region[3] */,
                   size_t               /* row_pitch */,
                   size_t               /* slice_pitch */,
                   void *               /* ptr */,
                   cl_uint              /* num_events_in_wait_list */,
                   const cl_event *     /* event_wait_list */,
                   cl_event *           /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueWriteImage(cl_command_queue    /* command_queue */,
                    cl_mem              /* image */,
                    cl_bool             /* blocking_write */,
                    const size_t *      /* origin[3] */,
                    const size_t *      /* region[3] */,
                    size_t              /* input_row_pitch */,
                    size_t              /* input_slice_pitch */,
                    const void *        /* ptr */,
                    cl_uint             /* num_events_in_wait_list */,
                    const cl_event *    /* event_wait_list */,
                    cl_event *          /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueFillImage(cl_command_queue   /* command_queue */,
                   cl_mem             /* image */,
                   const void *       /* fill_color */,
                   const size_t *     /* origin[3] */,
                   const size_t *     /* region[3] */,
                   cl_uint            /* num_events_in_wait_list */,
                   const cl_event *   /* event_wait_list */,
                   cl_event *         /* event */);
//CL_API_SUFFIX__VERSION_1_2;

 cl_int
clEnqueueCopyImage(cl_command_queue     /* command_queue */,
                   cl_mem               /* src_image */,
                   cl_mem               /* dst_image */,
                   const size_t *       /* src_origin[3] */,
                   const size_t *       /* dst_origin[3] */,
                   const size_t *       /* region[3] */,
                   cl_uint              /* num_events_in_wait_list */,
                   const cl_event *     /* event_wait_list */,
                   cl_event *           /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueCopyImageToBuffer(cl_command_queue /* command_queue */,
                           cl_mem           /* src_image */,
                           cl_mem           /* dst_buffer */,
                           const size_t *   /* src_origin[3] */,
                           const size_t *   /* region[3] */,
                           size_t           /* dst_offset */,
                           cl_uint          /* num_events_in_wait_list */,
                           const cl_event * /* event_wait_list */,
                           cl_event *       /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueCopyBufferToImage(cl_command_queue /* command_queue */,
                           cl_mem           /* src_buffer */,
                           cl_mem           /* dst_image */,
                           size_t           /* src_offset */,
                           const size_t *   /* dst_origin[3] */,
                           const size_t *   /* region[3] */,
                           cl_uint          /* num_events_in_wait_list */,
                           const cl_event * /* event_wait_list */,
                           cl_event *       /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 void *
clEnqueueMapBuffer(cl_command_queue /* command_queue */,
                   cl_mem           /* buffer */,
                   cl_bool          /* blocking_map */,
                   cl_map_flags     /* map_flags */,
                   size_t           /* offset */,
                   size_t           /* size */,
                   cl_uint          /* num_events_in_wait_list */,
                   const cl_event * /* event_wait_list */,
                   cl_event *       /* event */,
                   cl_int *         /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 void *
clEnqueueMapImage(cl_command_queue  /* command_queue */,
                  cl_mem            /* image */,
                  cl_bool           /* blocking_map */,
                  cl_map_flags      /* map_flags */,
                  const size_t *    /* origin[3] */,
                  const size_t *    /* region[3] */,
                  size_t *          /* image_row_pitch */,
                  size_t *          /* image_slice_pitch */,
                  cl_uint           /* num_events_in_wait_list */,
                  const cl_event *  /* event_wait_list */,
                  cl_event *        /* event */,
                  cl_int *          /* errcode_ret */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueUnmapMemObject(cl_command_queue /* command_queue */,
                        cl_mem           /* memobj */,
                        void *           /* mapped_ptr */,
                        cl_uint          /* num_events_in_wait_list */,
                        const cl_event *  /* event_wait_list */,
                        cl_event *        /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueMigrateMemObjects(cl_command_queue       /* command_queue */,
                           cl_uint                /* num_mem_objects */,
                           const cl_mem *         /* mem_objects */,
                           cl_mem_migration_flags /* flags */,
                           cl_uint                /* num_events_in_wait_list */,
                           const cl_event *       /* event_wait_list */,
                           cl_event *             /* event */);
//CL_API_SUFFIX__VERSION_1_2;

 cl_int
clEnqueueNDRangeKernel(cl_command_queue /* command_queue */,
                       cl_kernel        /* kernel */,
                       cl_uint          /* work_dim */,
                       const size_t *   /* global_work_offset */,
                       const size_t *   /* global_work_size */,
                       const size_t *   /* local_work_size */,
                       cl_uint          /* num_events_in_wait_list */,
                       const cl_event * /* event_wait_list */,
                       cl_event *       /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueTask(cl_command_queue  /* command_queue */,
              cl_kernel         /* kernel */,
              cl_uint           /* num_events_in_wait_list */,
              const cl_event *  /* event_wait_list */,
              cl_event *        /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueNativeKernel(cl_command_queue  /* command_queue */,
					  void ( * /*user_func*/)(void *),
                      void *            /* args */,
                      size_t            /* cb_args */,
                      cl_uint           /* num_mem_objects */,
                      const cl_mem *    /* mem_list */,
                      const void **     /* args_mem_loc */,
                      cl_uint           /* num_events_in_wait_list */,
                      const cl_event *  /* event_wait_list */,
                      cl_event *        /* event */);
//CL_API_SUFFIX__VERSION_1_0;

 cl_int
clEnqueueMarkerWithWaitList(cl_command_queue /* command_queue */,
                            cl_uint           /* num_events_in_wait_list */,
                            const cl_event *  /* event_wait_list */,
                            cl_event *        /* event */);
//CL_API_SUFFIX__VERSION_1_2;

 cl_int
clEnqueueBarrierWithWaitList(cl_command_queue /* command_queue */,
                             cl_uint           /* num_events_in_wait_list */,
                             const cl_event *  /* event_wait_list */,
                             cl_event *        /* event */);
//CL_API_SUFFIX__VERSION_1_2;

 cl_int
clSetPrintfCallback(cl_context          /* context */,
                    void ( * /* pfn_notify */)(cl_context /* program */,
                                                          cl_uint /*printf_data_len */,
                                                          char * /* printf_data_ptr */,
                                                          void * /* user_data */),
                    void *              /* user_data */);
//CL_API_SUFFIX__VERSION_1_2;



/* Extension function access
 *
 * Returns the extension function address for the given function name,
 * or NULL if a valid function can not be found.  The client must
 * check to make sure the address is not NULL, before using or
 * calling the returned function address.
 */
 void *
clGetExtensionFunctionAddressForPlatform(cl_platform_id /* platform */,
                                         const char *   /* func_name */);
//CL_API_SUFFIX__VERSION_1_2;

]]

--[[
#ifdef CL_USE_DEPRECATED_OPENCL_1_0_APIS
#warning CL_USE_DEPRECATED_OPENCL_1_0_APIS is defined. These APIs are unsupported and untested in OpenCL 1.1!
    /*
     *  WARNING:
     *     This API introduces mutable state into the OpenCL implementation. It has been REMOVED
     *  to better facilitate thread safety.  The 1.0 API is not thread safe. It is not tested by the
     *  OpenCL 1.1 conformance test, and consequently may not work or may not work dependably.
     *  It is likely to be non-performant. Use of this API is not advised. Use at your own risk.
     *
     *  Software developers previously relying on this API are instructed to set the command queue
     *  properties when creating the queue, instead.
     */
     cl_int
    clSetCommandQueueProperty(cl_command_queue              /* command_queue */,
                              cl_command_queue_properties   /* properties */,
                              cl_bool                        /* enable */,
                              cl_command_queue_properties * /* old_properties */) CL_EXT_SUFFIX__VERSION_1_0_DEPRECATED;
#endif /* CL_USE_DEPRECATED_OPENCL_1_0_APIS */
--]]

--[[
#ifdef CL_USE_DEPRECATED_OPENCL_1_1_APIS
     cl_mem
    clCreateImage2D(cl_context              /* context */,
                    cl_mem_flags            /* flags */,
                    const cl_image_format * /* image_format */,
                    size_t                  /* image_width */,
                    size_t                  /* image_height */,
                    size_t                  /* image_row_pitch */,
                    void *                  /* host_ptr */,
                    cl_int *                /* errcode_ret */) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

     cl_mem
    clCreateImage3D(cl_context              /* context */,
                    cl_mem_flags            /* flags */,
                    const cl_image_format * /* image_format */,
                    size_t                  /* image_width */,
                    size_t                  /* image_height */,
                    size_t                  /* image_depth */,
                    size_t                  /* image_row_pitch */,
                    size_t                  /* image_slice_pitch */,
                    void *                  /* host_ptr */,
                    cl_int *                /* errcode_ret */) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

     cl_int
    clEnqueueMarker(cl_command_queue    /* command_queue */,
                    cl_event *          /* event */) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

     cl_int
    clEnqueueWaitForEvents(cl_command_queue /* command_queue */,
                           cl_uint          /* num_events */,
                           const cl_event * /* event_list */) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

     cl_int
    clEnqueueBarrier(cl_command_queue /* command_queue */) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

     cl_int
    clUnloadCompiler(void) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

     void *
    clGetExtensionFunctionAddress(const char * /* func_name */) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;
#endif /* CL_USE_DEPRECATED_OPENCL_1_2_APIS */
--]]
