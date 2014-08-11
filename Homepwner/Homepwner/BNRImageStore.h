//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Oshida Takeharu on 8/11/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (instancetype) sharedStore;

- (void) setImage: (UIImage *)omage forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *) key;
- (void)deleteImageForKey:(NSString *) key;


@end
