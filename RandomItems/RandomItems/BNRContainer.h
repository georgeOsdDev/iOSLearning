//
//  BNRContainer.h
//  RandomItems
//
//  Created by Oshida Takeharu on 7/30/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRItem.h"

@interface BNRContainer : BNRItem
//{
//    BNRItem *_item;
//}
//
//- (void) setItem: (BNRItem *)item;
//- (BNRItem *)item;

@property(nonatomic) BNRItem *item;

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber
                            item:(BNRItem *)item;
@end
