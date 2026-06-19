#ifndef SECRND_H
#define SECRND_H

#ifdef __cplusplus
extern "C" {
#endif

int secrnd_make_random(unsigned char *buffer, const unsigned int length);

#ifdef __cplusplus
}
#endif

#endif
