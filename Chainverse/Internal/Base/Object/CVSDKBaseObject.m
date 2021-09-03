//
//  CVSDKBaseObject.m
//  Chainverse-SDK
//
//  Created by pham nam on 04/08/2021.
//

#import "CVSDKBaseObject.h"

@implementation CVSDKBaseObject
static NSString * const ApplicationDictKey = @"dictionary";

#pragma mark -- Public function
+ (BOOL) validateObjectDict:(NSDictionary*) objectDict {
    return objectDict[@"packages"]? YES : NO;
}

/**
 *  Support function to get array of value from key and array of object
 *
 *  @param key        key description
 *  @param listObject listObject description
 *
 *  @return return value array
 */
+ (NSArray*) createListValueWithKey:(NSString*) key
                     withListObject:(NSArray*) listObject {
    NSMutableArray *listValues = [NSMutableArray array];
    for (CVSDKBaseObject* obj in listObject) {
        if (obj.objectDict && obj.objectDict[key]) {
            [listValues addObject:obj.objectDict[key]];
        }
    }
    return listValues;
}

+ (NSArray*) createListDataFromListDict:(NSArray*) listDict {
    if (![listDict isKindOfClass:[NSArray class]])
        return nil;
    NSMutableArray *listData = [NSMutableArray array];
    for (NSDictionary* dict in listDict) {
        CVSDKBaseObject *appData = [[self alloc] initWithObjectDict:dict];
        [listData addObject:appData];
    }
    return listData;
}
 
#pragma mark -- Life circle function

- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p> \"%@\"",
            [self class], self, self.objectDict];
}


- (void) encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.objectDict forKey:ApplicationDictKey];
}

- (BOOL)requiresSecureCoding
{
    return YES;
}

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    if (self) {
        self.objectDict = [coder decodeObjectForKey:ApplicationDictKey];
    }
    return self;
}

- (id) initWithObjectDict:(NSDictionary*) applicationDict {
    self = [super init];
    if (self) {
        if (!applicationDict || ![applicationDict isKindOfClass:[NSDictionary class]]) {
            self.objectDict = [NSDictionary dictionary];
        }
        else
            self.objectDict = applicationDict;
    }
    return self;
}

- (id) objectForKey:(NSString*) key {
    return [self.objectDict objectForKey:key];
}

- (NSString*) getObjectMessage {
    return self.objectDict ? [self.objectDict objectForKey:@"message"] : nil;
}

#pragma mark -- Function for archive and encode object

+ (NSMutableData*) archiveNSDataFromObject:(id) object
                                   withKey:(NSString*) key{
    if (!object) {
        return nil;
    }
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    return data;
}

+ (id) archiveObjectFromNSData:(NSData*) data
                       withKey:(NSString*) key {
    if (!data) {
        return nil;
    }
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id object = [unarchiver decodeObjectForKey:key];
    return object;
}

+ (void) archiveObject:(id) object
               withKey:(NSString*) key {
    if (!object) {
        return;
    }
    NSData *objectData = [self archiveNSDataFromObject:object withKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:objectData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) archiveObject:(id) object {
    if (object) {
        Class c = [object class];
        NSString *objectKey = [self getObjectKeyFromClass:c];
        [self archiveObject:object withKey:objectKey];
    }
}

+ (NSString*) getObjectKeyFromClass:(Class) c {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass(c), @"Chainverse"];
}

+ (id) getArchivedObjectWithClass:(Class) c {
    NSString *key = [self getObjectKeyFromClass:c];
    return [self getArchiveObjectWithKey:key];
}

+ (id) getArchiveObjectWithKey:(NSString*) key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (data) {
        return [self archiveObjectFromNSData:data withKey:key];
    }
    return nil;
}
@end
