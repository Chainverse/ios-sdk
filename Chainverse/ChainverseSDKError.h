//
//  ChainverseSDKError.h
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import <Foundation/Foundation.h>

typedef enum : int {
    ERROR_WAITING_INIT_SDK = 1000,
    ERROR_INIT_SDK = 1001,
    ERROR_REQUEST_ITEM = 1002,
    ERROR_GAME_ADDRESS = 1003,
    ERROR_DEVELOPER_ADDRESS = 1004,
    ERROR_GAME_PAUSE = 1005,
    ERROR_DEVELOPER_PAUSE = 1006
} ChainverseSDKError;

