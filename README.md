# SecureRandom

Generate cryptographically secure random numbers and other objects, designed to be simple, lightweight and portable for cross-platform C++ targets. Supports Windows, Mac (not tested) and Linux.

It can generate random Signed and Unsigned 32 and 64 Bit integers, arrays of `n` length containing bytes (numbers from 0 to 254) and Bytes objects of `n` length.

C rng backend code was taken and adapted from [orlp/ed25519/src/seed.c](https://github.com/orlp/ed25519/blob/master/src/seed.c)