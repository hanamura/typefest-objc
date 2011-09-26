#import "TFButtonRow.h"

@implementation TFButtonRow

+ (id)rowWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier target:(id)target action:(SEL)action
{
    return [[[TFButtonRow alloc] initWithTitle:title reuseIdentifier:reuseIdentifier target:target action:action] autorelease];
}

// init
- (id)initWithTitle:(NSString *)title reuseIdentifier :(NSString *)reuseIdentifier target:(id)target action:(SEL)action
{
    self = [super init];
    if (self) {
        self.title = title;
        self.reuseIdentifier = reuseIdentifier;
        self.privateCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
        self.target = target;
        self.action = action;
    }
    return self;
}

@end
