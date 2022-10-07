class-pool .
*"* class pool for class ZCL_PROC_TEST

*"* local type definitions
include ZCL_PROC_TEST=================ccdef.

*"* class ZCL_PROC_TEST definition
*"* public declarations
  include ZCL_PROC_TEST=================cu.
*"* protected declarations
  include ZCL_PROC_TEST=================co.
*"* private declarations
  include ZCL_PROC_TEST=================ci.
endclass. "ZCL_PROC_TEST definition

*"* macro definitions
include ZCL_PROC_TEST=================ccmac.
*"* local class implementation
include ZCL_PROC_TEST=================ccimp.

*"* test class
include ZCL_PROC_TEST=================ccau.

class ZCL_PROC_TEST implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_PROC_TEST implementation
