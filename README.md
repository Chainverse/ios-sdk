# Chainverse SDK for iOS

<img src="https://i.imgur.com/Dl4KbTt.png" width="100%" alt="NFT Shiba Inu">

Đơn giản hoá tích hợp Blokchain vào game của bạn với Chainverse SDK. 

Chainverse Native SDK sử dụng các API và tối ưu hóa dành riêng cho hệ điều hành để mang lại trải nghiệm người dùng tốt hơn. Chúng chứa chức năng cốt lõi để tích hợp vào game nhanh chóng hơn bao gồm các chức năng chính: Kết nối với ví Blockchain (Chainverse và các ví khác) và trao đổi NFT. 

## Mô hình Chainverse SDK
### Sequence Diagram Flow SDK
<img src="https://gblobscdn.gitbook.com/assets%2F-MfegUcnHBLzXgHaEQpA%2F-MfeiNnnfjqea_AfGmtY%2F-MfemVicwlXwEXbOG_HR%2Fcv1.jpg?alt=media&token=51652a27-807a-464d-bf0d-01d883c641b6" width="100%" alt="NFT Shiba Inu">

### Sequence Diagram Move & Transfer NFT giữa các game với nhau
<img src="https://gblobscdn.gitbook.com/assets%2F-MfegUcnHBLzXgHaEQpA%2F-MfeiNnnfjqea_AfGmtY%2F-MfemkBnwJ-UhkunG7OT%2Fcv2.jpg?alt=media&token=7f403309-3062-479f-ac14-e6c0a1113c81" width="100%" alt="NFT Shiba Inu">

## Error Code
Danh sách mã lỗi của Chainverse SDK

| Name  | Error Code | Description | Suggestion | 
| ------------- | ------------- | ------------- | ------------- |
| ERROR_WAITING_INIT_SDK  | 1000  | Đang khởi tạo SDK | Hãy chờ cho đến khi khởi tạo xong | 
| ERROR_INITSDK  | 1001  | Lỗi khởi tạo SDK | Có thể có lỗi khi gọi lên blockchain | 
| ERROR_REQUEST_ITEM  | 1002  | Lỗi connect lấy về danh sách item NFT | Hãy thử lại | 
| ERROR_GAME_ADDRESS  | 1003  | Game address không đúng | Hãy kiểm tra lại | 
| ERROR_DEVELOPER_ADDRESS | 1004  | Developer address không đúng | Hãy kiểm tra lại |
| ERROR_GAME_PAUSE | 1005  | Game đang bị pause | Hãy kiểm tra lại |
| ERROR_DEVELOPER_PAUSE | 1006  | Developer đang bị pause | Hãy kiểm tra lại |

## Installation
### Cài đặt thủ công
#### Bước 1: Tải xuống static framework
Tải xuống ChainverseSDK_Framework.zip tại https://github.com/Chainverse/ios-sdk/releases
#### Bước 2: Giải nén
Giải nén file ChainverseSDK.framework.zip bạn vừa tải xuống có những file sau:
```
Chainverse.framework
ChainverseBundle.bundle
BigInt.xcframework
CryptoSwift.xcframework
PromiseKit.xcframework
SipHash.xcframework
Starscream.xcframework
SocketIO.xcframework
secp256k1.xcframework
```
#### Bước 3: Import vào dự án
Kéo tất cả những file đã giải nén ở Bước 2 vào dự án của bạn 

#### Bước 4. Embed framework
Chọn Embed & Sign đối với :
```
BigInt.xcframework
CryptoSwift.xcframework
PromiseKit.xcframework
SipHash.xcframework
Starscream.xcframework
SocketIO.xcframework
secp256k1.xcframework
```
<img src="https://i.imgur.com/5umw9yI.png">

#### Bước 5: Tạo Bridging Header
- File -> New -> File
- Select Swift File
- Tạo 1 file .swift với tên bất kì.

