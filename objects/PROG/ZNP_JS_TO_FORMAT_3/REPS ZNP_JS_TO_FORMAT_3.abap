*&---------------------------------------------------------------------*
*& Report ZNP_JS_TO_FORMAT_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znp_js_to_format_3.


DATA: js_processor TYPE REF TO cl_java_script,
      js_source    TYPE string,
      return_value TYPE string.
* New comment v2
* Dynamic Expression
DATA: v_original   TYPE string,
      v_expression TYPE string,
      v_output     TYPE string  .

*PARAMETERS: p_input TYPE c LENGTH 13 OBLIGATORY DEFAULT '7154817480558'.

START-OF-SELECTION .

*  IF strlen( p_input ) < 13.
*    MESSAGE 'Input should be 13 characters' TYPE 'S'.
*    LEAVE LIST-PROCESSING.
*  ENDIF.

  v_original = 'BGsy2y_CoojoP8G8BkD_EoBvHUj6BoB_EwCjDgFvCsEToGA7B0F7BwHnBkIT8GAkIUsJ8B4I8BoGwCoGkDoG4D0F4DsEsEsE0FgF8G0FsEsE4D0F4D8GkD0FkD8GgKoV4I0UsEsJ4DwH4D8G4DoG'.
* JS Object
  js_processor = cl_java_script=>create( ).

  DATA: v_org_str TYPE string.
  DATA: v_exp_str TYPE string.
  v_org_str = 'var V_INPUT = ' && '"' && v_original && '"' && ';'.

