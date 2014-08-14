//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Oshida Takeharu on 8/8/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController

- (instancetype) initForNewItem:(BOOL)isNew;

@property (nonatomic, copy) void (^dismissBlock)(void);

@property (nonatomic, strong) BNRItem *item;

@end
