//
//  CVSDKBaseBlocks.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//


#ifndef CVSDKBaseBlocks_h
#define CVSDKBaseBlocks_h

#import <Foundation/Foundation.h>


typedef void (^CVSDKRPCResponeBlock)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error);

typedef void (^CVSDKContractStatusBlock)(BOOL isChecked);

#endif

