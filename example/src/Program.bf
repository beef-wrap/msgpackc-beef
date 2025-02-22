using System;
using System.Diagnostics;
using System.IO;
using static msgpackc_Beef.msgpackc;

namespace example;

class Program
{
	const int UNPACKED_BUFFER_SIZE = 2048;

	[CLink] static extern void* __acrt_iob_func(uint32);
	[CLink] static extern void fprintf(void* stream, char8* fmt, ...);

	void prepare(msgpack_sbuffer* sbuf)
	{
		msgpack_packer pk;

		msgpack_packer_init(&pk, sbuf, => msgpack_sbuffer_write);
		/* 1st object */
		msgpack_pack_array(&pk, 3);
		msgpack_pack_int(&pk, 1);
		msgpack_pack_true(&pk);
		msgpack_pack_str(&pk, 7);
		msgpack_pack_str_body(&pk, "example", 7);
		/* 2nd object */
		msgpack_pack_str(&pk, 6);
		msgpack_pack_str_body(&pk, "second", 6);
		/* 3rd object */
		msgpack_pack_array(&pk, 2);
		msgpack_pack_int(&pk, 42);
		msgpack_pack_false(&pk);
	}

	void unpack(char8* buf, uint32 len)
	{
//		/* buf is allocated by client. */
//		msgpack_unpacked result = .();
//		uint32 off = 0;
//		msgpack_unpack_return ret;
//		int i = 0;
//		char8[UNPACKED_BUFFER_SIZE] unpacked_buffer = .();
//
//		msgpack_unpacked_init(&result);
//
//		ret = msgpack_unpack_next(&result, buf, len, &off);
//		while (ret == .MSGPACK_UNPACK_SUCCESS)
//		{
//			msgpack_object obj = result.data;
//
//			/* Use obj. */
//			Debug.WriteLine("Object no %d:\n", ++i);
//			msgpack_object_print(stdout, obj);
//			Debug.WriteLine("\n");
//			msgpack_object_print_buffer(unpacked_buffer, UNPACKED_BUFFER_SIZE, obj);
//			Debug.WriteLine("%s\n", unpacked_buffer);
//			/* If you want to allocate something on the zone, you can use zone. */
//			/* msgpack_zone* zone = result.zone; */
//			/* The lifetime of the obj and the zone,  */
//
//			ret = msgpack_unpack_next(&result, buf, len, &off);
//		}
//
//		msgpack_unpacked_destroy(&result);
//
//		if (ret == MSGPACK_UNPACK_CONTINUE)
//		{
//			Debug.WriteLine("All msgpack_object in the buffer is consumed.\n");
//		}
//		else if (ret == MSGPACK_UNPACK_PARSE_ERROR)
//		{
//			Debug.WriteLine("The data in the buf is invalid format.\n");
//		}
	}

	public static int Main(String[] args)
	{
		msgpack_sbuffer sbuf = .();
		msgpack_packer pk = .();
		msgpack_zone mempool = .();
		msgpack_object deserialized = .();

		/* msgpack::sbuffer is a simple buffer implementation. */
		//msgpack_sbuffer_init(&sbuf);

		/* serialize values into the buffer using msgpack_sbuffer_write callback function. */
		msgpack_packer_init(&pk, &sbuf, => msgpack_sbuffer_write);

		msgpack_pack_array(&pk, 3);
		msgpack_pack_int(&pk, 1);
		msgpack_pack_true(&pk);
		msgpack_pack_str(&pk, 7);
		msgpack_pack_str_body(&pk, "example", 7);

		Debug.WriteLine($"{sbuf.size}");

		/* deserialize the buffer into msgpack_object instance. */
		/* deserialized object is valid during the msgpack_zone instance alive. */
		msgpack_zone_init(&mempool, 2048);

		msgpack_unpack(sbuf.data, sbuf.size, null, &mempool, &deserialized);

		/* print the deserialized object. */
		let stdout = (char8*)__acrt_iob_func(1);

		msgpack_object_print((FILE*)stdout, deserialized);

		msgpack_zone_destroy(&mempool);

		msgpack_sbuffer_destroy(&sbuf);

		return 0;
	}
}