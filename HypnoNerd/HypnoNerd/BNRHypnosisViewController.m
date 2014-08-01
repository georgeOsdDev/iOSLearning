//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Oshida Takeharu on 8/1/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController ()

@end

@implementation BNRHypnosisViewController

- (void) loadView
{
    // Create a view
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    // Set it as the view of this view controller
    self.view = backgroundView;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypno";
        
        // Create UIImage from afile
        // This will use Time@2x.png on retina display device
        UIImage * image = [UIImage imageNamed:@"Hypno.png"];
        
        // Put that image on the tab bar item
        self.tabBarItem.image = image;
        
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRHypnosisViewController loaded its view");
}

@end
