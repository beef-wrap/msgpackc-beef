/*
* MessagePack for C memory pool implementation
*
* Copyright (C) 2008-2010 FURUHASHI Sadayuki
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
	* @defgroup msgpack_zone Memory zone
	* @ingroup msgpack
	* @{
	*/

	[CRepr]
	public struct msgpack_zone_finalizer
	{
		function void(void* data) func;
		void* data;
	};

	[CRepr]
	public struct msgpack_zone_finalizer_array
	{
		msgpack_zone_finalizer* tail;
		msgpack_zone_finalizer* end;
		msgpack_zone_finalizer* array;
	}

	[CRepr]
	public struct msgpack_zone_chunk;

	[CRepr]
	public struct msgpack_zone_chunk_list
	{
		uint32 free;
		char8* ptr;
		msgpack_zone_chunk* head;
	}

	[CRepr]
	public struct msgpack_zone
	{
		msgpack_zone_chunk_list chunk_list;
		msgpack_zone_finalizer_array finalizer_array;
		uint32 chunk_size;
	}

#if !MSGPACK_ZONE_CHUNK_SIZE
	const int MSGPACK_ZONE_CHUNK_SIZE = 8192;
#endif

	[CLink] public static extern bool msgpack_zone_init(msgpack_zone* zone, uint32 chunk_size);
	[CLink] public static extern void msgpack_zone_destroy(msgpack_zone* zone);

	[CLink] public static extern msgpack_zone* msgpack_zone_new(uint32 chunk_size);
	[CLink] public static extern void msgpack_zone_free(msgpack_zone* zone);

	// static inline void* msgpack_zone_malloc(msgpack_zone* zone, uint32 size);
	// static inline void* msgpack_zone_malloc_no_align(msgpack_zone* zone, uint32 size);

	// static inline bool msgpack_zone_push_finalizer(msgpack_zone* zone, void (*func)(void* data), void* data);

	// static inline void msgpack_zone_swap(msgpack_zone* a, msgpack_zone* b);

	[CLink] public static extern bool msgpack_zone_is_empty(msgpack_zone* zone);

	[CLink] public static extern void msgpack_zone_clear(msgpack_zone* zone);

	[CLink] public static extern void* msgpack_zone_malloc_expand(msgpack_zone* zone, uint32 size);
}