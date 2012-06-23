//
//  LCWebView.m
//  container
//
//  Created by Ullrich Schäfer on 22.06.12.
//  Copyright (c) 2012 lolcat.biz. All rights reserved.
//

#import "LCWebView.h"

@implementation LCWebView

- (void)layerViewHack:(NSView *)view;
{
    view.wantsLayer = YES;
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    for (NSView *subview in view.subviews) {
        [self layerViewHack:subview];
    }
}

- (void)awakeFromNib;
{
    [self layerViewHack:self];
}
@end
