//
//  CVSDKDefine.h
//  Chainverse-SDK
//
//  Created by pham nam on 22/07/2021.
//

#import <Foundation/Foundation.h>

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                alpha:1.0]

typedef enum : int {
    TrustAccount = 1,
    TrustSignature = 2
} TrustResultAction;

typedef enum : int {
    EVENT_CONNECT = 1,
    EVENT_TRANSFER_ITEM_TO_USER = 2,
    EVENT_TRANSFER_ITEM_FROM_USER = 3,
    EVENT_ERROR = 4
} SocketIOEvent;

#define DEBUG_CHAINVERSE_BUNDLE YES
