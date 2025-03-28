/*
* MessagePack for C simple buffer implementation
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
	 * @defgroup msgpack_sbuffer Simple buffer
	 * @ingroup msgpack_buffer
	 * @{
	 */
	[CRepr]
	public struct msgpack_sbuffer
	{
		public uint32_t size;
		public char* data;
		public uint32_t alloc;
	}

	[CLink] public static extern void msgpack_sbuffer_init(ref msgpack_sbuffer* sbuf);

	[CLink] public static extern void msgpack_sbuffer_destroy(msgpack_sbuffer* sbuf);

	[CLink] public static extern msgpack_sbuffer* msgpack_sbuffer_new();

	[CLink] public static extern void msgpack_sbuffer_free(msgpack_sbuffer* sbuf);

	[CLink] public static extern c_int msgpack_sbuffer_write(void* data, char* buf, uint32_t len);

	[CLink] public static extern char* msgpack_sbuffer_release(msgpack_sbuffer* sbuf);

	[CLink] public static extern void msgpack_sbuffer_clear(msgpack_sbuffer* sbuf);
}