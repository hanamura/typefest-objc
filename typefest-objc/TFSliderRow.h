#import <Foundation/Foundation.h>
#import "TFRow.h"

@interface TFSliderRow : TFRow
{
    
}

+ (id)rowWithTitle:(NSString *)title reuseIdentifer:(NSString *)reuseIdentifer;

@property (nonatomic, readonly) UISlider *slider;

- (id)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier;

@end
