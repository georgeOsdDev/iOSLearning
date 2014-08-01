//
//  BNRItem.m
//  RandomItems
//
//  Created by Oshida Takeharu on 7/29/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

+ (instancetype)randomItem
{
    // Create an immutable array of three adjectives
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    //Get the index of a random adjective/noun from lists
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                                                        [randomAdjectiveList objectAtIndex:adjectiveIndex],
                                                        [randomNounList objectAtIndex:nounIndex]];

    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0'+arc4random() %10,
                                    'A'+arc4random() %26,
                                    '0'+arc4random() %10,
                                    'A'+arc4random() %26,
                                    '0'+arc4random() %10
                                    ];
    
    
    BNRItem *newItem = [[self alloc] initWithItemName:randomName
                                    valueInDollars:randomValue
                                      serialNumber:randomSerialNumber];
    
    return newItem;
}

- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
                        self.itemName,
                        self.serialNumber,
                        self.valueInDollars,
                        self.dateCreated];
    return descriptionString;
}

- (void)dealloc
{
    NSLog(@"Destroyed: %@", self);
}

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber
{
    // Call the superclass's designeated initializer
    self = [super init];
    if (self) {
        // Give the instance variables initial value
        _itemName = name;
        _valueInDollars = value;
        _serialNumber = sNumber;
        //Set _dateCreated to the current date and time
        _dateCreated = [[NSDate alloc] init];
    }
    
    // Return the address of the newly initialized object
    return self;
}

- (instancetype)initWithItemName:(NSString *)name
{
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:@""];
}

- (instancetype)initWithItemName:(NSString *)name
                    serialNumber:(NSString *)sNumber

{
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:sNumber];
}


- (instancetype)init
{
    return [self initWithItemName:@"Item"];
}


//- (void) setItemName: (NSString *)str
//{
//    _itemName = str;
//}
//- (NSString *)itemName
//{
//    return _itemName;
//}
//
//- (void) setSerialNumber: (NSString *)str
//{
//    _serialNumber = str;
//}
//- (NSString *)serialNumber
//{
//    return _serialNumber;
//}
//
//- (void) setValueInDollars: (int)v
//{
//    _valueInDollars = v;
//}
//- (int)valueInDollars
//{
//    return _valueInDollars;
//}
//
//- (NSDate *)dateCreated
//{
//    return _dateCreated;
//}
//
- (void) setContainedItem:(BNRItem *)item
{
    _containedItem = item;
    
    // When given an item to contain, the contained
    // item will be a pointer to its container
    item.container = self;
}
//- (BNRItem *)containedItem
//{
//    return _containedItem;
//}
//
//- (void) setContainer:(BNRItem *)item
//{
//    _container = item;
//}
//- (BNRItem *)container
//{
//    return _container;
//}

@end
