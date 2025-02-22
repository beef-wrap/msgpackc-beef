/*
* MessagePack for C packing routine
*
* Copyright (C) 2008-2009 FURUHASHI Sadayuki
*
*    Distributed under the Boost Software License, Version 1.0.
*    (See accompanying file LICENSE_1_0.txt or copy at
*    http://www.boost.org/LICENSE_1_0.txt)
*/

using System;
using System.Interop;

namespace msgpackc_Beef;

extension msgpackc
{
	/**
	* @defgroup msgpack_buffer Buffers
	* @ingroup msgpack
	* @{
	* @}
	*/

	/**
	* @defgroup msgpack_pack Serializer
	* @ingroup msgpack
	* @{
	*/

	public function int msgpack_packer_write(void* data, char8* buf, uint32 len);

	public struct msgpack_packer
	{
		public void* data;
		public msgpack_packer_write callback;
	}

	//[CLink] public static extern void msgpack_packer_init(msgpack_packer* pk, void* data, msgpack_packer_write callback);

	[CLink] public static extern msgpack_packer* msgpack_packer_new(void* data, msgpack_packer_write callback);
	[CLink] public static extern void msgpack_packer_free(msgpack_packer* pk);

	[CLink] public static extern int msgpack_pack_char(msgpack_packer* pk, char8 d);

	[CLink] public static extern int msgpack_pack_signed_char(msgpack_packer* pk, char8 d);
	[CLink] public static extern int msgpack_pack_short(msgpack_packer* pk, c_short d);
	[CLink] public static extern int msgpack_pack_int(msgpack_packer* pk, int d);
	[CLink] public static extern int msgpack_pack_long(msgpack_packer* pk, c_long d);
	[CLink] public static extern int msgpack_pack_long_long(msgpack_packer* pk, c_longlong d);
	[CLink] public static extern int msgpack_pack_unsigned_char(msgpack_packer* pk, c_uchar d);
	[CLink] public static extern int msgpack_pack_unsigned_short(msgpack_packer* pk, c_ushort d);
	[CLink] public static extern int msgpack_pack_unsigned_int(msgpack_packer* pk, c_int d);
	[CLink] public static extern int msgpack_pack_unsigned_long(msgpack_packer* pk, c_ulong d);
	[CLink] public static extern int msgpack_pack_unsigned_long_long(msgpack_packer* pk, c_ulonglong d);

	[CLink] public static extern int msgpack_pack_uint8(msgpack_packer* pk, uint8 d);
	[CLink] public static extern int msgpack_pack_uint16(msgpack_packer* pk, uint16 d);
	[CLink] public static extern int msgpack_pack_uint32(msgpack_packer* pk, uint32 d);
	[CLink] public static extern int msgpack_pack_uint64(msgpack_packer* pk, uint64 d);
	[CLink] public static extern int msgpack_pack_int8(msgpack_packer* pk, int8 d);
	[CLink] public static extern int msgpack_pack_int16(msgpack_packer* pk, int16 d);
	[CLink] public static extern int msgpack_pack_int32(msgpack_packer* pk, int32 d);
	[CLink] public static extern int msgpack_pack_int64(msgpack_packer* pk, int64 d);

	[CLink] public static extern int msgpack_pack_fix_uint8(msgpack_packer* pk, uint8 d);
	[CLink] public static extern int msgpack_pack_fix_uint16(msgpack_packer* pk, uint16 d);
	[CLink] public static extern int msgpack_pack_fix_uint32(msgpack_packer* pk, uint32 d);
	[CLink] public static extern int msgpack_pack_fix_uint64(msgpack_packer* pk, uint64 d);
	[CLink] public static extern int msgpack_pack_fix_int8(msgpack_packer* pk, int8 d);
	[CLink] public static extern int msgpack_pack_fix_int16(msgpack_packer* pk, int16 d);
	[CLink] public static extern int msgpack_pack_fix_int32(msgpack_packer* pk, int32 d);
	[CLink] public static extern int msgpack_pack_fix_int64(msgpack_packer* pk, int64 d);

