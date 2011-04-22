#import "TFSwitchRow.h"

@implementation TFSwitchRow

+ (id)row
{
    return [[[TFSwitchRow alloc] init] autorelease];
}

+ (id)rowWithTitle:(NSString *)title reuseIdentifer:(NSString *)reuseIdentifer
{
    return [[[TFSwitchRow alloc] initWithTitle:title reuseIdentifier:reuseIdentifer] autorelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.accessoryView = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
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

- (UISwitch *)switchButton
{
    return (UISwitch *)self.accessoryView;
}

@end
