#import "TFActiveCollectionInfo.h"

// TFActiveCollectionInfo
@implementation TFActiveCollectionInfo

+ (id)infoWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
{
    return [[[TFActiveCollectionInfo alloc]
             initWithSource:source
             type:type
             depth:depth] autorelease];
}

@synthesize source=_source;
@synthesize type=_type;
@synthesize depth=_depth;

- (id)initWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
{
    self = [super init];
    if (self) {
        self.source = source;
        self.type = type;
        self.depth = depth;
    }
    return self;
}

- (void)dealloc
{
    [_source release];
    [_type release];
    [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
    TFActiveCollectionInfo *info = [[[self class] allocWithZone:zone]
                                    initWithSource:_source
                                    type:_type
                                    depth:_depth];
    return info;
}

@end



// TFActiveArrayInfo
@implementation TFActiveArrayInfo

NSString * const TFActiveArrayInfoChange = @"change";

+ (id)infoWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
               index:(NSUInteger)index added:(id)added removed:(id)removed
{
    return [[[TFActiveArrayInfo alloc]
             initWithSource:source
             type:type
             depth:depth
             index:index
             added:added
             removed:removed] autorelease];
}

@synthesize index=_index;
@synthesize added=_added;
@synthesize removed=_removed;

- (id)initWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
               index:(NSUInteger)index added:(id)added removed:(id)removed
{
    self = [super initWithSource:source type:type depth:depth];
    if (self) {
        self.index = index;
        self.added = added;
        self.removed = removed;
    }
    return self;
}

- (void)dealloc
{
    [_added release];
    [_removed release];
    [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
    TFActiveArrayInfo *info = [super copyWithZone:zone];
    info.index = _index;
    info.added = _added;
    info.removed = _removed;
    return info;
}

@end



// TFActiveDictionaryInfo
@implementation TFActiveDictionaryInfo

NSString * const TFActiveDictionaryInfoSet = @"set";
NSString * const TFActiveDictionaryInfoChange = @"change";
NSString * const TFActiveDictionaryInfoRemove = @"remove";

+ (id)infoWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
                 key:(id)key prev:(id)prev curr:(id)curr
{
    return [[[TFActiveDictionaryInfo alloc]
             initWithSource:source
             type:type
             depth:depth
             key:key
             prev:prev
             curr:curr] autorelease];
}

@synthesize key=_key;
@synthesize prev=_prev;
@synthesize curr=_curr;

- (id)initWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
                 key:(id)key prev:(id)prev curr:(id)curr
{
    self = [super initWithSource:source type:type depth:depth];
    if (self) {
        self.key = key;
        self.prev = prev;
        self.curr = curr;
    }
    return self;
}

- (void)dealloc
{
    [_key release];
    [_prev release];
    [_curr release];
    [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
    TFActiveDictionaryInfo *info = [super copyWithZone:zone];
    info.key = _key;
    info.prev = _prev;
    info.curr = _curr;
    return info;
}

@end



// TFActiveSetInfo
@implementation TFActiveSetInfo

NSString * const TFActiveSetInfoAdd = @"add";
NSString * const TFActiveSetInfoRemove = @"remove";

+ (id)infoWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
               added:(id)added removed:(id)removed
{
    return [[[TFActiveSetInfo alloc]
             initWithSource:source
             type:type
             depth:depth
             added:added
             removed:removed] autorelease];
}

@synthesize added=_added;
@synthesize removed=_removed;

- (id)initWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
               added:(id)added removed:(id)removed
{
    self = [super initWithSource:source type:type depth:depth];
    if (self) {
        self.added = added;
        self.removed = removed;
    }
    return self;
}

- (void)dealloc
{
    [_added release];
    [_removed release];
    [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
    TFActiveSetInfo *info = [super copyWithZone:zone];
    info.added = _added;
    info.removed = _removed;
    return info;
}

@end