<img src="https://i.imgur.com/Wulhemz.png">

- Confirm Create Bridging Header .

<img src="https://i.imgur.com/5Yr786R.png">


#### Bước 6:  Thiết lập Url scheme
Bạn cần thiết lập Url scheme để  connect với ví Chainverse

<img src="https://i.imgur.com/otRESxJ.png" width="100%" alt="NFT Shiba Inu">

####  Bước 7. Config Application Schemes
Bạn phải thiết lập "chainverse" trong file Info.Plist để connect với ví Chainverse. 

```
<key>LSApplicationQueriesSchemes</key>
<array>
   <string>chainverse</string>
</array>

```
## Tích hợp SDK
### Trước khi bắt đầu
Bạn phải cài đặt Chainverse SDK (xem Hướng dẫn).

Tài liệu này chứa các tham số bắt buộc. Bạn phải đảm bảo khai báo chúng.

1. "Game Address": Địa chỉ contract của game.
2. "Developer Address": Địa chỉ contract của developer.
3. "App Scheme": Khai báo scheme để connect Chainverse.

### Khởi tạo Chainverse SDK
#### Bước 1: Import dependencies 
Import Chainverse và ChainverseSDKCallback to AppDelegate 

##### Objective C
```
#import "Chainverse/ChainverseSDK.h"
#import "Chainverse/ChainverseSDKCallback.h"
#import "Chainverse/ChainverseItem.h"
#import "Chainverse/ChainverseNFT.h"
#import "Chainverse/ChainverseSDKError.h"

@interface AppDelegate () <ChainverseSDKCallback>

@end
```


#### Bướ​c 2: Khởi tạo SDK
Trong didFinishLaunchingWithOptions khai báo Game Contract Address và Developer Contract Address

##### Objective C
```
[ChainverseSDK shared].developerAddress = @"DeveloperAddress";
[ChainverseSDK shared].gameAddress = @"GameAddress";
[ChainverseSDK shared].scheme = @"your-app-scheme://";
[ChainverseSDK shared].delegate = self;
[[ChainverseSDK shared] initialize];
```

#### Bước 3: Implement các hàm callback
#### 1. Callback didInitSDKSuccess
Khi khởi tạo SDK callback sẽ được gửi lại, để thông báo là đã khởi tạo thành công.

Lưu ý: Các chức năng trong SDK sẽ không được thực thi, nếu quá trình khởi tạo SDK bị lỗi. Và không có callback didInitSDKSuccess. Mã lỗi sẽ được callback ở hàm didError.

##### Objective C
```
- (void)didInitSDKSuccess{ 
}
```


#### 2. Callback didError
Khi khởi tạo SDK hoặc có bất kỳ lỗi nào xả ra sẽ có callback này. Thông tin trả về là mã lỗi. Bạn có thể xem tất cả mã lỗi ở trang Error  Codes .

##### Objective C
```
- (void)didError:(int)error{
    
}
```


#### 3. Callback didConnectSuccess
Khi user connect tới ví Chainverse thành công thì sẽ có callback này. Thông tin trả về là địa chỉ ví của user. 

##### Objective C
```
- (void)didConnectSuccess:(NSString *)address{
    
}
```


#### 4. Callback didLogout
Khi user thực hiện thao tác đăng xuất callback này sẽ được gọi. Thông tin trả về là địa chỉ ví của user. 

##### Objective C
```
- (void)didLogout:(NSString *)address{
   
}
```


#### 5. Callback didGetListItemMarket

Khi hàm `[[ChainverseSDK shared] getListItemOnMarket];` callback này sẽ trả về danh sách NFT trong chợ.

Bạn sẽ xử lý NFT trong chợ của bạn ở callback này.

##### Objective C
```
- (void)didGetListItemMarket:(NSMutableArray<NFT> *) items{
    
}
```

#### 6. Callback didGetDetailItem

