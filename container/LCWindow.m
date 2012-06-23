//
//  LCWindow.m
//  container
//
//  Created by Ullrich Schäfer on 18.06.12.
//  Copyright (c) 2012 lolcat.biz. All rights reserved.
//

#import "LCWindow.h"

@implementation LCWindow

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag;
{
    self = [super initWithContentRect:contentRect
                            styleMask:(NSBorderlessWindowMask | NSResizableWindowMask | NSTexturedBackgroundWindowMask)
                              backing:NSBackingStoreBuffered
                                defer:NO];
    if (self) {
        [self setAlphaValue:1.0];
        [self setOpaque:NO];
    }
    return self;
}

- (BOOL)canBecomeKeyWindow;
{
    return YES;
}


@end
