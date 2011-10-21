#import <Foundation/Foundation.h>
#import "TFActiveCollectionProtocol.h"
#import "TFActiveCollectionDelegate.h"



// TFActiveSet
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

// private
- (void)addObserverToObject:(id)object;
- (void)removeObserverFromObject:(id)object;
- (void)setDidChange:(id)added removed:(id)removed;
- (void)postNotification:(TFActiveCollectionInfo *)info;

@end
