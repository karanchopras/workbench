class-pool .
*"* class pool for class ZCL_AUNIT

*"* local type definitions
include ZCL_AUNIT=====================ccdef.

*"* class ZCL_AUNIT definition
*"* public declarations
  include ZCL_AUNIT=====================cu.
*"* protected declarations
  include ZCL_AUNIT=====================co.
*"* private declarations
  include ZCL_AUNIT=====================ci.
endclass. "ZCL_AUNIT definition

*"* macro definitions
include ZCL_AUNIT=====================ccmac.
*"* local class implementation
include ZCL_AUNIT=====================ccimp.

*"* test class
include ZCL_AUNIT=====================ccau.

class ZCL_AUNIT implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_AUNIT implementation
