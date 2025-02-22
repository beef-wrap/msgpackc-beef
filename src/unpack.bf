/*
* MessagePack for C unpacking routine
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
	* @defgroup msgpack_unpack Deserializer
	* @ingroup msgpack
	* @{
	*/

	[CRepr]
	public struct msgpack_unpacked
	{
		public msgpack_zone* zone;
		public msgpack_object data;
	}

	public enum msgpack_unpack_return
	{
		MSGPACK_UNPACK_SUCCESS              =  2,
		MSGPACK_UNPACK_EXTRA_BYTES          =  1,
		MSGPACK_UNPACK_CONTINUE             =  0,
		MSGPACK_UNPACK_PARSE_ERROR          = -1,
		MSGPACK_UNPACK_NOMEM_ERROR          = -2
	}

	[CLink] public static extern msgpack_unpack_return msgpack_unpack_next(msgpack_unpacked* result, char8* data, uint32 len, uint32* off);

	/**
	* @defgroup msgpack_unpacker Streaming deserializer
	* @ingroup msgpack
	* @{
	*/

	[CRepr]
	public struct msgpack_unpacker
	{
		char8* buffer;
		uint32 used;
		uint32 free;
		uint32 off;
		uint32 parsed;
		msgpack_zone* z;
		uint32 initial_buffer_size;
		void* ctx;
	}


#if !MSGPACK_UNPACKER_INIT_BUFFER_SIZE
	const int MSGPACK_UNPACKER_INIT_BUFFER_SIZE = 64 * 1024;
#endif

	/**
	* Initializes a streaming deserializer.
	* The initialized deserializer must be destroyed by msgpack_unpacker_destroy(msgpack_unpacker*).
	*/
	[CLink] public static extern bool msgpack_unpacker_init(msgpack_unpacker* mpac, uint32 initial_buffer_size);

	/**
	* Destroys a streaming deserializer initialized by msgpack_unpacker_init(msgpack_unpacker*, uint32).
	*/
	[CLink] public static extern void msgpack_unpacker_destroy(msgpack_unpacker* mpac);

	/**
	* Creates a streaming deserializer.
	* The created deserializer must be destroyed by msgpack_unpacker_free(msgpack_unpacker*).
	*/
	[CLink] public static extern msgpack_unpacker* msgpack_unpacker_new(uint32 initial_buffer_size);

	/**
	* Frees a streaming deserializer created by msgpack_unpacker_new(uint32).
	*/
	[CLink] public static extern void msgpack_unpacker_free(msgpack_unpacker* mpac);


#if !MSGPACK_UNPACKER_RESERVE_SIZE
	const int MSGPACK_UNPACKER_RESERVE_SIZE = (32 * 1024);
#endif

	/**
	* Reserves free space of the internal buffer.
	* Use this function to fill the internal buffer with
	* msgpack_unpacker_buffer(msgpack_unpacker*),
	* msgpack_unpacker_buffer_capacity(msgpack_unpacker*) and
	* msgpack_unpacker_buffer_consumed(msgpack_unpacker*).
	*/
	[CLink] public static extern bool msgpack_unpacker_reserve_buffer(msgpack_unpacker* mpac, uint32 size);

	/**
	* Gets pointer to the free space of the internal buffer.
	* Use this function to fill the internal buffer with
	* msgpack_unpacker_reserve_buffer(msgpack_unpacker*, uint32),
	* msgpack_unpacker_buffer_capacity(msgpack_unpacker*) and
	* msgpack_unpacker_buffer_consumed(msgpack_unpacker*).
	*/
	[CLink] public static extern char8* msgpack_unpacker_buffer(msgpack_unpacker* mpac);

	/**
	* Gets size of the free space of the internal buffer.
	* Use this function to fill the internal buffer with
	* msgpack_unpacker_reserve_buffer(msgpack_unpacker*, uint32),
	* msgpack_unpacker_buffer(msgpack_unpacker*) and
	* msgpack_unpacker_buffer_consumed(msgpack_unpacker*).
	*/
	[CLink] public static extern uint32 msgpack_unpacker_buffer_capacity(msgpack_unpacker* mpac);

	/**
	* Notifies the deserializer that the internal buffer filled.
	* Use this function to fill the internal buffer with
	* msgpack_unpacker_reserve_buffer(msgpack_unpacker*, uint32),
	* msgpack_unpacker_buffer(msgpack_unpacker*) and
	* msgpack_unpacker_buffer_capacity(msgpack_unpacker*).
	*/
	[CLink] public static extern void msgpack_unpacker_buffer_consumed(msgpack_unpacker* mpac, uint32 size);


	/**
	* Deserializes one object.
	* Returns true if it successes. Otherwise false is returned.
	* @param pac  pointer to an initialized msgpack_unpacked object.
	*/
	[CLink] public static extern msgpack_unpack_return msgpack_unpacker_next(msgpack_unpacker* mpac, msgpack_unpacked* pac);

	/**
	* Deserializes one object and set the number of parsed bytes involved.
	* Returns true if it successes. Otherwise false is returned.
	* @param mpac    pointer to an initialized msgpack_unpacker object.
	* @param result  pointer to an initialized msgpack_unpacked object.
	* @param p_bytes pointer to variable that will be set with the number of parsed bytes.
	*/
	[CLink] public static extern msgpack_unpack_return msgpack_unpacker_next_with_size(msgpack_unpacker* mpac, msgpack_unpacked* result, uint32* p_bytes);

	/**
	* Initializes a msgpack_unpacked object.
	* The initialized object must be destroyed by msgpack_unpacked_destroy(msgpack_unpacker*).
	* Use the object with msgpack_unpacker_next(msgpack_unpacker*, msgpack_unpacked*) or
	* msgpack_unpack_next(msgpack_unpacked*, char8*, uint32, uint32*).
	*/
	[CLink] public static extern void msgpack_unpacked_init(msgpack_unpacked* result);

	/**
	* Destroys a streaming deserializer initialized by msgpack_unpacked().
	*/
	[CLink] public static extern void msgpack_unpacked_destroy(msgpack_unpacked* result);

	/**
	* Releases the memory zone from msgpack_unpacked object.
	* The released zone must be freed by msgpack_zone_free(msgpack_zone*).
	*/
	[CLink] public static extern msgpack_zone* msgpack_unpacked_release_zone(msgpack_unpacked* result);

	[CLink] public static extern int msgpack_unpacker_execute(msgpack_unpacker* mpac);

	[CLink] public static extern msgpack_object msgpack_unpacker_data(msgpack_unpacker* mpac);

	[CLink] public static extern msgpack_zone* msgpack_unpacker_release_zone(msgpack_unpacker* mpac);

	[CLink] public static extern void msgpack_unpacker_reset_zone(msgpack_unpacker* mpac);

	[CLink] public static extern void msgpack_unpacker_reset(msgpack_unpacker* mpac);

	[CLink] public static extern uint32 msgpack_unpacker_message_size(msgpack_unpacker* mpac);

	[Obsolete]
	[CLink] public static extern msgpack_unpack_return msgpack_unpack(char8* data, uint32 len, uint32* off, msgpack_zone* result_zone, msgpack_object* result);

	[CLink] public static extern uint32 msgpack_unpacker_parsed_size(msgpack_unpacker* mpac);

	[CLink] public static extern bool msgpack_unpacker_flush_zone(msgpack_unpacker* mpac);

	[CLink] public static extern bool msgpack_unpacker_expand_buffer(msgpack_unpacker* mpac, uint32 size);



}