//
//  StaticTest.c
//  runtime_demo
//
//  Created by xian on 6/7/16.
//  Copyright © 2016 cx. All rights reserved.
//

#include "StaticTest.h"

void(*p)();

static void inline static_test_private (){
    
    printf("static_test_private\n");
}


void static_test_public() {
    p = static_test_private;
    static_test_private();
}