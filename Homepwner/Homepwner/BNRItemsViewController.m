//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Oshida Takeharu on 8/5/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"


@implementation BNRItemsViewController

- (instancetype) init
{
    // Call the super class's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for(int i = 0; i < 25; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

-(instancetype) initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Create an instance of UITableViewCell, with defaukt appearance
//    UITableViewCell *cell =
//        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                               reuseIdentifier:@"UITableViewCell"];

    // Get a new or recycled cell
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // Set the text on the cell with the description of item
    // that is at the nth index of items, where n = row this ce;;
    // will appear in on the tableview
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    NSLog(@"%d", indexPath.row);
    
    if (indexPath.row + 1 == [[[BNRItemStore sharedStore] allItems] count]){
        cell.textLabel.text = @"No more items";
    } else {
        cell.textLabel.text = [item description];
    }
    return cell;
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
            forCellReuseIdentifier:@"UITableViewCell"];
     
    
}


@end