Khi hàm gọi `[[ChainverseSDK shared] getDetailNFT:{nft_address} tokenId:{tokenId}];` callback này sẽ trả về thông tin detail của NFT.

Bạn sẽ xử lý NFT trong chợ của bạn ở callback này.

##### Objective C
```
- (void)didGetDetailItem:(NFT*)item{
    
}
```


#### 7. Callback didGetMyAssets

Khi hàm gọi `[[ChainverseSDK shared] getMyAsset];` callback này sẽ trả về danh sách NFT của user

Bạn sẽ xử lý NFT của bạn ở callback này.

##### Objective C
```
- (void)didGetMyAssets:(NSMutableArray<NFT>  *) items{
    
}
```


#### 8. Callback didItemUpdate

Khi​ chuyển NFT qua lại giữa user - user trong 1 game, và chuyển từ game này sang game kia. Callback này sẽ được gọi REALTIME. Thông tin trả về là 01 NFT đã move.

Bạn sẽ xử lý NFT trong game của bạn ở callback này.

##### Objective C
```
- (void)didItemUpdate:(ChainverseItem *)item type:(int)type{
    switch (type) {
        case TRANSFER_ITEM_TO_USER:
            //Xử lý NFT trong game khi NFT chuyển tới tài khoản của bạn
            break;
        case TRANSFER_ITEM_FROM_USER:
            //Xử lý NFT trong game khi NFT của bạn chuyến tời tài khoản khác
            break;
    }
}
```


#### 9. Callback didTransact

Callback này sẽ trả về transaction hash và function khi thực hiện các chức năng blockchain


##### Objective C
```
- (void)didTransact:(int)function tx:(NSString *)tx{
   //Các function
   /*
     approveToken = 1,
     approveNFT = 2,
     buyNFT = 3,
     bidNFT = 4,
     sellNFT = 5,
     cancelSell = 6,
     withdrawItem = 7,
     moveService = 8,
     transferItem = 9*/
    
}
```

#### 10. Callback didSignMessage

Khi gọi hàm  `[[ChainverseSDK shared] signMessage:@"message_can_ki"]` Callback này sẽ trả về chữ ký của message cần ký


##### Objective C
```
- (void)didSignMessage:(NSString *)signedMessage{
    
}
```

#### Full example
##### Objective C
```
#import "AppDelegate.h"
#import "Chainverse/ChainverseSDK.h"
#import "Chainverse/ChainverseSDKCallback.h"
#import "Chainverse/ChainverseItem.h"
#import "Chainverse/ChainverseNFT.h"
#import "Chainverse/ChainverseSDKError.h"
@interface AppDelegate ()<ChainverseSDKCallback>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [ChainverseSDK shared].developerAddress = @"0x690FDdc2a98050f924Bd7Ec5900f2D2F49b6aEC7";
    [ChainverseSDK shared].gameAddress = @"0x3F57BF31E55de54306543863E079aD234f477b88";
    [ChainverseSDK shared].scheme = @"your-app-scheme://";
    [ChainverseSDK shared].delegate = self;
    [[ChainverseSDK shared] initialize];
    [[ChainverseSDK shared] setIsKeepConnectWallet:TRUE];
    
    NSLog(@"ChainverSDK Verison %@",[[ChainverseSDK shared] getVersion]);
    
    return YES;
}

- (void)didInitSDKSuccess{
    
}

- (void)didConnectSuccess:(NSString *)address{
    
    ChainverseUser *info = [[ChainverseSDK shared] getUser];
    NSLog(@"nampv_caddress %@",[info address]);
    NSLog(@"nampv_csign %@",[info signature]);
}

- (void)didLogout:(NSString *)address{
    
   
}

- (void)didError:(int)error{
    switch (error) {
        case ERROR_WAITING_INIT_SDK:
            
            break;
            
        default:
            break;
    }
    NSLog(@"didError %d",error);
}


- (void)didGetDetailItem:(NFT*)item{
   
}

- (void)didItemUpdate:(ChainverseItem *)item type:(int)type{
    switch (type) {
        case TRANSFER_ITEM_TO_USER:
            //Xử lý item trong game khi item NFT chuyển tới tài khoản của bạn
            NSLog(@"nampv_transfer_to %@",item);
            break;
        case TRANSFER_ITEM_FROM_USER:
            //Xử lý item trong game khi item NFT của bạn chuyến tời tài khoản khác
            NSLog(@"nampv_transfer_from %@",item);
            break;
    }
}

- (void)didSignMessage:(NSString *)signedMessage{
    
}

- (void)didGetListItemMarket:(NSMutableArray<NFT> *) items{
    
}

- (void)didGetMyAssets:(NSMutableArray<NFT> *) items{
    
}

- (void)didTransact:(int)function tx:(NSString *)tx{
    
    
}

- (BOOL)application:(UIApplication *)app
                    openURL:(NSURL *)url
                    options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    return [[ChainverseSDK shared] handleOpenUrl:(UIApplication *)app
                              openURL:(NSURL *)url
                              options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options];
    return true;
}


@end

```


