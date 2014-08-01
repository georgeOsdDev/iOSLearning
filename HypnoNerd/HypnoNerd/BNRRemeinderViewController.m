//
//  BNRRemeinderViewController.m
//  HypnoNerd
//
//  Created by Oshida Takeharu on 8/1/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRRemeinderViewController.h"

@interface BNRRemeinderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *dataPicker;

@end

@implementation BNRRemeinderViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set the tab bar item's title
        self.tabBarItem.title = @"Time";
        
        // Create UIImage from afile
        // This will use Time@2x.png on retina display device
        UIImage * image = [UIImage imageNamed:@"Time.png"];

        // Put that image on the tab bar item
        self.tabBarItem.image = image;

    }
    return self;
}

- (IBAction) addReminder:(id)sender
{
    NSDate *date = self.dataPicker.date;
    NSLog(@"Sending a reminder for %@", date);
    
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRRemeinderViewController loaded its view");
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dataPicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

@end
