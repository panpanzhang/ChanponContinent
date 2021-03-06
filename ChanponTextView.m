//
//  ChanponTextView.m
//  Oudontairiku
//
//  Created by Naoki Kuzumi on 10/05/18.
//
//  Copyright 2010 Naoki Kuzumi
//  Licensed under the Apache License, Version 2.0 (the "License"); 
//  you may not use this file except in compliance with the License. 
//  You may obtain a copy of the License at 
//
//      http://www.apache.org/licenses/LICENSE-2.0 
//
//  Unless required by applicable law or agreed to in writing, 
//  software distributed under the License is distributed on an "AS IS" BASIS, 
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
//  See the License for the specific language governing permissions and 
//  limitations under the License. 
//

#import "ChanponTextView.h"
#import "ChanponSettings.h"


@implementation ChanponTextView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (BOOL)acceptsFirstResponder {
	return YES;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)event {
	return YES;
}

- (void)mouseDown:(NSEvent*)event {
	NSWindow* window = [self window];
	
	if([window isKeyWindow] == NO){
		NSUInteger style = [window styleMask];
		[window setStyleMask:(NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask | NSTexturedBackgroundWindowMask)];
		[window makeMainWindow];
		[window makeKeyWindow];
		[window makeFirstResponder:self];
		[window setStyleMask:style];
	}
	[super mouseDown:event];
}

- (void)keyDown:(NSEvent *)event {
	enum {
		enterKey = 36,
	};

	if([event keyCode] == enterKey){
		NSUInteger modifiers = [event modifierFlags]  & (NSShiftKeyMask | NSControlKeyMask | NSAlternateKeyMask | NSCommandKeyMask);
		NSUInteger postKeyModifier = [ChanponSettings getPostKeyModifier];
		if (modifiers == postKeyModifier) {
			[NSApp sendAction:@selector(post2twitter) to:target from:self];
		}else {
			[super keyDown:event];
		}
	}else {
		[super keyDown:event];
	}

}
@end
