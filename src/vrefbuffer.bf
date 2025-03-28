/*
* MessagePack for C zero-copy buffer implementation
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
	public struct msgpack_iovec;

	/**
	* @defgroup msgpack_vrefbuffer Vectored Referencing buffer
	* @ingroup msgpack_buffer
	* @{
	*/

	public struct msgpack_vrefbuffer_chunk;

	[CRepr]
	public struct msgpack_vrefbuffer_inner_buffer
	{
		uint32_t free;
		char* ptr;
		msgpack_vrefbuffer_chunk* head;
	}

	[CRepr]
	public struct msgpack_vrefbuffer
	{
		msgpack_iovec* tail;
		msgpack_iovec* end;
		msgpack_iovec* array;

		uint32_t chunk_size;
		uint32_t ref_size;

		msgpack_vrefbuffer_inner_buffer inner_buffer;
	}


#if !MSGPACK_VREFBUFFER_REF_SIZE
	const int  MSGPACK_VREFBUFFER_REF_SIZE = 32;
#endif

#if !MSGPACK_VREFBUFFER_CHUNK_SIZE
	const int  MSGPACK_VREFBUFFER_CHUNK_SIZE = 8192;
#endif

	[CLink] public static extern bool msgpack_vrefbuffer_init(msgpack_vrefbuffer* vbuf, uint32_t ref_size, uint32_t chunk_size);
	[CLink] public static extern void msgpack_vrefbuffer_destroy(msgpack_vrefbuffer* vbuf);

	// static inline msgpack_vrefbuffer* msgpack_vrefbuffer_new(uint32_t ref_size, uint32_t chunk_size);
	// static inline void msgpack_vrefbuffer_free(msgpack_vrefbuffer* vbuf);

	// static inline int msgpack_vrefbuffer_write(void* data, char* buf, uint32_t len);

	// static inline const msgpack_iovec* msgpack_vrefbuffer_vec(const msgpack_vrefbuffer* vref);
	// static inline uint32_t msgpack_vrefbuffer_veclen(const msgpack_vrefbuffer* vref);

	[CLink] public static extern int msgpack_vrefbuffer_append_copy(msgpack_vrefbuffer* vbuf, char* buf, uint32_t len);

	[CLink] public static extern int msgpack_vrefbuffer_append_ref(msgpack_vrefbuffer* vbuf, char* buf, uint32_t len);

	[CLink] public static extern int msgpack_vrefbuffer_migrate(msgpack_vrefbuffer* vbuf, msgpack_vrefbuffer* to);

	[CLink] public static extern void msgpack_vrefbuffer_clear(msgpack_vrefbuffer* vref);
}