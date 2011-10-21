#import <Foundation/Foundation.h>
#import "TFActiveCollectionProtocol.h"
#import "TFActiveCollectionDelegate.h"



// TFActiveDictionary
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

// private
- (void)addObserverToObject:(id)object;
- (void)removeObserverFromObject:(id)object;
- (void)dictionaryDidChange:(id)key prev:(id)prev;
- (void)postNotification:(TFActiveCollectionInfo *)info;

@end
