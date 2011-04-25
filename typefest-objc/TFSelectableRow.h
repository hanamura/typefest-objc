#import "TFActiveCollectionUtils.h"
#import "TFRow.h"

// TFSelectableRow
@interface TFSelectableRow : TFRow
{
    BOOL _selected;
    NSMutableArray *_delegates;
    BOOL _autoSelect;
    BOOL _autoDeselect;
}

+ (id)rowWithTitle:(NSString *)title data:(id)data selected:(BOOL)selected;
+ (id)rowWithTitle:(NSString *)title data:(id)data selected:(BOOL)selected target:(id)target action:(SEL)action;
+ (void)selectCell:(UITableViewCell *)cell;
+ (void)deselectCell:(UITableViewCell *)cell;

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, readonly) NSMutableArray *delegates;
@property (assign) BOOL autoSelect;
@property (assign) BOOL autoDeselect;

- (id)initWithTitle:(NSString *)title data:(id)data selected:(BOOL)selected;
- (id)initWithTitle:(NSString *)title data:(id)data selected:(BOOL)selected target:(id)target action:(SEL)action;

@end



// TFSelectableRow
@protocol TFSelectableRowDelegate <NSObject>
@optional
- (void)selectionChanged:(TFSelectableRow *)row;
@end
