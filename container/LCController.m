//
//  LCController.m
//  container
//
//  Created by Ullrich Schäfer on 22.06.12.
//  Copyright (c) 2012 lolcat.biz. All rights reserved.
//

#import "LCController.h"


@implementation LCController

- (void)awakeFromNib;
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://next.lolcat.biz"]];
    [self.webView.mainFrame loadRequest:request];
}

@end
