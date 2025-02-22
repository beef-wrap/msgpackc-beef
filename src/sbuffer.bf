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
		public uint32 size;
		public char8* data;
		public uint32 alloc;
	}

	[CLink] public static extern void msgpack_sbuffer_init(ref msgpack_sbuffer* sbuf);

	[CLink] public static extern void msgpack_sbuffer_destroy(msgpack_sbuffer* sbuf);

	[CLink] public static extern msgpack_sbuffer* msgpack_sbuffer_new(void);

	[CLink] public static extern void msgpack_sbuffer_free(msgpack_sbuffer* sbuf);

	[CLink] public static extern int msgpack_sbuffer_write(void* data, char8* buf, uint32 len);

	[CLink] public static extern char8* msgpack_sbuffer_release(msgpack_sbuffer* sbuf);

	[CLink] public static extern void msgpack_sbuffer_clear(msgpack_sbuffer* sbuf);

//	public static void msgpack_sbuffer_init(ref msgpack_sbuffer* sbuf)
//	{
//		sbuf = default;
//		//Internal.MemSet(sbuf, 0, sizeof(msgpack_sbuffer));
//	}
//
//	public static void msgpack_sbuffer_destroy(msgpack_sbuffer* sbuf)
//	{
//		Internal.StdFree(sbuf.data);
//	}
//
//	static msgpack_sbuffer* msgpack_sbuffer_new(void)
//	{
//		//return (msgpack_sbuffer*)calloc(1, sizeof(msgpack_sbuffer));
//		return new msgpack_sbuffer();
//	}
//
//	static void msgpack_sbuffer_free(msgpack_sbuffer* sbuf)
//	{
//		if (sbuf == null) { return; }
//		msgpack_sbuffer_destroy(sbuf);
//		Internal.StdFree(sbuf);
//	}
//
//#if !MSGPACK_SBUFFER_INIT_SIZE
//	const int MSGPACK_SBUFFER_INIT_SIZE = 8192;
//#endif
//
//	[CLink] public static extern void* realloc(void* data, uint32 size);
//
//	[Inline]
//	public static int msgpack_sbuffer_write(void* data, char8* buf, uint32 len)
//	{
//		msgpack_sbuffer* sbuf = (msgpack_sbuffer*)data;
//
//		//assert(buf || len == 0);
//		if (buf == null) return 0;
//
//		if (sbuf.alloc - sbuf.size < len)
//		{
//			void* tmp;
//			uint32 nsize = (sbuf.alloc > 0) ?
//				sbuf.alloc * 2 : MSGPACK_SBUFFER_INIT_SIZE;
//
//			while (nsize < sbuf.size + len)
//			{
//				uint32 tmp_nsize = nsize * 2;
//				if (tmp_nsize <= nsize)
//				{
//					nsize = sbuf.size + len;
//					break;
//				}
//				nsize = tmp_nsize;
//			}
//
//			tmp = realloc(sbuf.data, nsize);
//
//			if (tmp == null) { return -1; }
//
//			sbuf.data = (char8*)tmp;
//			sbuf.alloc = nsize;
//		}
//
//		Internal.MemCpy(sbuf.data + sbuf.size, buf, len);
//
//		sbuf.size += len;
//
//		return 0;
//	}
//
//	static char8* msgpack_sbuffer_release(msgpack_sbuffer* sbuf)
//	{
//		char8* tmp = sbuf.data;
//		sbuf.size = 0;
//		sbuf.data = null;
//		sbuf.alloc = 0;
//
//		return tmp;
//	}
//
//	static void msgpack_sbuffer_clear(msgpack_sbuffer* sbuf)
//	{
//		sbuf.size = 0;
//	}
}