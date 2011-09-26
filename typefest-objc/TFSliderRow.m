#import "TFSliderRow.h"

@implementation TFSliderRow

+ (id)row
{
    return [[[TFSliderRow alloc] init] autorelease];
}

+ (id)rowWithTitle:(NSString *)title reuseIdentifer:(NSString *)reuseIdentifer
{
    return [[[TFSliderRow alloc] initWithTitle:title reuseIdentifier:reuseIdentifer] autorelease];
}

// init
- (id)init
{
    self = [super init];
    if (self) {
        self.accessoryView = [[[UISlider alloc] initWithFrame:CGRectMake(0, 0, 180, 21)] autorelease];
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

// slider
- (UISlider *)slider
{
    return (UISlider *)self.accessoryView;
}

@end
