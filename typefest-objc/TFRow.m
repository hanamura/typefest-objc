#import "TFRow.h"

@interface TFRow ()
- (void)setupCell:(UITableViewCell *)cell;
@end

@implementation TFRow

+ (id)row
{
    return [[[TFRow alloc] init] autorelease];
}

+ (id)rowWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[[TFRow alloc] initWithStyle:style title:title detailTitle:detailTitle reuseIdentifier:reuseIdentifier] autorelease];
}

+ (id)rowWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier accessoryType:(UITableViewCellAccessoryType)accessoryType target:(id)target action:(SEL)action data:(id)data
{
    return [[[TFRow alloc] initWithStyle:style title:title detailTitle:detailTitle reuseIdentifier:reuseIdentifier accessoryType:accessoryType target:target action:action data:data] autorelease];
}

+ (id)disclosureRowWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action
{
    return [[[TFRow alloc] initDisclosureWithTitle:title detailTitle:detailTitle target:target action:action] autorelease];
}

+ (id)disclosureRowWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[[TFRow alloc] initDisclosureWithTitle:title detailTitle:detailTitle target:target action:action reuseIdentifier:reuseIdentifier] autorelease];
}

+ (id)rowWithPrivateCell:(UITableViewCell *)privateCell
{
    return [[[TFRow alloc] initWithPrivateCell:privateCell] autorelease];
}

@synthesize style=_style;
@synthesize title=_title;
@synthesize detailTitle=_detailTitle;
@synthesize reuseIdentifier=_reuseIdentifier;
@synthesize accessoryType=_accessoryType;
@synthesize accessoryView=_accessoryView;
@synthesize target=_target;
@synthesize action=_action;
@synthesize accessoryTarget=_accessoryTarget;
@synthesize accessoryAction=_accessoryAction;
@synthesize editingTarget=_editingTarget;
@synthesize editingDeleteAction=_editingDeleteAction;
@synthesize editingInsertAction=_editingInsertAction;
@synthesize data=_data;
@synthesize privateCell=_privateCell;
@synthesize editable=_editable;
@synthesize movable=_movable;
@synthesize editingStyle=_editingStyle;

// init/dealloc
- (id)init
{
    self = [super init];
    if (self) {
        self.style = UITableViewCellStyleDefault;
        self.reuseIdentifier = NSStringFromClass([self class]);
        self.accessoryType = UITableViewCellAccessoryNone;
        self.editable = YES;
        self.movable = YES;
        self.editingStyle = UITableViewCellEditingStyleDelete;
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:style title:title detailTitle:detailTitle reuseIdentifier:reuseIdentifier accessoryType:UITableViewCellAccessoryNone target:nil action:NULL data:nil];
}

- (id)initWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier accessoryType:(UITableViewCellAccessoryType)accessoryType target:(id)target action:(SEL)action data:(id)data
{
    self = [self init];
    if (self) {
        self.style = style;
        self.title = title;
        self.detailTitle = detailTitle;
        self.reuseIdentifier = reuseIdentifier;
        self.accessoryType = accessoryType;
        self.target = target;
        self.action = action;
        self.data = data;
    }
    return self;
}

- (id)initDisclosureWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action
{
    return [self initDisclosureWithTitle:title detailTitle:detailTitle target:target action:action reuseIdentifier:NSStringFromClass([self class])];
}

- (id)initDisclosureWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self init];
    if (self) {
        self.style = UITableViewCellStyleValue1;
        self.title = title;
        self.detailTitle = detailTitle;
        self.reuseIdentifier = reuseIdentifier;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.target = target;
        self.action = action;
    }
    return self;
}

- (id)initWithPrivateCell:(UITableViewCell *)privateCell
{
    self = [self init];
    if (self) {
        self.reuseIdentifier = privateCell.reuseIdentifier;
        self.accessoryType = privateCell.accessoryType;
        self.privateCell = privateCell;
    }
    return self;
}

- (void)dealloc
{
    [_title release];
    [_detailTitle release];
    [_reuseIdentifier release];
    [_accessoryView release];
    [_data release];
    [_privateCell release];
    [super dealloc];
}



// responsibility
- (BOOL)isResponsibleToAction
{
    return !!_target && [_target respondsToSelector:_action];
}

- (BOOL)isResponsibleToAccessoryAction
{
    return !!_accessoryTarget && [_accessoryTarget respondsToSelector:_accessoryAction];
}

// NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    TFRow *row = [[[self class] allocWithZone:zone] init];
    row.style = _style;
    row.title = _title;
    row.detailTitle = _detailTitle;
    row.reuseIdentifier = _reuseIdentifier;
    row.accessoryType = _accessoryType;
    row.accessoryView = _accessoryView;
    row.target = _target;
    row.action = _action;
    row.accessoryTarget = _accessoryTarget;
    row.accessoryAction = _accessoryAction;
    row.editingTarget = _editingTarget;
    row.editingDeleteAction = _editingDeleteAction;
    row.editingInsertAction = _editingInsertAction;
    row.data = _data;
    row.editable = _editable;
    row.movable = _movable;
    row.editingStyle = _editingStyle;
    return row;
}



// UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    // try private cell
    cell = self.privateCell;
    
    // try dequeue from tableView
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier];
    }
    
    // create cell yourself
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:_style reuseIdentifier:_reuseIdentifier] autorelease];
    }
    
    [self setupCell:cell];
    
    return cell;
}

- (void)setupCell:(UITableViewCell *)cell
{
    cell.textLabel.text = _title;
    cell.detailTextLabel.text = _detailTitle;
    cell.accessoryType = _accessoryType;
    cell.accessoryView = _accessoryView;
    cell.showsReorderControl = _movable;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_editingTarget) {
        return;
    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([_editingTarget respondsToSelector:_editingDeleteAction]) {
            [_editingTarget performSelector:_editingDeleteAction withObject:self];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        if ([_editingTarget respondsToSelector:_editingInsertAction]) {
            [_editingTarget performSelector:_editingInsertAction withObject:self];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _editable;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _movable;
}



// UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([self isResponsibleToAccessoryAction]) {
        [_accessoryTarget performSelector:_accessoryAction withObject:self];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self isResponsibleToAction] ? indexPath : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isResponsibleToAction]) {
        [_target performSelector:_action withObject:self];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _editingStyle;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
