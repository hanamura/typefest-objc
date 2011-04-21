#import "TFActiveCollectionUtils.h"

@implementation TFActiveCollectionUtils

+ (NSMutableArray *)nonRetainingArray
{
    CFArrayCallBacks callbacks = kCFTypeArrayCallBacks;
    callbacks.retain = NULL;
    callbacks.release = NULL;
    NSMutableArray *array = (NSMutableArray*)CFArrayCreateMutable(NULL, 0, &callbacks);
    return [array autorelease];
}

@end
