//
//  LCWindow.m
//  container
//
//  Created by Ullrich Schäfer on 18.06.12.
//  Copyright (c) 2012 lolcat.biz. All rights reserved.
//

#import "LCWindow.h"

@implementation LCWindow

@synthesize initialLocation;


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


- (void)mouseDown:(NSEvent *)theEvent {
    // Get the mouse location in window coordinates.
    self.initialLocation = [theEvent locationInWindow];
}

/*
 Once the user starts dragging the mouse, move the window with it. The window has no title bar for
 the user to drag (so we have to implement dragging ourselves)
 */
- (void)mouseDragged:(NSEvent *)theEvent {
    NSRect screenVisibleFrame = [[NSScreen mainScreen] visibleFrame];
    NSRect windowFrame = [self frame];
    NSPoint newOrigin = windowFrame.origin;
    
    // Get the mouse location in window coordinates.
    NSPoint currentLocation = [theEvent locationInWindow];
    // Update the origin with the difference between the new mouse location and the old mouse location.
    newOrigin.x += (currentLocation.x - initialLocation.x);
    newOrigin.y += (currentLocation.y - initialLocation.y);
    
    // Don't let window get dragged up under the menu bar
    if ((newOrigin.y + windowFrame.size.height) > (screenVisibleFrame.origin.y + screenVisibleFrame.size.height)) {
        newOrigin.y = screenVisibleFrame.origin.y + (screenVisibleFrame.size.height - windowFrame.size.height);
    }
    
    // Move the window to the new location
    [self setFrameOrigin:newOrigin];
}


@end
