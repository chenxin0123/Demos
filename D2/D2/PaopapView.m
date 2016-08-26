//
//  PaopapView.m
//  D2
//
//  Created by xian on 8/26/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "PaopapView.h"

@interface PaopapView ()

@property (nonatomic, strong) UIImageView *imageView;///<

@end

@implementation PaopapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
        self.backgroundColor = [UIColor clearColor];
        self.layer.opaque = NO;
        UIImageView *v = [[UIImageView alloc] initWithFrame:self.bounds];
        v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:v];
        
        self.imageView = v;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    UIEdgeInsets rectInset = UIEdgeInsetsMake(3, 3, 30, 3);
    CGFloat cornerRadius = 5;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    CGFloat arrowHeight = 10;
    CGFloat arrowWidth = 10;
    CGFloat arrowX = w / 2;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1 / [UIScreen mainScreen].scale);
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rectInset.left + cornerRadius, rectInset.top);
    CGPathAddLineToPoint(path, NULL, w - rectInset.right - cornerRadius, rectInset.top);
    CGPathAddQuadCurveToPoint(path, NULL, w - rectInset.right, rectInset.top, w - rectInset.right, rectInset.top + cornerRadius);
    CGPathAddLineToPoint(path, NULL, w - rectInset.right, h - rectInset.bottom - cornerRadius);
    CGPathAddQuadCurveToPoint(path, NULL, w - rectInset.right, h - rectInset.bottom, w - rectInset.right - cornerRadius, h - rectInset.bottom);
    CGPathAddLineToPoint(path, NULL, arrowX + arrowWidth / 2, h - rectInset.bottom);
    CGPathAddLineToPoint(path, NULL, arrowX, h - rectInset.bottom + arrowHeight);
    CGPathAddLineToPoint(path, NULL, arrowX - arrowWidth / 2, h - rectInset.bottom);
    CGPathAddLineToPoint(path, NULL, rectInset.left + cornerRadius, h - rectInset.bottom);
    CGPathAddQuadCurveToPoint(path, NULL, rectInset.left, h - rectInset.bottom, rectInset.left, h - rectInset.bottom - cornerRadius);
    CGPathAddLineToPoint(path, NULL, rectInset.left, rectInset.top + cornerRadius);
    CGPathAddQuadCurveToPoint(path, NULL, rectInset.left, rectInset.top, rectInset.left + cornerRadius, rectInset.top);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    [[UIColor lightGrayColor] setStroke];
//    [[UIColor colorWithRed:90/255.0 green:193/255.0 blue:75/255.0 alpha:1] setFill];
    [[UIColor whiteColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGPathRef boxPath = CGPathCreateWithRect(rect, NULL);
    
    // inner shadow
    CGContextSaveGState(context); {
        CGFloat blurRadius = 25;
        CGSize offset = CGSizeMake(0, 10);
        CGColorRef shadowColor = [UIColor colorWithWhite:0 alpha:0.16].CGColor;
        CGColorRef opaqueShadowColor = CGColorCreateCopyWithAlpha(shadowColor, 1.0);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGContextSetAlpha(context, CGColorGetAlpha(shadowColor));
        CGContextBeginTransparencyLayer(context, NULL); {
            CGContextSetShadowWithColor(context, offset, blurRadius, opaqueShadowColor);
            CGContextSetBlendMode(context, kCGBlendModeSourceOut);
            CGContextSetFillColorWithColor(context, opaqueShadowColor);
            CGContextAddPath(context, path);
            CGContextFillPath(context);
        } CGContextEndTransparencyLayer(context);
        CGColorRelease(opaqueShadowColor);
    } CGContextRestoreGState(context);
    
    // outer shadow
    CGContextSaveGState(context); {
        CGContextAddPath(context, path);
        CGContextAddPath(context, boxPath);
        CGContextEOClip(context);
        CGColorRef shadowColor = [UIColor colorWithWhite:0 alpha:0.32].CGColor;
        CGContextSetShadowWithColor(context, CGSizeMake(1, 1), 3, shadowColor);
        CGContextBeginTransparencyLayer(context, NULL); {
            CGContextAddPath(context, path);
            [[UIColor colorWithWhite:0.7 alpha:1.000] setFill];
            CGContextFillPath(context);
        } CGContextEndTransparencyLayer(context);
    } CGContextRestoreGState(context);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.imageView.image = image;
    
    CFRelease(boxPath);
    CFRelease(path);
    UIGraphicsEndImageContext();
}


@end
