//
//  CVSDKBaseBlocks.h
//  Chainverse-SDK
//
//  Created by pham nam on 23/06/2021.
//


#ifndef CVSDKBaseBlocks_h
#define CVSDKBaseBlocks_h

#import <Foundation/Foundation.h>
#import "ChainverseNFT.h" 
typedef void (^CVSDKRPCResponeBlock)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error);

typedef void (^CVSDKContractStatusBlock)(BOOL isChecked);
typedef void (^CVSDKTransferItemListen)(int event,NSArray * _Nonnull data);
typedef void (^CVSDKRESTfulSuccess)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);

typedef void (^CVSDKRESTfulFailure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);
typedef void (^CVSDKGetNFTBlock)(ChainverseNFT * _Nullable item);
typedef void (^CVSDKPublishNFTBlock)(BOOL isPublished);

#endif

