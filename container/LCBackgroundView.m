//
//  LCBackgroundView.m
//  container
//
//  Created by Ullrich Schäfer on 18.06.12.
//  Copyright (c) 2012 lolcat.biz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "LCBackgroundView.h"


@interface NSBezierPath (BezierPathQuartzUtilities)
- (CGPathRef)quartzPath;
@end

@implementation NSBezierPath (BezierPathQuartzUtilities)
// This method works only in Mac OS X v10.2 and later.
- (CGPathRef)quartzPath
{
    long i, numElements;
    
    // Need to begin a path here.
    CGPathRef           immutablePath = NULL;
    
    // Then draw the path elements.
    numElements = [self elementCount];
    if (numElements > 0)
    {
        CGMutablePathRef    path = CGPathCreateMutable();
        NSPoint             points[3];
        BOOL                didClosePath = YES;
        
        for (i = 0; i < numElements; i++)
        {
            switch ([self elementAtIndex:i associatedPoints:points])
            {
                case NSMoveToBezierPathElement:
                    CGPathMoveToPoint(path, NULL, points[0].x, points[0].y);
                    break;
                    
                case NSLineToBezierPathElement:
                    CGPathAddLineToPoint(path, NULL, points[0].x, points[0].y);
                    didClosePath = NO;
                    break;
                    
                case NSCurveToBezierPathElement:
                    CGPathAddCurveToPoint(path, NULL, points[0].x, points[0].y,
                                          points[1].x, points[1].y,
                                          points[2].x, points[2].y);
                    didClosePath = NO;
                    break;
                    
                case NSClosePathBezierPathElement:
                    CGPathCloseSubpath(path);
                    didClosePath = YES;
                    break;
            }
        }
        
        // Be sure the path is closed or Quartz may not do valid hit detection.
        if (!didClosePath)
            CGPathCloseSubpath(path);
        
        immutablePath = CGPathCreateCopy(path);
        CGPathRelease(path);
    }
    
    return immutablePath;
}
@end


@interface LCBackgroundView () {
    CGImageRef maskImageRef;
}
- (void)updateMask;
@end


@implementation LCBackgroundView

- (void)awakeFromNib;
{
    self.layer.delegate = self;
    self.layer.shadowPath = [NSBezierPath bezierPathWithRect:self.frame].quartzPath;
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.layer.shadowColor = [NSColor greenColor].CGColor;
    self.layer.shadowRadius = 10;
}

- (void)dealloc;
{
    CGImageRelease(maskImageRef);
}

- (void)updateMask;
{
    // update mask
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 self.bounds.size.width,
                                                 self.bounds.size.height,
                                                 8,
                                                 0,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast);
    
    CGContextSetRGBFillColor(context, (CGFloat)0.0, (CGFloat)0.0, (CGFloat)0.0, (CGFloat)1.0 );
    
    CGFloat radius = 10.0f;
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:self.bounds
                                                         xRadius:radius
                                                         yRadius:radius];
    CGContextAddPath(context, path.quartzPath);
    CGContextFillPath(context);
    
    if (maskImageRef) CGImageRelease(maskImageRef);
    maskImageRef = CGBitmapContextCreateImage(context);
}

- (void)setFrameSize:(NSSize)newSize;
{
    [super setFrameSize:newSize];
    [self updateMask];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context;
{
    [[NSColor clearColor] setFill];
    NSRectFill([self bounds]);
    
    if (maskImageRef) CGContextClipToMask(context, self.bounds, maskImageRef);
    
    CGContextSetFillColorWithColor(context, [NSColor colorWithCalibratedWhite:0.2 alpha:1.0].CGColor);
    CGContextFillRect(context, self.bounds);
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self window] display];
            [[self window] setHasShadow:NO];
            [[self window] setHasShadow:YES];
        });
    });
}

@end
