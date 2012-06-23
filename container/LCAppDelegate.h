//
//  LCAppDelegate.h
//  container
//
//  Created by Ullrich Schäfer on 18.06.12.
//  Copyright (c) 2012 lolcat.biz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "LCController.h"


@interface LCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet LCController *windowController;

@end
