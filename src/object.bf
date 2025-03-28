/*
* MessagePack for C dynamic typing routine
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
	* @defgroup msgpack_object Dynamically typed object
	* @ingroup msgpack
	* @{
	*/
	[AllowDuplicates]
	public enum msgpack_object_type : c_int
	{
		MSGPACK_OBJECT_NIL                  = 0x00,
		MSGPACK_OBJECT_BOOLEAN              = 0x01,
		MSGPACK_OBJECT_POSITIVE_INTEGER     = 0x02,
		MSGPACK_OBJECT_NEGATIVE_INTEGER     = 0x03,
		MSGPACK_OBJECT_FLOAT32              = 0x0a,
		MSGPACK_OBJECT_FLOAT64              = 0x04,
		MSGPACK_OBJECT_FLOAT                = 0x04,
#if MSGPACK_USE_LEGACY_NAME_AS_FLOAT
		MSGPACK_OBJECT_DOUBLE               = MSGPACK_OBJECT_FLOAT, /* obsolete */
#endif /* MSGPACK_USE_LEGACY_NAME_AS_FLOAT */
		MSGPACK_OBJECT_STR                  = 0x05,
		MSGPACK_OBJECT_ARRAY                = 0x06,
		MSGPACK_OBJECT_MAP                  = 0x07,
		MSGPACK_OBJECT_BIN                  = 0x08,
		MSGPACK_OBJECT_EXT                  = 0x09
	}

	[CRepr]
	public struct msgpack_object_array
	{
		uint32_t size;
		msgpack_object* ptr;
	}

	[CRepr]
	public struct msgpack_object_map
	{
		uint32_t size;
		msgpack_object_kv* ptr;
	}

	[CRepr]
	public struct msgpack_object_str
	{
		uint32_t size;
		char* ptr;
	}

	[CRepr]
	public struct msgpack_object_bin
	{
		uint32_t size;
		char* ptr;
	}

	[CRepr]
	public struct msgpack_object_ext
	{
		int8_t type;
		uint32_t size;
		char* ptr;
	}

	[Union, CRepr]
	public struct msgpack_object_union
	{
		bool boolean;
		uint64_t u64;
		int64_t i64;
	#if MSGPACK_USE_LEGACY_NAME_AS_FLOAT
		double dec; /* obsolete*/
	#endif /* MSGPACK_USE_LEGACY_NAME_AS_FLOAT */
		double f64;
		msgpack_object_array array;
		msgpack_object_map map;
		msgpack_object_str str;
		msgpack_object_bin bin;
		msgpack_object_ext ext;
	}

	[CRepr]
	public struct msgpack_object
	{
		msgpack_object_type type;
		msgpack_object_union via;
	}


	[CRepr]
	public struct msgpack_object_kv
	{
		msgpack_object key;
		msgpack_object val;
	}

	[CLink] public static extern  void msgpack_object_init_nil(msgpack_object* d);

	[CLink] public static extern  void msgpack_object_init_boolean(msgpack_object* d, bool v);

	[CLink] public static extern  void msgpack_object_init_unsigned_integer(msgpack_object* d, uint64_t v);

	[CLink] public static extern  void msgpack_object_init_signed_integer(msgpack_object* d, int64_t v);

	[CLink] public static extern  void msgpack_object_init_float32(msgpack_object* d, float v);

	[CLink] public static extern  void msgpack_object_init_float64(msgpack_object* d, double v);

	[CLink] public static extern  void msgpack_object_init_str(msgpack_object* d, char* data, uint32_t size);

	[CLink] public static extern  void msgpack_object_init_bin(msgpack_object* d, char* data, uint32_t size);

	[CLink] public static extern  void msgpack_object_init_ext(msgpack_object* d, int8_t type, char* data, uint32_t size);

	[CLink] public static extern  void msgpack_object_init_array(msgpack_object* d, msgpack_object* data, uint32_t size);

	[CLink] public static extern  void msgpack_object_init_map(msgpack_object* d, msgpack_object_kv* data, uint32_t size);

#if !_KERNEL_MODE
	public struct FILE;

	[CLink] public static extern  void msgpack_object_print(FILE* out_file, msgpack_object o);
#endif

	[CLink] public static extern  int msgpack_object_print_buffer(char* buffer, uint32_t buffer_size, msgpack_object o);

	[CLink] public static extern  bool msgpack_object_equal(msgpack_object x, msgpack_object y);
}