## Functions
Chainverse SDK hỗ trợ những hàm sau

#### 1. Hàm showConnectWalletView
Hàm này hiển thị màn hình để tạo hoặc import ví. 

##### Objective C
```
[[ChainverseSDK shared] showConnectWalletView];
```


#### 2. Hàm showWalletInfoView
Hàm này hiển thị màn hình thông tin của ví. Bao gồm các chức năng: Export private key, Secret Recovery Phrase.

##### Objective C
```
[[ChainverseSDK shared] showWalletInfoView];
```

#### 3. Hàm logout
Gọi hàm này để thực hiện logout. Thông tin được trả về qua callback didLogout .

##### Objective C
```
[[ChainverseSDK shared] logout];

//Delegate callback
- (void)didLogout:(NSString *)address{
   
}

```

#### 4. Hàm hứng data được trả về từ ví  Chainverse
Khi connect thành công với ví Chainverse. Chainverse sẽ mở lại app/game thông qua scheme (đã khai báo ở phần Intergrate SDK). Vì vậy cần khai báo các hàm này để Chainverse SDK xử lý dữ liệu được trả về từ ví Chainverse.
Khai báo ở file AppDeletegate :

##### Objective C
```
[[ChainverseSDK shared] handleOpenUrl:(UIApplication *)app
                              openURL:(NSURL *)url
                              options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options];

//Nếu dự án sử dụng SceneDelegate thì khai báo như sau: 

[[ChainverseSDK shared] handleOpenUrl:scene openURLContexts:URLContexts];
```


#### 5. Hàm setKeepConnect
Hàm này tuỳ chọn thiết lập trạng thái giữ connect với ví Chainverse (Khi vào lại app không cần phải kết nối lại ví) 
*true : Giữ trạng thái keep connect.
*false: Không giữ trạng thái keep connect.

##### Objective C
```
[[ChainverseSDK shared] setKeepConnect:TRUE];

```


#### 6. Hàm getVersion
Trả về version của SDK

##### Objective C
```
[[ChainverseSDK shared] getVersion]

```


#### 7. Hàm getUser
Trả về thông tin của user bao gồm : address và signature

##### Objective C
```
ChainverseUser *info = [[ChainverseSDK shared] getUser];
NSLog(@"TAG %@",[info address]);
NSLog(@"TAG %@",[info signature]);
```


#### 8. Hàm isUserConnected
Kiểm tra trạng thái connect ví của user. Trả về boolean

##### Objective C
```
[[ChainverseSDK shared] isUserConnected];

```

#### 10. Hàm getBalance
Trả về số dư Native Coin (BNB)

##### Objective C
```
[[ChainverseSDK shared] getBalance]

```

