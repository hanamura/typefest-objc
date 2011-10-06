#import "TFActiveSet.h"
#import "TFActiveCollectionUtils.h"

@interface TFActiveSet ()
- (void)addObserverToObject:(id)object;
- (void)removeObserverFromObject:(id)object;
- (void)setDidChange:(id)added removed:(id)removed;
- (void)postNotification:(TFActiveCollectionInfo *)info;
@end

@implementation TFActiveSet

+ (id)set
{
    return [[[TFActiveSet alloc] init] autorelease];
}

@synthesize notificationEnabled=_notificationEnabled;
@synthesize notificationDepth=_notificationDepth;
@synthesize delegates=_delegates;

// init/dealloc
- (id)init
{
    self = [super init];
    if (self) {
        _storage = [[NSMutableSet alloc] init];
        
        _notificationEnabled = YES;
        _notificationDepth = 0;
        _delegates = [[TFActiveCollectionUtils nonRetainingArray] retain];
    }
    return self;
}

- (void)dealloc
{
    for (id object in _storage) {
        [self removeObserverFromObject:object];
    }
    [_storage release];
    _storage = nil;
    [_delegates release];
    _delegates = nil;
    
    [super dealloc];
}

// NSSet
- (NSUInteger)count
{
    return [_storage count];
}

- (id)member:(id)object
{
    return [_storage member:object];
}

- (NSEnumerator *)objectEnumerator
{
    return [_storage objectEnumerator];
}

// NSMutableSet
- (void)addObject:(id)object
{
    [self addObserverToObject:object];
    [_storage addObject:object];
    [self setDidChange:object removed:nil];
}

- (void)removeObject:(id)object
{
    [self removeObserverFromObject:object];
    [_storage removeObject:object];
    [self setDidChange:nil removed:[[object retain] autorelease]];
}

// observe
- (void)addObserverToObject:(id)object
{
    if ([object conformsToProtocol:@protocol(TFActiveCollectionProtocol)]) {
        [[object delegates] addObject:self];
    }
}

- (void)removeObserverFromObject:(id)object
{
    if ([object conformsToProtocol:@protocol(TFActiveCollectionProtocol)]) {
        [[object delegates] addObject:self];
    }
}

// events
- (void)objectDidChange:(id<TFActiveCollectionProtocol>)sender
                   info:(TFActiveCollectionInfo *)info
{
    info = [info copy];
    info.depth++;
    [self postNotification:info];
}

- (void)setDidChange:(id)added removed:(id)removed
{
    NSString *type = nil;
    
    if (added) {
        type = TFActiveSetInfoAdd;
    } else if (removed) {
        type = TFActiveSetInfoRemove;
    }
    
    [self postNotification:[TFActiveSetInfo
                            infoWithSource:self
                            type:type
                            depth:0
                            added:added
                            removed:removed]];
}

- (void)postNotification:(TFActiveCollectionInfo *)info
{
    if (_notificationEnabled && (_notificationDepth < 0 || info.depth <= _notificationDepth)) {
        for (id delegate in [NSArray arrayWithArray:_delegates]) {
            if (!_delegates) {
                return;
            }
            if ([_delegates containsObject:delegate] && [delegate respondsToSelector:@selector(objectDidChange:info:)]) {
                [delegate performSelector:@selector(objectDidChange:info:) withObject:self withObject:info];
            }
        }
    }
}

@end
