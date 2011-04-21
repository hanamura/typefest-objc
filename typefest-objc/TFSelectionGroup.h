#import "TFSection.h"
#import "TFSelectableRow.h"

// TFSelectionGroup
@interface TFSelectionGroup : TFSection <TFSelectableRowDelegate>
{
    NSMutableArray *_groupDelegates;
}

+ (id)group;

@property (nonatomic, readonly) TFSelectableRow *row;
@property (nonatomic, readonly) NSMutableArray *groupDelegates;

@end



// TFSelectionGroupDelegate
@protocol TFSelectionGroupDelegate <NSObject>
@optional
- (void)selectionChanged:(TFSelectionGroup *)group deselectedRow:(TFSelectableRow *)row;
@end