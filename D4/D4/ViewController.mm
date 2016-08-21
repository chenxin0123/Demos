//
//  ViewController.m
//  D4
//
//  Created by CX on 8/21/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"

#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

#include <string>
#include <iostream>
#include <queue>

using namespace std;

class pos {
public:
    int x,y;
    pos(int x, int y):x(x),y(y){}
};

UInt32* rawDataFromCGImageRef(CGImageRef image) {
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(image));
    return (UInt32 *)CFDataGetBytePtr(data);
}

void save(CGImageRef originImg, UInt32 *pixels, NSString *fileName) {
    NSData *data = [NSData dataWithBytes:pixels length:sizeof(UInt32)*CGImageGetWidth(originImg)*CGImageGetHeight(originImg)];
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    /**
     *   The interpolation setting specifies whether an edge-smoothing algorithm is applied to the associated image.
     */
    CGImageRef image = CGImageCreate(CGImageGetWidth(originImg),
                                     CGImageGetHeight(originImg),
                                     CGImageGetBitsPerComponent(originImg),
                                     CGImageGetBitsPerPixel(originImg),
                                     CGImageGetBytesPerRow(originImg),
                                     CGImageGetColorSpace(originImg),
                                     kCGImageAlphaLast|kCGBitmapByteOrderDefault,
                                     provider,
                                     CGImageGetDecode(originImg),
                                     CGImageGetShouldInterpolate(originImg),
                                     CGImageGetRenderingIntent(originImg));
    if (image != NULL) {
        CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath:fileName];
        CGImageDestinationRef dest = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, NULL);
        CGImageDestinationAddImage(dest, image, NULL);
        if (!CGImageDestinationFinalize(dest)) {
            NSLog(@"Failed to write iamge");
        }
        CFRelease(dest);
        CFRelease(image);
    }
    CFRelease(provider);
}

bool isWhite(UInt32 color) {
    int r = color >> 24 & 0XFF;
    int g = color >> 16 & 0XFF;
    int b = color >> 8 & 0XFF;
    //余弦定理 对比向量相似度
    double ret = (r+g+b)*255/(sqrt(r*r+g*g+b*b)*sqrt(255*255*3));
    return  ret >= 0.999;
}

const int delta[4][2] = {{0,1},{1,0},{0,-1},{-1,0}};//下右上左

void imageCleaner(UInt32* pixels, int width, int height) {
    auto q = queue<pos>();
    q.push(pos(0,0));
    q.push(pos(0,height-1));
    q.push(pos(width-1,0));
    q.push(pos(width-1,height-1));
    
    pixels[0] = 0;
    pixels[(height-1)*width] = 0;
    pixels[width-1] = 0;
    pixels[width*height-1] = 0;
    
    while (!q.empty()) {
        auto v = q.front();
        for (int i=0; i<4; i++) {
            int x = delta[i][0] + v.x;
            int y = delta[i][1] + v.y;
            if (x<0 || x >= width || y < 0 || y >= height) {
                continue;
            }
            int p = x + y * width;
            if (pixels[p] && isWhite(pixels[p])) {
                pixels[p] = 0;
                q.push(pos(x,y));
            }
        }
        q.pop();
    }
    
}



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"640.jpeg"];
    
    UInt32 *pixels = rawDataFromCGImageRef(image.CGImage);
    imageCleaner(pixels, image.size.width, image.size.height);
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"xx.jpeg"];
    save(image.CGImage, pixels, path);
    image = [UIImage imageWithContentsOfFile:path];
    CFRelease(pixels);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageView];
    imageView.frame = self.view.bounds;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
