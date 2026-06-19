package secureRandom;

import cpp.Char;
import cpp.NativeArray;
import haxe.Exception;
import haxe.io.Bytes;
import cpp.RawPointer;

/**
	Provides various functions for cryptographically secure random numbers and other objects.
**/
class SecureRandom
{
	/**
		Generates a crypto secure random **32 bit integer**
		Throws if unable to generate.
	**/
	public static function int():Int
		return bytes(4).getInt32(0);

	/**
		Generates a crypto secure random **unsigned 32 bit integer**
		Throws if unable to generate.
	**/
	public static function uint():UInt
	{
		var n = bytes(4).getInt32(0);
		return n + n;
	}

	/**
		Generates a crypto secure random **64 bit integer**
		Throws if unable to generate.
	**/
	public static function int64():haxe.Int64
		return bytes(8).getInt64(0);

	/**
		Generates an array of `length` filled with random bytes (numbers from 0 to 254)
		Throws if unable to generate.
	**/
	public static function array(length:Int):Array<Int>
	{
		var buffer = makeUnsignedCharStar(length);
		var arr:Array<cpp.UInt8> = NativeArray.create(length);

		if (Secrnd.secrnd_make_random(buffer, length) != 0)
			throw new Exception("Failed to create random bytes");

		untyped __cpp__("memcpy({0}, {1}, {2})", NativeArray.getBase(arr).getBase(), buffer, length);

		var array:Array<Int> = [];
		for (i in 0...length)
			array.push(arr[i]);

		return array;
	}

	/**
		Generates a Bytes object of `length` filled with random bytes (numbers from 0 to 254)
		Throws if unable to generate.
	**/
	public static function bytes(length:Int):Bytes
	{
		var buffer = makeUnsignedCharStar(length);
		var bytes = Bytes.alloc(length);

		if (Secrnd.secrnd_make_random(buffer, length) != 0)
			throw new Exception("Failed to create random bytes");

		untyped __cpp__("memcpy({0}->getBase(), {1}, {2})", bytes.getData(), buffer, length);

		return bytes;
	}

	/*
	 * Utility functions
	 */

	static inline function makeUnsignedCharStar(s:Int):UnsignedCharStar
		return cast NativeArray.getBase(NativeArray.create(s)).getBase();
}

@:keep
@:buildXml('
	<files id="haxe">
		<compilerflag value="-I${haxelib:secureRandom}/secureRandom"/>
		<file name="${haxelib:secureRandom}/secureRandom/secrnd.c"/>
	</files>
	<target id="haxe">
		<section if="windows">
			<lib name="Advapi32.lib" />
		</section>
	</target>
')
@:include('secrnd.h')
extern class Secrnd
{
	@:native("secrnd_make_random")
	static function secrnd_make_random(buffer:UnsignedCharStar, length:cpp.UInt32):Int;
}
private typedef UnsignedCharStar = RawPointer<cpp.UInt8>;