*  CONCATENATE 'var V_INPUT = ' '''"'v_original'"'';' INTO v_org_str.

* JS Source
  CONCATENATE
  v_org_str
  'var coordinate;   '
  " Test conflict -> 1
*'const DEFAULT_PRECISION = 5;'
'const ENCODING_TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";'
'const DECODING_TABLE = ['
 '   62, -1, -1, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1,'
  '  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,'
   ' 22, 23, 24, 25, -1, -1, -1, -1, 63, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,'
    '36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51'
'];'
'const FORMAT_VERSION = 1; '
'const ABSENT = 0;'
'const LEVEL = 1;'
'const ALTITUDE = 2;'
'const ELEVATION = 3;'
'// Reserved values 4 and 5 should not be selectable'
'const CUSTOM1 = 6;'
'const CUSTOM2 = 7;'
'const Num = typeof BigInt !== "undefined" ? BigInt : Number;'
'function decode(encoded) {'
 '   const decoder = decodeUnsignedValues(encoded);'
 '  const header = decodeHeader(decoder[0], decoder[1]);'
*'   const factorDegree  = 10 ** header.precision;'
'   const factorDegree  = Math.pow(10, header.precision);'
'   const factorZ       = Math.pow(10, header.thirdDimPrecision);'
*'   const factorZ       = 10' '**' 'header.thirdDimPrecision;'
'   const  thirdDim  = header.thirdDimPrecision;'
*v_org_str
'    lastLat = 0;'
 '    lastLng = 0;'
  '  lastZ = 0;'
   ' const res = [];'

'   i = 2;'
 '   for (;i < decoder.length;) {'
  '      const deltaLat = toSigned(decoder[i]) / factorDegree;'
   '     const deltaLng = toSigned(decoder[i + 1]) / factorDegree;'
    '    lastLat += deltaLat;'
     '   lastLng += deltaLng;'

'        if (thirdDim) {'
 '           const deltaZ = toSigned(decoder[i + 2]) / factorZ;'
  '          lastZ += deltaZ;'
   '         res.push([lastLat, lastLng, lastZ]);'
    '        i += 3;'
     '   } else {'
      '      res.push([lastLat, lastLng]);'
       '     i += 2;'
     '  coordinate = res;'
  '      }'
'    }'

'    if (i !== decoder.length) {'
* '       throw new Error(' 'Invalid encoding. Premature ending reached' ');'
 '   }'

'    return {'    "46
  '      polyline: (res),'
 '   };'
'}'

'function decodeChar(char1) {'
  '  const charCode = char1.charCodeAt(0);'
  '  return DECODING_TABLE[charCode - 45];'
'}'

'function decodeUnsignedValues(encoded) {'
'     result = Num(0);'
 '   shift = Num(0);'
  '  const resList = [];'    "57***************************************************************

*'    encoded.split('''').forEach((char1) => {'
' for ( var key = 0, len = encoded.split('''').length; key < len; key++) {'
' const char1 = encoded.charAt(key);'
 '       const value = Num(decodeChar(char1));'
  '      result |= (value & Num(0x1F)) << shift;'
   '     if ((value & Num(0x20)) === Num(0)) {'
    '        resList.push(result);'
    '        result = Num(0);'
    '        shift = Num(0);'
    '    } else {'
     '       shift += Num(5);'
'        }'
'        }'
*'    });'
*'   }));'

 '   if (shift > 0) {'
* '       throw new Error('Invalid encoding');'
 '   }'

 '   return resList;'
 ' }'

'function decodeHeader(version, encodedHeader) {'
'    if (+version.toString() !== FORMAT_VERSION) {'
*'        throw new Error('Invalid format version');'
'    }'
'    const headerNumber = +encodedHeader.toString();'
 '   const precision = headerNumber & 15;'
 '   const thirdDim = (headerNumber >> 4) & 7;'
 '   const thirdDimPrecision = (headerNumber >> 7) & 15;'
* '   return { precision, thirdDim, thirdDimPrecision };'
 'return { precision : headerNumber, thirdDim : headerNumber };'  " 80*************************
'}'

'function toSigned(val) {'
 '   // Decode the sign from an unsigned value'
 '   res = val;'
 '   if (res & Num(1)) {'
 '       res = ~res;'
 '   }'
 '   res >>= Num(1);'
 '   return +res.toString();'
'}'
'decode(V_INPUT);'
'coordinate;'
      INTO js_source SEPARATED BY cl_abap_char_utilities=>cr_lf.

* return after evaluation
  return_value = js_processor->evaluate( js_source ).

* Error
  IF js_processor->last_condition_code IS NOT INITIAL.
    WRITE: /'Error message', js_processor->last_error_message,
           /'Error Code', js_processor->last_condition_code.
* Result
  ELSE.
*    WRITE: /'Input ', p_input.
    WRITE: /'Output', return_value.
    SKIP 2.
    WRITE: /'Expression', v_expression.
  ENDIF.

*'function encode({ precision = DEFAULT_PRECISION, thirdDim = ABSENT, thirdDimPrecision = 0, polyline }) {'
**  '  // Encode a sequence of lat,lng or lat,lng(,{third_dim}). Note that values should be of type BigNumber'
**  '  //   `precision`: how many decimal digits of precision to store the latitude and longitude.'
** '   //   `third_dim`: type of the third dimension if present in the input.'
** '   //   `third_dim_precision`: how many decimal digits of precision to store the third dimension.'
*
* '   const multiplierDegree =  Math.pow(10, precision);'
** '   const multiplierDegree = 10 ** precision;'
** '   const multiplierZ = 10 ** thirdDimPrecision;'
* '   const multiplierZ =  Math.pow(10, thirdDimPrecision);'
* '   const encodedHeaderList = encodeHeader(precision, thirdDim, thirdDimPrecision);'
*  '  const encodedCoords = [];'
*
* '   let lastLat = Num(0);'
* '   let lastLng = Num(0);'
* '   let lastZ = Num(0);'
* '   polyline.forEach((location) => {'
* '      const lat = Num(Math.round(location[0] * multiplierDegree));'
*  '     encodedCoords.push(encodeScaledValue(lat - lastLat));'
*  '     lastLat = lat;'
*
*  '     const lng = Num(Math.round(location[1] * multiplierDegree));'
*  '     encodedCoords.push(encodeScaledValue(lng - lastLng));'
*  '     lastLng = lng;'
*
*  '     if (thirdDim) {'
*  '         const z = Num(Math.round(location[2] * multiplierZ));'
*  '         encodedCoords.push(encodeScaledValue(z - lastZ));'
*  '         lastZ = z;'
* '      }'
* '   });'
*
* '   return [...encodedHeaderList, ...encodedCoords].join('');'
*'}'
*
*'function encodeHeader(precision, thirdDim, thirdDimPrecision) {'
*  '  // Encode the `precision`, `third_dim` and `third_dim_precision` into one encoded char'
* '   if (precision < 0 || precision > 15) {'
**  '      throw new Error('precision out of range. Should be between 0 and 15');'
*  '  }'
* '   if (thirdDimPrecision < 0 || thirdDimPrecision > 15) {'
** '       throw new Error('thirdDimPrecision out of range. Should be between 0 and 15');'
* '   }'
* '   if (thirdDim < 0 || thirdDim > 7 || thirdDim === 4 || thirdDim === 5) {'
** '       throw new Error('thirdDim should be between 0, 1, 2, 3, 6 or 7');'
* '   }'
*
* '   const res = (thirdDimPrecision << 7) | (thirdDim << 4) | precision;'
* '   return encodeUnsignedNumber(FORMAT_VERSION) + encodeUnsignedNumber(res);'
*'}'
*
*'function encodeUnsignedNumber(val) {'
* '   // Uses variable integer encoding to encode an unsigned integer. Returns the encoded string.'
* '   let res = '';'
*  '  let numVal = Num(val);'
*  '  while (numVal > 0x1F) {'
*  '      const pos = (numVal & Num(0x1F)) | Num(0x20);'
*  '      res += ENCODING_TABLE[pos];'
*  '      numVal >>= Num(5);'
*  '  }'
*  '  return res + ENCODING_TABLE[numVal];'
*'}'
*
*'function encodeScaledValue(value) {'
*'    // Transform a integer `value` into a variable length sequence of characters.'
* '   //   `appender` is a callable where the produced chars will land to'
* '   let numVal = Num(value);'
* '   const negative = numVal < 0;'
* '   numVal <<= Num(1);'
*  '  if (negative) {'
*  '      numVal = ~numVal;'
*  '  }'
*
*  '  return encodeUnsignedNumber(numVal);'
*'}'
*


*'module.exports = {'
* '   encode,'
* '   decode,'
* '   ABSENT,'
* '   LEVEL,'
* '   ALTITUDE,'
* '   ELEVATION,'
*'};'