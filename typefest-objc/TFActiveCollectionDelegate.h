#import <Foundation/Foundation.h>
#import "TFActiveCollectionProtocol.h"
#import "TFActiveCollectionInfo.h"

@protocol TFActiveCollectionDelegate <NSObject>

- (void)objectDidChange:(id<TFActiveCollectionProtocol>)sender info:(TFActiveCollectionInfo *)info;

@end
