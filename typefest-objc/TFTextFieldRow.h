#import <UIKit/UIKit.h>
#import "TFRow.h"

@interface TFTextFieldRow : TFRow
{
    
}

+ (id)rowWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly) UITextField *textField;

- (id)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier;

@end
