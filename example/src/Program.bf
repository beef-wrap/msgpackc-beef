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
		FILE* stdout = (FILE*)__acrt_iob_func(1);
		uint32 offset = 0;
		msgpack_object* obj = ?;

		msgpack_object_print(stdout, deserialized);

		msgpack_zone_destroy(&mempool);

		msgpack_sbuffer_destroy(&sbuf);

		return 0;
	}
}