/*
* MessagePack for C version information
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
	[CLink] public static extern char* msgpack_version();

	[CLink] public static extern c_int msgpack_version_major();

	[CLink] public static extern c_int msgpack_version_minor();

	[CLink] public static extern c_int msgpack_version_revision();
}