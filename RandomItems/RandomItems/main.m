//
//  main.m
//  RandomItems
//
//  Created by Oshida Takeharu on 7/29/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"
#import "BNRContainer.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // Create a mutable array object, store its address in items variable
//        NSMutableArray *items = [[NSMutableArray alloc] init];
//
//        // Send the message addObject: to the NSMutableArray pointed to
//        // by the variable items, passing a string each time
//        [items addObject:@"One"];
//        [items addObject:@"Two"];
//        [items addObject:@"Three"];
//        
//        // Send another message, insertObject:atIndex; to that same array object
//        [items insertObject:@"Zero" atIndex:0];
        
        // Traditional for loop
//        for (int i = 0; i < [items count]; i++) {
//            NSString *item = [items objectAtIndex:i];
//            NSLog(@"%@", item);
//        }

//        // For every item in items array
//        for (NSString *item in items) {
//            NSLog(@"%@", item);
//        }
//        
//        // Destroy the mutable array object
//        items = nil;
        
//        BNRItem *item = [[BNRItem alloc] init];
//        [item setItemName:@"Red Sofa"];
//        [item setSerialNumber:@"A1B2C"];
//        [item setValueInDollars:100];

//        item.itemName = @"Red Sofa";
//        item.serialNumber = @"A1B2C";
//        item.valueInDollars = 100;

//        BNRItem *item = [[BNRItem alloc] initWithItemName:@"RedSofa"
//                                           valueInDollars:100
//                                             serialNumber:@"A1B2C"];
        
        
//        NSLog(@"%@ %@ %@ %d", [item itemName], [item dateCreated], [item serialNumber], [item valueInDollars]);

//        NSLog(@"%@", item);
//
//        BNRItem *itemWithName = [[BNRItem alloc] initWithItemName:@"BlueSofa"];
//        NSLog(@"%@", itemWithName);
//
//        BNRItem *itemWithNoName = [[BNRItem alloc] init];
//        NSLog(@"%@", itemWithNoName);
//
//        BNRItem *random = [BNRItem randomItem];
//        NSLog(@"%@", random);
//        
//        
//        NSMutableArray *items2 = [[NSMutableArray alloc] init];
//        for (int i = 0; i < 10; i++){
//            BNRItem *item = [BNRItem randomItem];
//            [items2 addObject:item];
//        }
//
//        for (BNRItem *item in items2){
//            NSLog(@"%@", item);
//        }

        // Bronze challange
//        NSMutableArray *items = [[NSMutableArray alloc] init];
//        [items objectAtIndex:11];
//
//        //Silver challange
//        BNRItem *itemWithNameAndSerial = [[BNRItem alloc] initWithItemName:@"BlueSofa"
//                                                              serialNumber:@"xxxxx"];
//        NSLog(@"%@", itemWithNameAndSerial);
//        
//        BNRContainer * container = [[BNRContainer alloc] initWithItemName:@"cont" valueInDollars:100 serialNumber:@"seri" item:itemWithNameAndSerial];
//        
//        NSLog(@"%@", container);
//        
//        
//        NSMutableArray *items = [[NSMutableArray alloc] init];
//        [items addObject:container];
//        
//        items = nil;
        

        
        //Chapter 3
        NSMutableArray *items = [[NSMutableArray alloc] init];

        BNRItem *backpack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];
        
        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backpack.containedItem = calculator;
        
        
        for (BNRItem *item in items){
            NSLog(@"%@", item);
        }

        NSLog(@"Setting items to nil");
        items = nil;
        
        
    }
    return 0;
}

