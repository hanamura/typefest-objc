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

+ (id)disclosureRowWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action
{
    return [[[TFSelectableRow alloc] initDisclosureWithTitle:title detailTitle:detailTitle target:target action:action] autorelease];
}

+ (id)disclosureRowWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle target:(id)target action:(SEL)action reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[[TFSelectableRow alloc] initDisclosureWithTitle:title detailTitle:detailTitle target:target action:action reuseIdentifier:reuseIdentifier] autorelease];
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

+ (void)selectCell:(UITableViewCell *)cell
{
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    [[cell textLabel] setTextColor:[UIColor
                                    colorWithRed:0x38 / 255.0f
                                    green:0x54 / 255.0f
                                    blue:0x87 / 255.0f
                                    alpha:1.0]];
}

+ (void)deselectCell:(UITableViewCell *)cell
{
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [[cell textLabel] setTextColor:[UIColor darkTextColor]];
}

@synthesize selected=_selected;
@synthesize autoSelect=_autoSelect;
@synthesize autoDeselect=_autoDeselect;
@synthesize delegates=_delegates;

// init/dealloc
- (id)init
{
    self = [super init];
    if (self) {
        _selected = NO;
        _autoSelect = YES;
        _autoDeselect = NO;
        _delegates = [[TFActiveCollectionUtils nonRetainingArray] retain];
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
        
        [self retain];
        
        for (id delegate in [NSArray arrayWithArray:_delegates]) {
            if ([_delegates containsObject:delegate] && [delegate respondsToSelector:@selector(selectionChanged:)]) {
                [delegate performSelector:@selector(selectionChanged:) withObject:self];
            }
        }
        
        [self release];
    }
}

// overrides
- (void)setupCell:(UITableViewCell *)cell
{
    [super setupCell:cell];
    
    if (_selected) {
        [TFSelectableRow selectCell:cell];
    } else {
        [TFSelectableRow deselectCell:cell];
    }
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
