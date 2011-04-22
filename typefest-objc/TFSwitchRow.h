#import <UIKit/UIKit.h>
#import "TFRow.h"

@interface TFSwitchRow : TFRow
{
    
}

+ (id)rowWithTitle:(NSString *)title reuseIdentifer:(NSString *)reuseIdentifer;

@property (nonatomic, readonly) UISwitch *switchButton;

- (id)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier;

@end
