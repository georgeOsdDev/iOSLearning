//
//  BNRItem.h
//  RandomItems
//
//  Created by Oshida Takeharu on 7/29/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
//{
//    NSString *_itemName;
//    NSString *_serialNumber;
//    int _valueInDollars;
//    NSDate  *_dateCreated;
//    
//    BNRItem *_containedItem;
//    __weak BNRItem *_container;
//}

@property(nonatomic, strong) BNRItem *containedItem;
@property(nonatomic, weak) BNRItem *container;

@property(nonatomic, copy) NSString *itemName;
@property(nonatomic, copy) NSString *serialNumber;
@property(nonatomic) int valueInDollars;
@property(nonatomic, readonly, strong) NSDate *dateCreated;



+ (instancetype)randomItem;

// Designated Initializer for BNRItem
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;

- (instancetype)initWithItemName:(NSString *)name
                    serialNumber:(NSString *)sNumber;

//- (void) setItemName: (NSString *)str;
//- (NSString *)itemName;
//
//- (void) setSerialNumber: (NSString *)str;
//- (NSString *)serialNumber;
//
//- (void) setValueInDollars: (int)v;
//- (int)valueInDollars;
//
//- (NSDate *)dateCreated;
//
//- (void) setContainedItem: (BNRItem *)item;
//- (BNRItem *)containedItem;
//
//- (void) setContainer: (BNRItem *)item;
//- (BNRItem *)container;


@end
