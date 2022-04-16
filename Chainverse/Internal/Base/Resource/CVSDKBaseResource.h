//
//  CVSDKBaseResource.h
//  Chainverse-SDK
//
//  Created by pham nam on 15/06/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CVSDKBaseResource : NSObject
+ (NSBundle *)getBundle;
+ (UIImage*) imageNamed:(NSString*) name;
+ (NSString *)loadContractABI:(NSString *)resource;
@end

NS_ASSUME_NONNULL_END
