#import <Foundation/Foundation.h>
#import "TFActiveCollectionProtocol.h"

// TFActiveCollectionInfo
@interface TFActiveCollectionInfo : NSObject <NSCopying>
{
    id<TFActiveCollectionProtocol> _source;
    NSString *_type;
    NSInteger _depth;
}

+ (id)infoWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth;

@property (nonatomic, retain) id<TFActiveCollectionProtocol> source;
@property (nonatomic, retain) NSString *type;
@property (assign) NSInteger depth;

- (id)initWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth;
- (id)copyWithZone:(NSZone *)zone;

@end



// TFActiveArrayInfo
extern NSString * const TFActiveArrayInfoChange;

@interface TFActiveArrayInfo : TFActiveCollectionInfo
{
    NSUInteger _index;
    id _added;
    id _removed;
}

+ (id)infoWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
               index:(NSUInteger)index
               added:(id)added removed:(id)removed;

@property (assign) NSUInteger index;
@property (nonatomic, retain) id added;
@property (nonatomic, retain) id removed;

- (id)initWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
               index:(NSUInteger)index
               added:(id)added removed:(id)removed;

@end



// TFActiveDictionaryInfo
extern NSString * const TFActiveDictionaryInfoSet;
extern NSString * const TFActiveDictionaryInfoChange;
extern NSString * const TFActiveDictionaryInfoRemove;

@interface TFActiveDictionaryInfo : TFActiveCollectionInfo
{
    id _key;
    id _prev;
    id _curr;
}

+ (id)infoWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
                 key:(id)key prev:(id)prev curr:(id)curr;

@property (nonatomic, retain) id key;
@property (nonatomic, retain) id prev;
@property (nonatomic, retain) id curr;

- (id)initWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
                 key:(id)key prev:(id)prev curr:(id)curr;

@end



// TFActiveSetInfo
extern NSString * const TFActiveSetInfoAdd;
extern NSString * const TFActiveSetInfoRemove;

@interface TFActiveSetInfo : TFActiveCollectionInfo
{
    id _added;
    id _removed;
}

+ (id)infoWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
               added:(id)added removed:(id)removed;

@property (nonatomic, retain) id added;
@property (nonatomic, retain) id removed;

- (id)initWithSource:(id<TFActiveCollectionProtocol>)source
                type:(NSString *)type depth:(NSInteger)depth
               added:(id)added removed:(id)removed;

@end