using System;
using System.Interop;

namespace msgpackc_Beef;

public static class msgpackc
{
    typealias char = c_char;
    typealias size_t = uint;
    typealias uint8_t = uint8;
    typealias uint16_t = uint16;
    typealias uint32_t = uint32;
    typealias uint64_t = uint64;
    typealias int8_t = int8;
    typealias int16_t = int16;
    typealias int32_t = int32;
    typealias int64_t = int64;
}