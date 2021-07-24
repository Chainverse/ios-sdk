//
//  ChainverseSDKCallback.h
//  Chainverse-SDK
//
//  Created by pham nam on 14/06/2021.
//

#import <Foundation/Foundation.h>

@protocol ChainverseSDKCallback <NSObject>

@required
- (void)didInitSDKSuccess;
- (void)didError:(int)error;
- (void)didUserAddress:(NSString *) address;
- (void)didUserLogout:(NSString *) address;
- (void)didSocketCallback:(NSArray *)data;
@end


