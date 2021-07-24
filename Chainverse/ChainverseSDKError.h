//
//  ChainverseSDKError.h
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import <Foundation/Foundation.h>

typedef enum : int {
    Error_Success = 0,//Không có lỗi nào
    Error_InitSDK = 1001// Lỗi init SDK ()
} ChainverseSDKError;

