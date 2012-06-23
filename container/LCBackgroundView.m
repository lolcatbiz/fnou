//
//  LCBackgroundView.m
//  container
//
//  Created by Ullrich Schäfer on 18.06.12.
//  Copyright (c) 2012 lolcat.biz. All rights reserved.
//

#import "LCBackgroundView.h"

@implementation LCBackgroundView

- (void)awakeFromNib;
{
    self.layer.delegate = self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context;
{
    [[NSColor clearColor] setFill];
    NSRectFill([self bounds]);
    
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:10 yRadius:10];
    [[NSColor blackColor] setFill];
    [path fill];
}


@end
