//
//  LCWindow.m
//  container
//
//  Created by Ullrich Schäfer on 18.06.12.
//  Copyright (c) 2012 lolcat.biz. All rights reserved.
//

#import "LCWindow.h"

@implementation LCWindow

- (void)awakeFromNib;
{
    self.backgroundColor = [NSColor clearColor];
    self.opaque = NO;
}

@end
