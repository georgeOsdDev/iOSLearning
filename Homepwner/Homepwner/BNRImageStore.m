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
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc  addObserver:self
                selector:@selector(clearCache:)
                    name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
    }
    return self;
}

- (void) setImage:(UIImage *)image forKey:(NSString *)key
{
//    [self.dictionary setObject:image forKey:key];
    self.dictionary[key] = image;
    
    NSString *imagePath = [self imagePathForKey:key];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    [data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
//    return [self.dictionary objectForKey:key];
//    return self.dictionary[key];
    
    UIImage *result = self.dictionary[key];
    
    if (!result){
        NSString *imagePath = [self imagePathForKey:key];
        result = [UIImage imageWithContentsOfFile:imagePath];
        if (result){
            self.dictionary[key] = result;
        } else {
            NSLog(@"Error: unable to find %@", imagePath);
        }
    }
    return result;
    
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    } else {
        [self.dictionary removeObjectForKey:key];
        NSString *path = [self imagePathForKey:key];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDictionaries = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory   = [documentDictionaries firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

- (void)clearCache:(NSString *)note{
    NSLog(@"flushing %lu images out of the cache", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}

@end
