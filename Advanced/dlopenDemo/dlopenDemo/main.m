//
//  main.m
//  dlopenDemo
//
//  Created by Silence on 2019/5/6.
//  Copyright © 2019年 Silence. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>   // EXIT_FAILURE
#include <dlfcn.h>    // dlopen, dlerror, dlsym, dlclose

typedef int(* FUNC_ADD)(int, int); // 定义函数指针类型的别名
const char* dllPath = "./libadd.so";

int main()
{
    void* handle = dlopen( dllPath, RTLD_LAZY );
    
    if( !handle )
    {
        fprintf( stderr, "[%s](%d) dlopen get error: %s\n", __FILE__, __LINE__, dlerror() );
        exit( EXIT_FAILURE );
    }
    
    do{ // for resource handle
        FUNC_ADD add_func = (FUNC_ADD)dlsym( handle, "add" );
        printf( "1 add 2 is %d \n", add_func(1,2) );
    }while(0); // for resource handle
    dlclose( handle );
}

