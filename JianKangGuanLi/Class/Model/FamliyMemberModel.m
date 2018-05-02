//
//  FamliyMemberModel.m
//  JianKangGuanLi
//
//  Created by ydz on 17/3/30.
//  Copyright © 2017年 yzd. All rights reserved.
//

#import "FamliyMemberModel.h"
#import <objc/runtime.h>

@implementation FamliyMemberModel

-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = (NSString *)value;
    }
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int outCount = 0;
    Ivar *vars = class_copyIvarList([self class], &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        unsigned int count = 0;
        Ivar *vars = class_copyIvarList([self class], &count);
        for (NSInteger i = 0; i < count;  i++) {
            
            Ivar var = vars[i];
            const char *name = ivar_getName(var);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return self;
}

@end
