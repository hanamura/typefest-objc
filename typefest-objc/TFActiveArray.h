#import <Foundation/Foundation.h>
#import "TFActiveCollectionProtocol.h"
#import "TFActiveCollectionDelegate.h"



// TFActiveArray
@interface TFActiveArray : NSMutableArray <TFActiveCollectionProtocol, TFActiveCollectionDelegate>
{
    NSMutableArray *_storage;
    
    BOOL _notificationEnabled;
    NSInteger _notificationDepth;
    NSMutableArray *_delegates;
}

@property (assign) BOOL notificationEnabled;
@property (assign) NSInteger notificationDepth;
@property (nonatomic, readonly) NSMutableArray *delegates;

// private
- (void)arrayDidChange:(NSUInteger)index added:(id)added removed:(id)removed;
- (void)addObserverToObject:(id)object;
- (void)removeObserverFromObject:(id)object;
- (void)postNotification:(TFActiveCollectionInfo *)info;

@end
