// Code adapted from https://github.com/orlp/ed25519/blob/master/src/seed.c

#include "secrnd.h"

#ifdef _WIN32
#include <windows.h>
#include <wincrypt.h>
#else
#include <stdio.h>
#endif

int secrnd_make_random(unsigned char *buffer, const unsigned int length) {

	#ifdef _WIN32
    HCRYPTPROV prov;

    if (!CryptAcquireContext(&prov, NULL, NULL, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT))  {
        return 1;
    }

    if (!CryptGenRandom(prov, length, buffer))  {
        CryptReleaseContext(prov, 0);
        return 1;
    }

    CryptReleaseContext(prov, 0);
	#else
    FILE *f = fopen("/dev/urandom", "rb");

    if (f == NULL) {
        return 1;
    }

    fread(buffer, 1, length, f);
    fclose(f);
	#endif

    return 0;
}