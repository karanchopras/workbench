class-pool .
*"* class pool for class ZBP_I_PROD_HEAD

*"* local type definitions
include ZBP_I_PROD_HEAD===============ccdef.

*"* class ZBP_I_PROD_HEAD definition
*"* public declarations
  include ZBP_I_PROD_HEAD===============cu.
*"* protected declarations
  include ZBP_I_PROD_HEAD===============co.
*"* private declarations
  include ZBP_I_PROD_HEAD===============ci.
endclass. "ZBP_I_PROD_HEAD definition

*"* macro definitions
include ZBP_I_PROD_HEAD===============ccmac.
*"* local class implementation
include ZBP_I_PROD_HEAD===============ccimp.

*"* test class
include ZBP_I_PROD_HEAD===============ccau.

class ZBP_I_PROD_HEAD implementation.
*"* method's implementations
  include methods.
endclass. "ZBP_I_PROD_HEAD implementation