#### 11. Hàm getBalance
Trả về số dư token:
- CVT: 0x672021e3c741910896cad6D6121446a328ba5634
- USDT: 0x337610d27c682E347C9cD60BD4b3b107C9d34dDd

##### Objective C
```
[[ChainverseSDK shared] getBalance:{token}]

```


## Marketplace
Chainverse SDK hỗ trợ những hàm sau để thao tác với market place

#### 1. Hàm getListItemOnMarket
Sử dụng hàm này để lấy danh sách ITEM trong chợ. Danh sách item sẽ được trả về qua callback  didGetListItemMarket

##### Objective C
```
/*
 getListItemOnMarket: Hàm này sử dụng để lấy danh sách NFT đang được bán trên chợ
 @param NSInteger page
 @param NSInteger pageSize
 */
[[ChainverseSDK shared] getListItemOnMarket:page pageSize:pageSize];

//Callback delegate
- (void)didGetListItemMarket:(NSMutableArray<NFT> *) items{
    
}

```

#### 2. Hàm getDetailNFT
Sử dụng hàm này để lấy thông tin chi tiết của 1 item (Thông tin này là Off chain). Thông tin sẽ được trả về qua callback onGetDetailItem.

##### Objective C
```
/*
 getDetailNFT: Hàm này sử dụng để lấy thông tin chi tiết của một NFT (dữ liệu offchain)
 @param NSString nft
 @param NSInteger tokenId
 */
[[ChainverseSDK shared] getDetailNFT:@"nft" tokenId:tokenId];

//Callback delegate
- (void)didGetDetailItem:(NFT*)item{
   
}

```

#### 3. Hàm getNFT
Sử dụng hàm này để lấy thông tin chi tiết của item (thông tin on chain). Nên sử dụng hàm này để đồng bộ với thông tin off chain

##### Objective C
```
/*
 getNFT: Hàm này sử dụng để lấy thông tin chi tiết của một NFT (dữ liệu onchain)
 @param NSString nft
 @param NSInteger tokenId
 */
[[ChainverseSDK shared] getNFT:nft tokenId:tokenId complete:^(ChainverseNFT *item){
    //Xử lý ở đây    
        
}];

```

#### 4. Hàm getMyAsset
Sử dụng hàm này để lấy danh sách item user đang sở hữu (Kể cả đang được bán trên chợ). Thông tin sẽ được trả về qua callback didGetMyAssets.

##### Objective C
```
[[ChainverseSDK shared] getMyAsset];

//Callback delegate
- (void)didGetMyAssets:(NSMutableArray<NFT> *) items{
   
}

```

#### 5. Hàm approveToken
Hàm này sử dụng để approve token cho một địa chỉ. Thông tin transaction hash cũng sẽ được trả về qua callback didTransact (Khuyến khích xử lý logic trong hàm này).

##### Objective C
```
/*
 approveToken: Hàm này sử dụng để approve token cho một địa chỉ
 @param NSString token
 @param NSString amount
 */
[[ChainverseSDK shared] approveToken:@"token" amount:@"amount"]

//Callback delegate
- (void)didTransact:(int)function tx:(NSString *)tx{
     - Trả về function : approveToken = 1
     - Trả về tx: transaction hash
}

```

#### 6. Hàm isApproved(Token)
Hàm này sử dụng để lấy số lượng token mà bạn đã approved cho một địa chỉ nào đó. Thông tin transaction hash cũng sẽ được trả về qua callback didTransact (Khuyến khích xử lý logic trong hàm này).

Chú ý: Trước khi muốn mua item trên chợ, bạn cần phải approve một lượng token (không nhỏ hơn giá trị của item) cho chợ

##### Objective C
```
/*
 isApproved(Token): Hàm này sử dụng để kiểm tra token số lượng token approve vào chợ
 @param NSString token
 @param NSString owner
 */
NSString * allowence = [[ChainverseSDK shared] isApproved:TOKEN_USDT owner:info.address];
```

