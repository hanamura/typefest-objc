#import "TFActiveDictionary.h"
#import "TFActiveCollectionUtils.h"
#import "TFActiveCollectionInfo.h"

@interface TFActiveDictionary ()
- (void)addObserverToObject:(id)object;
- (void)removeObserverFromObject:(id)object;
- (void)dictionaryDidChange:(id)key prev:(id)prev;
- (void)postNotification:(TFActiveCollectionInfo *)info;
@end

@implementation TFActiveDictionary

+ (id)dictionary
{
    return [[[TFActiveDictionary alloc] init] autorelease];
}

@synthesize notificationEnabled=_notificationEnabled;
@synthesize notificationDepth=_notificationDepth;
@synthesize delegates=_delegates;

// init/dealloc
- (id)init
{
    self = [super init];
    if (self) {
        _storage = [[NSMutableDictionary alloc] init];
        
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

// NSDictionary
- (NSUInteger)count
{
    return [_storage count];
}

- (id)objectForKey:(id)aKey
{
    return [_storage objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator
{
    return [_storage keyEnumerator];
}

// NSMutableDictionary
- (void)setObject:(id)anObject forKey:(id)aKey
{
    id prev = [[[_storage objectForKey:aKey] retain] autorelease];
    [self addObserverToObject:anObject];
    [_storage setObject:anObject forKey:aKey];
    [self dictionaryDidChange:aKey prev:prev];
}

- (void)removeObjectForKey:(id)aKey
{
    id prev = [[[_storage objectForKey:aKey] retain] autorelease];
    [self removeObserverFromObject:[_storage objectForKey:aKey]];
    [_storage removeObjectForKey:aKey];
    [self dictionaryDidChange:aKey prev:prev];
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
    info = [info copy];
    info.depth++;
    [self postNotification:info];
}

- (void)dictionaryDidChange:(id)key prev:(id)prev
{
    id curr = [_storage objectForKey:key];
    
    NSString *type;
    
    if (prev && curr) {
        if (prev == curr) {
            return;
        } else {
            type = TFActiveDictionaryInfoChange;
        }
    } else if (prev) {
        type = TFActiveDictionaryInfoRemove;
    } else if (curr) {
        type = TFActiveDictionaryInfoSet;
    } else {
        return;
    }
    
    [self postNotification:[TFActiveDictionaryInfo
                            infoWithSource:self
                            type:type
                            depth:0
                            key:key
                            prev:prev
                            curr:curr]];
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
