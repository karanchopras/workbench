class-pool .
*"* class pool for class ZBP_I_CYCLE_HEAD

*"* local type definitions
include ZBP_I_CYCLE_HEAD==============ccdef.

*"* class ZBP_I_CYCLE_HEAD definition
*"* public declarations
  include ZBP_I_CYCLE_HEAD==============cu.
*"* protected declarations
  include ZBP_I_CYCLE_HEAD==============co.
*"* private declarations
  include ZBP_I_CYCLE_HEAD==============ci.
endclass. "ZBP_I_CYCLE_HEAD definition

*"* macro definitions
include ZBP_I_CYCLE_HEAD==============ccmac.
*"* local class implementation
include ZBP_I_CYCLE_HEAD==============ccimp.

*"* test class
include ZBP_I_CYCLE_HEAD==============ccau.

class ZBP_I_CYCLE_HEAD implementation.
*"* method's implementations
  include methods.
endclass. "ZBP_I_CYCLE_HEAD implementation
