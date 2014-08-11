//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Oshida Takeharu on 8/11/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"


@interface BNRDrawView() <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@property (nonatomic, weak) BNRLine *selectedLine;

@end

@implementation BNRDrawView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer *doubleTapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];
        
        
        UITapGestureRecognizer *tapRecognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        
        UILongPressGestureRecognizer *pressRecognizer =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
        
    }
    return self;
}

- (void) strokeLine:(BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

-(void) drawRect:(CGRect)rect
{
    [[UIColor blackColor] set];
    for( BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    [[UIColor redColor] set];
    
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
    }
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch * t in touches) {
        CGPoint location = [t locationInView:self];
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}



- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch * t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        line.end = [t locationInView:self];
    }
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch * t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
        
        line.end = [t locationInView:self];
    }
    [self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch * t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];    
}

- (void) doubleTap: (UIGestureRecognizer *) gr
{
    NSLog(@"Recognized Double tap");
    
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
    
}

- (void) tap: (UIGestureRecognizer *) gr
{
    NSLog(@"Recognized Tap");
    
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];

    if (self.selectedLine) {
        
        
        [self becomeFirstResponder];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        
        menu.menuItems = @[deleteItem];
        
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
                [menu setMenuVisible:YES];
    } else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    [self setNeedsDisplay];
}

- (void) longPress: (UIGestureRecognizer *) gr
{
    NSLog(@"Long press");
    if (gr.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        if (self.selectedLine){
            [self.linesInProgress removeAllObjects];
        }
    } else if(gr.state == UIGestureRecognizerStateEnded){
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

- (void) moveLine: (UIPanGestureRecognizer *) gr
{
    if (!self.selectedLine){
        return;
    }
    
    if (gr.state == UIGestureRecognizerStateChanged){
        
        CGPoint translation = [gr translationInView:self];
        
        CGPoint begin = self.selectedLine.begin;
        CGPoint end   = self.selectedLine.end;
        
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        self.selectedLine.begin = begin;
        self.selectedLine.end   = end;
        
        [self setNeedsDisplay];
        
        [gr setTranslation:CGPointZero inView:self];
    }
    
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (gestureRecognizer == self.moveRecognizer){
        return YES;
    } else {
        return NO;
    }
}

- (void)deleteLine:(id)sender
{
    [self.finishedLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
}

- (BNRLine *)lineAtPoint:(CGPoint)p{
    
    for (BNRLine *l in self.finishedLines){
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        for (float t = 0.0; t <= 1.0; t +=0.05){
            float x = start.x + t *(end.x - start.x);
            float y = start.y + t *(end.y - start.y);
            
            if (hypot(x - p.x, y - p.y) < 20.0){
                return l;
            }
        }
    }
    return nil;
}

@end
