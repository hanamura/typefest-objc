#import "TFSelectableRow.h"

@implementation TFSelectableRow

+ (id)row
{
    return [[[TFSelectableRow alloc] init] autorelease];
}

+ (id)rowWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[[TFSelectableRow alloc] initWithStyle:style title:title detailTitle:detailTitle reuseIdentifier:reuseIdentifier] autorelease];
}

+ (id)rowWithStyle:(UITableViewCellStyle)style title:(NSString *)title detailTitle:(NSString *)detailTitle reuseIdentifier:(NSString *)reuseIdentifier accessoryType:(UITableViewCellAccessoryType)accessoryType target:(id)target action:(SEL)action data:(id)data
{
    return [[[TFSelectableRow alloc] initWithStyle:style title:title detailTitle:detailTitle reuseIdentifier:reuseIdentifier accessoryType:accessoryType target:target action:action data:data] autorelease];
}

+ (id)disclosuerRowWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action
{
    return [[[TFSelectableRow alloc] initDisclosuerWithTitle:title detailTitle:detailTitle target:target action:action] autorelease];
}

+ (id)disclosuerRowWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[[TFSelectableRow alloc] initDisclosuerWithTitle:title detailTitle:detailTitle target:target action:action reuseIdentifier:reuseIdentifier] autorelease];
}

+ (id)rowWithPrivateCell:(UITableViewCell *)privateCell
{
    return [[[TFSelectableRow alloc] initWithPrivateCell:privateCell] autorelease];
}

+ (id)rowWithTitle:(NSString *)title data:(id)data selected:(BOOL)selected
{
    return [[[TFSelectableRow alloc] initWithTitle:title data:data selected:selected] autorelease];
}

+ (id)rowWithTitle:(NSString *)title data:(id)data selected:(BOOL)selected target:(id)target action:(SEL)actions
{
    return [[[TFSelectableRow alloc] initWithTitle:title data:data selected:selected target:target action:actions] autorelease];
}

@synthesize selected=_selected;
@synthesize autoSelect=_autoSelect;
@synthesize autoDeselect=_autoDeselect;

// init/dealloc
- (id)init
{
    self = [super init];
    if (self) {
        _selected = NO;
        _autoSelect = YES;
        _autoDeselect = NO;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title data:(id)data selected:(BOOL)selected
{
    self = [self init];
    if (self) {
        self.title = title;
        self.data = data;
        self.selected = selected;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title data:(id)data selected:(BOOL)selected target:(id)target action:(SEL)action
{
    self = [self init];
    if (self) {
        self.title = title;
        self.data = data;
        self.selected = selected;
        self.target = target;
        self.action = action;
    }
    return self;
}

- (void)dealloc
{
    [_delegates release];
    [super dealloc];
}

// getter/setter
- (void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
        
        for (id delegate in _delegates) {
            if ([delegate respondsToSelector:@selector(selectionChanged:)]) {
                [delegate performSelector:@selector(selectionChanged:) withObject:self];
            }
        }
    }
}

- (NSMutableArray *)delegates
{
    if (!_delegates) {
        _delegates = [[TFActiveCollectionUtils nonRetainingArray] retain];
    }
    return _delegates;
}


// overrides
- (void)setupCell:(UITableViewCell *)cell
{
    cell.textLabel.text = _title;
    cell.detailTextLabel.text = _detailTitle;
    cell.accessoryType = _selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    cell.accessoryView = _accessoryView;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_autoSelect && !self.selected) {
        self.selected = YES;
    } else if (_autoDeselect && self.selected) {
        self.selected = NO;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

// copyWithZone
- (id)copyWithZone:(NSZone *)zone
{
    TFSelectableRow *row = [super copyWithZone:zone];
    row.selected = _selected;
    row.autoSelect = _autoSelect;
    row.autoDeselect = _autoDeselect;
    return row;
}

@end
