#import "TFDataSource.h"

@implementation TFDataSource

@synthesize tableView=_tableView;
@synthesize sectionAnimation=_sectionAnimation;
@synthesize rowAnimation=_rowAnimation;
@synthesize autoAnimate=_autoAnimate;

// sections
+ (id)dataSource
{
    return [[[TFDataSource alloc] init] autorelease];
}

+ (id)dataSourceWithTableView:(UITableView *)tableView
{
    return [[[TFDataSource alloc] initWithTableView:tableView] autorelease];
}



// init/dealloc
- (id)init
{
    self = [super init];
    if (self) {
        self.sectionAnimation = UITableViewRowAnimationFade;
        self.rowAnimation = UITableViewRowAnimationFade;
        self.autoAnimate = NO;
        self.notificationDepth = 1;
    }
    return self;
}

- (id)initWithTableView:(UITableView *)tableView
{
    self = [self init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}



// methods
- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (NSIndexPath *)indexPathForObject:(id)anObject
{
	for (NSInteger i = 0; i < [self count]; i++)
	{
		NSArray *rows = [self objectAtIndex:i];
		
		for (NSInteger j = 0; j < [rows count]; j++)
		{
			id object = [rows objectAtIndex:j];
			
			if (object == anObject) {
				return [NSIndexPath indexPathForRow:j inSection:i];
			}
		}
	}
	
	return nil;
}

- (TFSection *)firstSection
{
    return [self objectAtIndex:0];
}

- (TFSection *)lastSection
{
    return [self lastObject];
}

- (NSString *)titleForHeaderInSection:(NSUInteger)section
{
    return [[self objectAtIndex:section] titleForHeader];
}

- (NSString *)titleForFooterInSection:(NSUInteger)section
{
    return [[self objectAtIndex:section] titleForFooter];
}



// auto insert/delete
- (void)arrayDidChange:(NSUInteger)index added:(id)added removed:(id)removed
{
    [super arrayDidChange:index added:added removed:removed];
    
    if (_autoAnimate && _tableView) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
        
        if (removed) {
            [_tableView deleteSections:indexSet withRowAnimation:_sectionAnimation];
        }
        if (added) {
            [_tableView insertSections:indexSet withRowAnimation:_sectionAnimation];
        }
    }
}

- (void)objectDidChange:(id<TFActiveCollectionProtocol>)sender info:(TFActiveCollectionInfo *)info
{
    [super objectDidChange:sender info:info];
    
    if (_autoAnimate && _tableView && [self containsObject:sender]) {
        TFActiveArrayInfo *arrayInfo = (TFActiveArrayInfo *)info;
        
        NSUInteger index = [self indexOfObject:sender];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:arrayInfo.index inSection:index];
        NSArray *array = [NSArray arrayWithObject:indexPath];
        
        if (arrayInfo.removed) {
            [_tableView deleteRowsAtIndexPaths:array withRowAnimation:_rowAnimation];
        }
        if (arrayInfo.added) {
            [_tableView insertRowsAtIndexPaths:array withRowAnimation:_rowAnimation];
        }
    }
}



// UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self objectAtIndex:section] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self titleForHeaderInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [self titleForFooterInSection:section];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[self objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView canEditRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView canMoveRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    TFSection *fromSection = [self objectAtIndex:fromIndexPath.section];
    TFSection *toSection = [self objectAtIndex:toIndexPath.section];
    id row = [[[fromSection objectAtIndex:fromIndexPath.row] retain] autorelease];
    [fromSection removeObjectAtIndex:fromIndexPath.row];
    [toSection insertObject:row atIndex:toIndexPath.row];
}



// UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self objectAtIndexPath:indexPath] tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [[self objectAtIndexPath:indexPath] tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView willSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self objectAtIndexPath:indexPath] tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView willDeselectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self objectAtIndexPath:indexPath] tableView:tableView didDeselectRowAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[self objectAtIndex:section] tableView:tableView viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[self objectAtIndex:section] tableView:tableView viewForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [[self objectAtIndex:section] tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [[self objectAtIndex:section] tableView:tableView heightForFooterInSection:section];
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self objectAtIndexPath:indexPath] tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self objectAtIndexPath:indexPath] tableView:tableView didEndEditingRowAtIndexPath:indexPath];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView editingStyleForRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndexPath:indexPath] tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    return proposedDestinationIndexPath;
}

@end