#### 6. Hàm buyNFT
Hàm này sử dụng để mua item đang bán trên chợ. Thông tin transaction hash cũng sẽ được trả về qua callback didTransact (Khuyến khích xử lý logic trong hàm này).

Chú ý: Nếu bạn mua bằng token, bạn cần phải kiểm tra số lượng token đã approve cho chợ bằng hàm isApproved (Token). sử dụng hàm approveToken để approve token.

Nếu không approve token trước khi mua, bạn có thể sẽ gặp lỗi sau: execution reverted: ERC20: transfer amount exceeds allowance

##### Objective C
```
/*
 buyNFT: Mua NFT trên chợ
 @param NSString currency
 @param NSInteger listingId
 @param NSString price
 */
[[ChainverseSDK shared] buyNFT:@"currency" listingId:listingId price:@"price"];

//Callback delegate
- (void)didTransact:(int)function tx:(NSString *)tx{
    - Trả về function : 3 (buyNFT)
    - Trả về tx: transaction hash
}


```


#### 7. Hàm approveNFT
Hàm này sử dụng để approve item bạn muốn bán cho chợ. Thông tin transaction hash cũng sẽ được trả về qua callback didTransact (Khuyến khích xử lý logic trong hàm này).

##### Objective C
```
/*
 approveNFT: Hàm này sử dụng để approve NFT trước khi bán lên chợ
 @param NSString nft
 @param NSInteger tokenId
 */
[[ChainverseSDK shared] approveNFT:@"nft" tokenId:tokenId];

//Callback delegate
- (void)didTransact:(int)function tx:(NSString *)tx{
    - Trả về function : 2 (approveNFT)
    - Trả về tx: transaction hash
}



```

#### 8. Hàm isApproved(NFT)
Hàm này sử dụng để kiểm tra item bạn muốn bán đã được approved cho chợ chưa.

Chú ý: Trước khi muốn bán item, bạn phải approve item đó cho chợ.

##### Objective C
```
/*
 isApproved(NFT): Hàm này sử dụng để kiểm tra NFT đã được approve hay là chưa
 @param NSString nft
 @param NSInteger tokenId
 */
BOOL isApproved = [[ChainverseSDK shared] isApproved:@"nft" tokenId:tokenId];

```


#### 9. Hàm sellNFT
Hàm này sử dụng để bán item lên chợ. Thông tin transaction hash cũng sẽ được trả về qua callback didTransact (Khuyến khích xử lý logic trong hàm này).

Chú ý: Nếu bạn muốn bán item lên chợ, bạn cần phải kiểm tra item đó đã được approved cho chợ hay chưa bằng hàm isApproved (NFT). Sử dụng hàm approveNFT để approve item.

Nếu không approve item trước khi bán, bạn có thể sẽ gặp lỗi sau: execution reverted: ERC721: transfer caller is not owner nor approved

Sau khi đăng bán thành công, NFT có thể giao dịch trên blockchain, tuy nhiên NFT vẫn chưa hiển thị ngay trên ChainVerse Market. Để NFT hiển thị trên ChainVerse Market thì cần phải gọi hàm publishNFT

##### Objective C
```
/*
 sellNFT: Hàm này sử dụng để bán item lên chợ
 @param NSString NFT
 @param NSInteger tokenId
 @param NSString price
 @param NSString currency
 */
[[ChainverseSDK shared] sellNFT:@"NFT" tokenId:tokenId price:@"price" currency:@"currency"];

//Callback delegate
- (void)didTransact:(int)function tx:(NSString *)tx{
  
    - Trả về function : 5 (sellNFT)
    - Trả về tx: transaction hash
}




```

#### 10. Hàm cancelSell
Hàm dùng để dừng bán NFT lên chợ. Thông tin trả về là transaction hash qua callback didTransact

