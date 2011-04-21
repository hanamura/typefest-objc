#import <Foundation/Foundation.h>

@protocol TFActiveCollectionProtocol <NSObject>

@property (assign) BOOL notificationEnabled;
@property (assign) NSInteger notificationDepth;
@property (nonatomic, readonly) NSMutableArray *delegates;

@end
