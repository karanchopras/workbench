class-pool .
*"* class pool for class ZCL_PROC_TEST1

*"* local type definitions
include ZCL_PROC_TEST1================ccdef.

*"* class ZCL_PROC_TEST1 definition
*"* public declarations
  include ZCL_PROC_TEST1================cu.
*"* protected declarations
  include ZCL_PROC_TEST1================co.
*"* private declarations
  include ZCL_PROC_TEST1================ci.
endclass. "ZCL_PROC_TEST1 definition

*"* macro definitions
include ZCL_PROC_TEST1================ccmac.
*"* local class implementation
include ZCL_PROC_TEST1================ccimp.

*"* test class
include ZCL_PROC_TEST1================ccau.

class ZCL_PROC_TEST1 implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_PROC_TEST1 implementation
