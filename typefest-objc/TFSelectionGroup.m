#import "TFSelectionGroup.h"

@interface TFSelectionGroup ()
- (void)checkSelection:(id)object;
@end

@implementation TFSelectionGroup

+ (id)group
{
    return [[[TFSelectionGroup alloc] init] autorelease];
}

// init/dealloc
- (void)dealloc
{
    [_groupDelegates release];
    [super dealloc];
}

- (TFSelectableRow *)row
{
    for (TFSelectableRow *row in self) {
        if ([row isKindOfClass:[TFSelectableRow class]] && row.selected) {
            return row;
        }
    }
    return nil;
}

- (NSMutableArray *)groupDelegates
{
    if (!_groupDelegates) {
        _groupDelegates = [[TFActiveCollectionUtils nonRetainingArray] retain];
    }
    return _groupDelegates;
}

// overrides
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    [self checkSelection:anObject];
    [super insertObject:anObject atIndex:index];
}

- (void)addObject:(id)anObject
{
    [self checkSelection:anObject];
    [super addObject:anObject];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    [self checkSelection:anObject];
    [super replaceObjectAtIndex:index withObject:anObject];
}

- (void)checkSelection:(id)object
{
    if ([object isKindOfClass:[TFSelectableRow class]]) {
        TFSelectableRow *row = object;
        
        if (row.selected && self.row) {
            row.selected = NO;
        }
    }
}

- (void)addObserverToObject:(id)object
{
    [super addObserverToObject:object];
    
    if ([object isKindOfClass:[TFSelectableRow class]]) {
        [((TFSelectableRow *)object).delegates addObject:self];
    }
}

- (void)removeObserverFromObject:(id)object
{
    [super removeObserverFromObject:object];
    
    if ([object isKindOfClass:[TFSelectableRow class]]) {
        [((TFSelectableRow *)object).delegates removeObject:self];
    }
}

// TFSelectableRowDelegate
- (void)selectionChanged:(TFSelectableRow *)row
{
    for (TFSelectableRow *r in self) {
        [self removeObserverFromObject:r];
    }
    
    TFSelectableRow *deselectedRow;
    
    if (row.selected) {
        for (TFSelectableRow *r in self) {
            if (r != row && r.selected) {
                r.selected = NO;
                deselectedRow = r;
                break;
            }
        }
    } else {
        deselectedRow = row;
    }
    
    for (TFSelectableRow *r in self) {
        [self addObserverToObject:r];
    }
    
    for (id delegate in _groupDelegates) {
        if ([delegate respondsToSelector:@selector(selectionChanged:deselectedRow:)]) {
            [delegate performSelector:@selector(selectionChanged:deselectedRow:)
                           withObject:self withObject:deselectedRow];
        }
    }
}

@end