	[CLink] public static extern int msgpack_pack_float(msgpack_packer* pk, float d);
	[CLink] public static extern int msgpack_pack_double(msgpack_packer* pk, double d);

	[CLink] public static extern int msgpack_pack_nil(msgpack_packer* pk);
	[CLink] public static extern int msgpack_pack_true(msgpack_packer* pk);
	[CLink] public static extern int msgpack_pack_false(msgpack_packer* pk);

	[CLink] public static extern int msgpack_pack_array(msgpack_packer* pk, uint32 n);

	[CLink] public static extern int msgpack_pack_map(msgpack_packer* pk, uint32 n);

	[CLink] public static extern int msgpack_pack_str(msgpack_packer* pk, uint32 l);
	[CLink] public static extern int msgpack_pack_str_body(msgpack_packer* pk, void* b, uint32 l);
	[CLink] public static extern int msgpack_pack_str_with_body(msgpack_packer* pk, void* b, uint32 l);

	[CLink] public static extern int msgpack_pack_v4raw(msgpack_packer* pk, uint32 l);
	[CLink] public static extern int msgpack_pack_v4raw_body(msgpack_packer* pk, void* b, uint32 l);

	[CLink] public static extern int msgpack_pack_bin(msgpack_packer* pk, uint32 l);
	[CLink] public static extern int msgpack_pack_bin_body(msgpack_packer* pk, void* b, uint32 l);
	[CLink] public static extern int msgpack_pack_bin_with_body(msgpack_packer* pk, void* b, uint32 l);

	[CLink] public static extern int msgpack_pack_ext(msgpack_packer* pk, uint32 l, int8 type);
	[CLink] public static extern int msgpack_pack_ext_body(msgpack_packer* pk, void* b, uint32 l);
	[CLink] public static extern int msgpack_pack_ext_with_body(msgpack_packer* pk, void* b, uint32 l, int8 type);

	struct msgpack_timestamp;

	[CLink] public static extern int msgpack_pack_timestamp(msgpack_packer* pk, msgpack_timestamp* d);

	[CLink] public static extern int msgpack_pack_object(msgpack_packer* pk, msgpack_object d);

	// #define msgpack_pack_inline_func(name) \
	//     inline int msgpack_pack ## name

	// #define msgpack_pack_inline_func_cint(name) \
	//     inline int msgpack_pack ## name

	// #define msgpack_pack_inline_func_fixint(name) \
	//     inline int msgpack_pack_fix ## name

	// #define msgpack_pack_user msgpack_packer*

	// #define msgpack_pack_append_buffer(user, buf, len) \
	//     return (*(user)->callback)((user)->data, (char8*)buf, len)


	public static void msgpack_packer_init(msgpack_packer* pk, void* data, msgpack_packer_write callback)
	{
		pk.data = data;
		pk.callback = callback;
	}

	// inline msgpack_packer* msgpack_packer_new(void* data, msgpack_packer_write callback)
	// {
	//     msgpack_packer* pk = (msgpack_packer*)calloc(1, sizeof(msgpack_packer));
	//     if(!pk) { return NULL; }
	//     msgpack_packer_init(pk, data, callback);
	//     return pk;
	// }

	// inline void msgpack_packer_free(msgpack_packer* pk)
	// {
	//     free(pk);
	// }

	// inline int msgpack_pack_str_with_body(msgpack_packer* pk, void* b, uint32 l)
	// {
	//     int ret = msgpack_pack_str(pk, l);
	//     if (ret != 0) { return ret; }
	//     return msgpack_pack_str_body(pk, b, l);
	// }

	// inline int msgpack_pack_bin_with_body(msgpack_packer* pk, void* b, uint32 l)
	// {
	//     int ret = msgpack_pack_bin(pk, l);
	//     if (ret != 0) { return ret; }
	//     return msgpack_pack_bin_body(pk, b, l);
	// }

	// inline int msgpack_pack_ext_with_body(msgpack_packer* pk, void* b, uint32 l, int8 type)
	// {
	//     int ret = msgpack_pack_ext(pk, l, type);
	//     if (ret != 0) { return ret; }
	//     return msgpack_pack_ext_body(pk, b, l);
	// }
}