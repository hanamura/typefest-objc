#import <UIKit/UIKit.h>



// TFRow
@interface TFRow : NSObject <NSCopying>
{
    UITableViewCellStyle _style;
    NSString *_title;
    NSString *_detailTitle;
    NSString *_reuseIdentifier;
    UITableViewCellAccessoryType _accessoryType;
    UIView *_accessoryView;
    id _target;
    SEL _action;
    id _accessoryTarget;
    SEL _accessoryAction;
    id _editingTarget;
    SEL _editingDeleteAction;
    SEL _editingInsertAction;
    id _data;
    UITableViewCell *_privateCell;
    BOOL _editable;
    BOOL _movable;
    UITableViewCellEditingStyle _editingStyle;
}

+ (id)row;
+ (id)rowWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier;
+ (id)rowWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier accessoryType:(UITableViewCellAccessoryType)accessoryType target:(id)target action:(SEL)action data:(id)data;
+ (id)disclosureRowWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action;
+ (id)disclosureRowWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action reuseIdentifier:(NSString *)reuseIdentifier;
+ (id)rowWithPrivateCell:(UITableViewCell *)privateCell;

@property (assign) UITableViewCellStyle style;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *detailTitle;
@property (nonatomic, retain) NSString *reuseIdentifier;
@property (assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, retain) UIView *accessoryView;
@property (nonatomic, assign) id target;
@property (assign) SEL action;
@property (nonatomic, assign) id accessoryTarget;
@property (assign) SEL accessoryAction;
@property (nonatomic, assign) id editingTarget;
@property (assign) SEL editingDeleteAction;
@property (assign) SEL editingInsertAction;
@property (nonatomic, retain) id data;
@property (nonatomic, retain) UITableViewCell *privateCell;
@property (assign) BOOL editable;
@property (assign) BOOL movable;
@property (assign) UITableViewCellEditingStyle editingStyle;

// init
- (id)initWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier;
- (id)initWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier accessoryType:(UITableViewCellAccessoryType)accessoryType target:(id)target action:(SEL)action data:(id)data;
- (id)initDisclosureWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action;
- (id)initDisclosureWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action reuseIdentifier:(NSString *)reuseIdentifier;
- (id)initWithPrivateCell:(UITableViewCell *)privateCell;

// private
- (void)setupCell:(UITableViewCell *)cell;

// responsibility
- (BOOL)isResponsibleToAction;
- (BOOL)isResponsibleToAccessoryAction;

// UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

// UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;

@end
