#import <Foundation/Foundation.h>
#import "TFActiveCollectionProtocol.h"
#import "TFActiveCollectionDelegate.h"

@interface TFActiveSet : NSMutableSet <TFActiveCollectionProtocol, TFActiveCollectionDelegate>
{
    NSMutableSet *_storage;
    
    BOOL _notificationEnabled;
    NSInteger _notificationDepth;
    NSMutableArray *_delegates;
}

@property (assign) BOOL notificationEnabled;
@property (assign) NSInteger notificationDepth;
@property (nonatomic, readonly) NSMutableArray *delegates;

@end
