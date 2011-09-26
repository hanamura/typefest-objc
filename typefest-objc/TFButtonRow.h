#import <Foundation/Foundation.h>
#import "TFRow.h"

@interface TFButtonRow : TFRow
{
    
}

+ (id)rowWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier target:(id)target action:(SEL)action;
- (id)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier target:(id)target action:(SEL)action;

@end
