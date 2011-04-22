#import "TFTextFieldRow.h"

@implementation TFTextFieldRow

+ (id)row
{
    return [[[TFTextFieldRow alloc] init] autorelease];
}

+ (id)rowWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[[TFTextFieldRow alloc] initWithTitle:title reuseIdentifier:reuseIdentifier] autorelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        UITextField *field = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 180, 21)] autorelease];
        field.textColor = [UIColor colorWithRed:0x32 / (float)0xff green:0x4f / (float)0xff blue:0x85 / (float)0xff alpha:1.0];
        self.accessoryView = field;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self init];
    if (self) {
        self.title = title;
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (UITextField *)textField
{
    return (UITextField *)self.accessoryView;
}

@end
