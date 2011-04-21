#import <UIKit/UIKit.h>
#import "TFActiveArray.h"

@interface TFSection : TFActiveArray
{
    NSString *_titleForHeader;
    NSString *_titleForFooter;
}

+ (id)section;
+ (id)sectionWithTitleForHeader:(NSString *)titleForHeader titleForFooter:(NSString *)titleForFooter;

@property (nonatomic, retain) NSString *titleForHeader;
@property (nonatomic, retain) NSString *titleForFooter;

- (id)initWithTitleForHeader:(NSString *)titleForHeader titleForFooter:(NSString *)titleForFooter;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

@end
