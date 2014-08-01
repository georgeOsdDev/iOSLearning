//
//  BNRContainer.m
//  RandomItems
//
//  Created by Oshida Takeharu on 7/30/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, contains %@: recorded on %@",
     self.itemName,
     self.serialNumber,
     self.valueInDollars,
     self.item.description,
     self.dateCreated];
    return descriptionString;
}

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber
                            item:(BNRItem *)item
{
    // Call the superclass's designeated initializer
    self = [super init];
    if (self) {
        // Give the instance variables initial value
        self.itemName = name;
        self.valueInDollars = value;
        self.serialNumber = sNumber;
        _item = item;
    }
    
    // Return the address of the newly initialized object
    return self;
}

//- (void) setItem: (BNRItem *)item
//{
//    _item = item;
//}
//- (BNRItem *)item
//{
//    return _item;
//}

@end
