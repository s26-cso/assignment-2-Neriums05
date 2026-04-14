#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>

int main() {
    char op[6];
    char current_op[6] = "";
    int num1, num2;
    void *lib_handle = NULL;
    int (*func)(int, int) = NULL;
    char lib_name[32];

    
    while (scanf("%5s %d %d", op, &num1, &num2) == 3) {
        
        
        if (strcmp(op, current_op) != 0) {
            if (lib_handle != NULL) {
                dlclose(lib_handle);
            }
            sprintf(lib_name, "./lib%s.so", op);
            lib_handle = dlopen(lib_name, RTLD_LAZY);
            func = (int (*)(int, int))dlsym(lib_handle, op);
            strcpy(current_op, op);
        }

        
        int result = func(num1, num2);
        printf("%d\n", result);
    }

    if (lib_handle != NULL) {
        dlclose(lib_handle);
    }
    
    return 0;
}
