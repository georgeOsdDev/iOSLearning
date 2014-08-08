//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Oshida Takeharu on 8/5/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRItemsViewController.h"

#import "BNRDetailViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

- (instancetype) init
{
    // Call the super class's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
//        for(int i = 0; i < 5; i++) {
//            [[BNRItemStore sharedStore] createItem];
//        }
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        // Create a new bar button item that will send
        // addNewItem: to BNRItemViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        
        // Set this bar button item  as the right item in the navigationItem
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
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
    
//    if (indexPath.row + 1 == [[[BNRItemStore sharedStore] allItems] count]){
//        cell.textLabel.text = @"No more items";
//    } else {
        cell.textLabel.text = [item description];
//    }
    return cell;
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
            forCellReuseIdentifier:@"UITableViewCell"];
     
//    UIView *header = self.headerView;
//    [self.tableView setTableHeaderView:header];

}

- (IBAction)addNewItem:(id)sender
{
    // Make a new index path for the 0th section, last row
//    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    
    // Create new BNRItem and add it to the store
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    //Insert this new row into the table.
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
}

//- (IBAction)toggleEditingMode:(id)sender
//{
//    if(self.isEditing) {
//        
//        //Change text of button to inform user of state
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        
//        // Turn off editing mode
//        [self setEditing:NO animated:YES];
//    } else {
//        
//        //Change text of button to inform user of state
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        
//        // Turn off editing mode
//        [self setEditing:YES animated:YES];
//        
//    }
//}
//
//- (UIView *) headerView
//{
//    // If you have not loaded the headerView yet...
//    if (!_headerView) {
//        
//        // Load HeaderView.xib
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
//                                      owner:self
//                                    options:nil];
//    }
//    return _headerView;
//}

- (void) tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item  = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        //Also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void) tableView:(UITableView *)tableView
            moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
            toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailView = [[BNRDetailViewController alloc] init];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    // Give detail view controller a pointer to the item object in row
    detailView.item = selectedItem;
    
    //Push it on the top of navigation controller's stack
    [self.navigationController pushViewController:detailView
                                         animated:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

@end
