#import "TFActiveArray.h"
#import "TFActiveCollectionInfo.h"
#import "TFActiveCollectionUtils.h"

@interface TFActiveArray ()
- (void)addObserverToObject:(id)object;
- (void)removeObserverFromObject:(id)object;
- (void)arrayDidChange:(NSUInteger)index added:(id)added removed:(id)removed;
- (void)postNotification:(TFActiveCollectionInfo *)info;
@end

@implementation TFActiveArray

+ (id)array
{
    return [[[TFActiveArray alloc] init] autorelease];
}

@synthesize notificationEnabled=_notificationEnabled;
@synthesize notificationDepth=_notificationDepth;
@synthesize delegates=_delegates;

// init/dealloc
- (id)init
{
    self = [super init];
    if (self) {
        _storage = [[NSMutableArray alloc] init];
        
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

// NSArray
- (NSUInteger)count
{
    return [_storage count];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [_storage objectAtIndex:index];
}

// NSMutableArray
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    [self addObserverToObject:anObject];
    [_storage insertObject:anObject atIndex:index];
    [self arrayDidChange:index added:anObject removed:nil];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    id removed = [[[self objectAtIndex:index] retain] autorelease];
    [self removeObserverFromObject:[self objectAtIndex:index]];
    [_storage removeObjectAtIndex:index];
    [self arrayDidChange:index added:nil removed:removed];
}

- (void)addObject:(id)anObject
{
    [self addObserverToObject:anObject];
    [_storage addObject:anObject];
    [self arrayDidChange:([self count] - 1) added:anObject removed:nil];
}

- (void)removeLastObject
{
    id removed = [[[self lastObject] retain] autorelease];
    [self removeObserverFromObject:[self lastObject]];
    [_storage removeLastObject];
    [self arrayDidChange:[self count] added:nil removed:removed];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    id removed = [[[self objectAtIndex:index] retain] autorelease];
    [self removeObserverFromObject:[self objectAtIndex:index]];
    [self addObserverToObject:anObject];
    [_storage replaceObjectAtIndex:index withObject:anObject];
    [self arrayDidChange:index added:anObject removed:removed];
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
        [[object delegates] removeObject:self];
    }
}

// events
- (void)objectDidChange:(id<TFActiveCollectionProtocol>)sender
                   info:(TFActiveCollectionInfo *)info
{
    if ([self containsObject:sender]) {
        info = [info copy];
        info.depth++;
        [self postNotification:info];
    }
}

- (void)arrayDidChange:(NSUInteger)index added:(id)added removed:(id)removed
{
    [self postNotification:[TFActiveArrayInfo
                            infoWithSource:self
                            type:TFActiveArrayInfoChange
                            depth:0
                            index:index
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
