#import <Foundation/Foundation.h>
#import "TFActiveCollectionProtocol.h"
#import "TFActiveCollectionDelegate.h"

@interface TFActiveDictionary : NSMutableDictionary <TFActiveCollectionProtocol, TFActiveCollectionDelegate>
{
    NSMutableDictionary *_storage;
    
    BOOL _notificationEnabled;
    NSInteger _notificationDepth;
    NSMutableArray *_delegates;
}

@property (assign) BOOL notificationEnabled;
@property (assign) NSInteger notificationDepth;
@property (nonatomic, readonly) NSMutableArray *delegates;

@end
