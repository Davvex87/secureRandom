package;

import haxe.Log;
import haxe.PosInfos;
import haxe.io.Bytes;
import secureRandom.SecureRandom;

class Main
{
	static function main()
	{
		var randomInt32 = SecureRandom.int();
		trace(randomInt32);

		var randomUInt32 = SecureRandom.uint();
		trace(randomUInt32);

		var randomInt64 = SecureRandom.int64();
		trace(randomInt64);

		var randomArray = SecureRandom.array(64);
		trace(randomArray);

		var randomBytes = SecureRandom.bytes(64);
		printBytes(randomBytes);
	}

	static function printBytes(bytes:Bytes, ?pos:PosInfos)
	{
		final buf = new StringBuf();
		for (i in 0...bytes.length)
		{
			buf.add(Std.string(bytes.get(i)));
			if (i < bytes.length-1)
				buf.add(" ");
		}
		Log.trace(buf, pos);
	}
}