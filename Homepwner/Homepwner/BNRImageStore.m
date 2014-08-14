//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Oshida Takeharu on 8/11/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

+ (instancetype) sharedStore
{
    static BNRImageStore *sharedStore;
//    
//    if (!sharedStore) {
//        sharedStore = [[self alloc] initPrivate];
//    }
//    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    return sharedStore;

    return sharedStore;
}

- (instancetype) init
{
    [NSException raise:@"Singleton"
                format:@"Use +[BNRImageStore sharedStore]"];
    
    return nil;
    
}


-(instancetype) initPrivate
{
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) setImage:(UIImage *)image forKey:(NSString *)key
{
//    [self.dictionary setObject:image forKey:key];
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
//    return [self.dictionary objectForKey:key];
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    } else {
        [self.dictionary removeObjectForKey:key];
    }
}


@end
