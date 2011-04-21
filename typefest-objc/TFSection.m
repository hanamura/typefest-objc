#import "TFSection.h"

@implementation TFSection

+ (id)section
{
    return [[[TFSection alloc] init] autorelease];
}

+ (id)sectionWithTitleForHeader:(NSString *)titleForHeader titleForFooter:(NSString *)titleForFooter
{
    return [[[TFSection alloc] initWithTitleForHeader:titleForHeader titleForFooter:titleForFooter] autorelease];
}

@synthesize titleForHeader=_titleForHeader;
@synthesize titleForFooter=_titleForFooter;

// init/dealloc
- (id)init
{
    return [self initWithTitleForHeader:nil titleForFooter:nil];
}

- (id)initWithTitleForHeader:(NSString *)titleForHeader titleForFooter:(NSString *)titleForFooter
{
    self = [super init];
    if (self) {
        self.titleForHeader = titleForHeader;
        self.titleForFooter = titleForFooter;
    }
    return self;
}

- (void)dealloc
{
    [_titleForHeader release];
    [_titleForFooter release];
    [super dealloc];
}

// UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return tableView.sectionFooterHeight;
}

@end
