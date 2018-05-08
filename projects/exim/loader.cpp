/**
 * Fuzzing arbitrary functions in ELF binaries, using LIEF and LibFuzzer
 *
 * Full article on https://blahcat.github.io/
 * @_hugsy_
 *
 */
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <alloca.h>
#include <string.h>

// int b64decode(const uschar *code, uschar **ptr)
typedef int(*b64decode_t)(const char*, char**);

// void store_reset_3(void *ptr, const char *filename, int linenumber)
typedef void(*store_reset_3_t)(void *, const char *, int);


int is_loaded = 0;
void* h = NULL;

void CloseLibrary()
{
        if(h){
                dlclose(h);
                h = NULL;
        }
        return;
}

#ifdef USE_LIBFUZZER
extern "C"
#endif
int LoadLibrary()
{
        h = dlopen("./exim.so", RTLD_LAZY);
        atexit(CloseLibrary);
        return h != NULL;
}

#ifdef USE_LIBFUZZER
extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size)
#else
int main (int argc, char** argv)
#endif
{
        char* code;
        char* ptr = NULL;

        if (!is_loaded){
            if(!LoadLibrary()){
                return -1;
            }
            is_loaded = 1;
        }

#ifdef USE_LIBFUZZER
        if(Size==0)
            return 0;
#else
        char *Data = argv[1];
        size_t Size = strlen(argv[1]);
#endif

        // make sure the fuzzed data is null terminated
        if (Data[Size-1] != '\x00'){
            code = (char*)alloca(Size+1);
            memset(code, 0, Size+1);
        } else {
            code = (char*)alloca(Size);
            memset(code, 0, Size);
        }

        memcpy(code, Data, Size);
        b64decode_t b64decode = (b64decode_t)dlsym(h, "b64decode");
        store_reset_3_t store_reset_3 = (store_reset_3_t)dlsym(h, "store_reset_3");

#ifndef USE_LIBFUZZER
        printf("b64decode=%p\n", b64decode);
#endif

        int res = b64decode(code, &ptr);

#ifndef USE_LIBFUZZER
        if (res != -1){
            printf("b64decode() returned %d, result -> '%s'\n", res, ptr);
        } else{

            printf("failed\n");
        }
#endif


#ifndef USE_LIBFUZZER
        free(ptr-0x10);
#else
        store_reset_3(ptr, "libfuzzer", 0);
#endif

        return 0;
}
