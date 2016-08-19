//
//  main.m
//  D3
//
//  Created by xian on 8/19/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <Foundation/Foundation.h>


const int K = 10000000;
const int N = 100000000;
typedef struct {double x,y;} CXPoint;
CXPoint randomPoint() {
    CXPoint p = {
        .x = rand()%(10*K)*1.0/K,
        .y = rand()%(10*K)*1.0/K,
    };
    return p;
}

bool isInShadown(CXPoint p) {
    double x = p.x, y = p.y;
    if ((pow((x-5),2)+pow((y-5),2)<25) || (x<5&&(x/2-y>0))) {
        return false;
    }
    return true;
}

///http://mp.weixin.qq.com/s?__biz=MzIwMTYzMzcwOQ==&mid=2650948463&idx=1&sn=04ea32e4fb276cc774465ff9e2d02afe&scene=1&srcid=0801yBsqNxPbcyic33x3JB1M#rd
void d1() {
    srand(time(NULL));
    int sum = 0;
    for (int i=0; i<N; i++) {
        if (isInShadown(randomPoint())) {sum++;}
    }
    printf("%4f",sum*1.0/N*100);
};


int main(int argc, const char * argv[]) {
    d1();
    return 0;
}