##### Objective C
```
/*
 cancelSellNFT: Hàm này sử dụng để đừng bán NFT trên chợ
 @param NSInteger listingId
 */
[[ChainverseSDK shared] cancelSellNFT:listingId]

//Callback delegate
- (void)didTransact:(int)function tx:(NSString *)tx{
 
    - Trả về function : 6 (cancelSell),
    - Trả về tx: transaction hash
}




```


#### 11. Hàm publishNFT
Hàm dùng để publish NFT lên chợ. Hàm này trả về callback boolean isPublished

##### Objective C
```
/*
 publishNFT: Hàm này sử dụng để publish NFT lên chợ
 @param NSString nft
 @param NSInteger tokenId
 */
[[ChainverseSDK shared] publishNFT:@"nft" tokenId:tokenId complete:^(BOOL isPublished){
        
}];


```

#### 12. Hàm transferItem
Sử dụng hàm này để chuyển item sang địa chỉ ví khác. Thông tin transaction hash cũng sẽ được trả về qua callback didTransact (Khuyến khích xử lý logic trong hàm này).

##### Objective C
```
/*
 transferItem: Hàm này sử dụng để chuyển NFT sang địa chỉ khác
 @param NSString to
 @param NSString nft
 @param NSInteger tokenId
 */
[[ChainverseSDK shared] transferItem:@"to" nft:@"nft" tokenId:tokenId];


```
## Data Model
#### 1. NFT
Dữ liệu NFT

| Name  | Type | Description | 
| ------------- | ------------- | ------------- | 
| item_id  | String  | Id của item |
| token_id  | String  | Id của token |
| owner  | String  | Ví sở hữu NFT | 
| nft  | String  | Địa chỉ NFT |
| status | String  | Trạng thái |
| image | String  | Ảnh đại diện NFT |
| image_preview | String  | Ảnh đại diện NFT |
| name | String  | Tên NFT |
| attributes | String  | attributes của NFT |
| infoSell | InfoSell  | Thông tin bán NFT |
| type | Type  | Developer đang bị pause | 
| network_info | Network  | Thông tin mạng NFT |


#### 2. InfoSell
Dữ liệu InfoSell

| Name  | Type | Description | 
| ------------- | ------------- | ------------- | 
| listing_id  | String  | Listing Id của NFT khi được bán trên chợ |
| price  | String  | Giá của NFT |
| is_auction  | Bool  | Trạng thái auction | 
| currency_info  | ChainverseNFTCurrency  | Thông tin về currency |

#### 3. Currency
Dữ liệu Currency

| Name  | Type | Description | 
| ------------- | ------------- | ------------- | 
| currency | String  | Địa chỉ token currency ví dụ CVT, USDT |
| decimal  | String  | decimal |
| symbol  | String  | symbol | 

#### 4. Network
Dữ liệu Network

| Name  | Type | Description | 
| ------------- | ------------- | ------------- | 
| network | String  | Tên của mạng lưới |
| chain_id  | String  | chain_id |
| name | String  | Tên | 

#### 4. ChainverseUser
Dữ liệu Network

| Name  | Type | Description | 
| ------------- | ------------- | ------------- | 
| address | String  | Địa chỉ ví user |
| signature  | String  | signature |


## License

Chainverse SDK iOS sử dụng những thư viện sau:
##### 1. AFNetworking
- License: MIT License
- Home page: https://github.com/AFNetworking/AFNetworking
- Mục đích sử dụng: Để kết nối REST (API)
##### 2. Socket io
- License: MIT License
- Home page: https://socket.io/
- Mục đích sử dụng: Xử lý realtime
##### 3. Web3swift 
- License: MIT License
- Home page: https://github.com/skywinder/web3swift
- Mục đích sử dụng: Kết nối blockchain
##### 4. PromiseKit
- License: MIT License
- Home page: https://github.com/mxcl/PromiseKit
- Mục đích sử dụng: Xử lý bất đồng bộ/đồng bộ khi kết nối API, blockchain
