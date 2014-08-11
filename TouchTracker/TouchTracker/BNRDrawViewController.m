//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Oshida Takeharu on 8/11/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
