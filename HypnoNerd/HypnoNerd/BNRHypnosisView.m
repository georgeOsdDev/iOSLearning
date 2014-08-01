//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Oshida Takeharu on 7/31/14.
//  Copyright (c) 2014 Oshida Takeharu. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView()

@property (strong, nonatomic) UIColor *circleColor;

@end


@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisView start with aclear background color
        self.backgroundColor = [UIColor clearColor];
        self.circleColor     = [UIColor lightGrayColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
//    // The circle will be the largest that will fit in the view
//    float radius = MIN(bounds.size.width, bounds.size.height) / 2.0;

    // The largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    
    // Add an arc to the path at center, with radius of radius,
    // from 0 to 2*PI radians (a circle)
    UIBezierPath *path = [[UIBezierPath alloc]init];
//    [path addArcWithCenter:center
//                    radius:radius
//                startAngle:0.0
//                  endAngle:M_PI * 2.0
//                 clockwise:YES];

    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    path.lineWidth = 10.0;
    
    [self.circleColor setStroke];
    
    // Draw line
    [path stroke];
    
    // Challange
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    
    UIBezierPath *gradientPath = [[UIBezierPath alloc]init];
    [gradientPath moveToPoint:CGPointMake(bounds.size.width / 2.0, bounds.size.height / 5.0)];
    [gradientPath addLineToPoint:CGPointMake(bounds.size.width / 3.0, bounds.size.height / 5.0 * 4.0)];
    [gradientPath addLineToPoint:CGPointMake(bounds.size.width / 3.0 * 2.0, bounds.size.height / 5.0 * 4.0)];
    [gradientPath closePath];
    [[UIColor redColor] setStroke];
    gradientPath.lineWidth = 1;
    [gradientPath addClip];
    
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {0.0, 1.0 , 0.0, 1.0,
                            1.0, 1.0, 0.0, 1.0};
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    CGPoint startPoint = CGPointMake(bounds.size.width / 2.0, bounds.size.height / 5.0);
    CGPoint endPoint   = CGPointMake(bounds.size.width / 2.0, bounds.size.height / 5.0 * 4.0);
    
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    CGContextRestoreGState(currentContext);
    
    UIImage *logoImg = [UIImage imageNamed:@"logo.png"];
    
    UIImage *resizedLogoImg;
    float widthPer = 0.5;
    float heightPer = 0.5;
    
    CGSize sz = CGSizeMake(logoImg.size.width*widthPer,
                           logoImg.size.height*heightPer);
    UIGraphicsBeginImageContext(sz);
    [logoImg drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
    resizedLogoImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGContextSaveGState(currentContext);
    
    CGContextSetShadow(currentContext, CGSizeMake(4,7), 3);

    CGRect logoFrame = CGRectMake((bounds.size.width - sz.width ) / 2.0, (bounds.size.height - sz.height) / 2.0, sz.width, sz.height);
    [resizedLogoImg drawInRect:logoFrame];
    
    CGContextRestoreGState(currentContext);
    
}

// When a finger touches the screen
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    //Get 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    
    self.circleColor = randomColor;
    [self setNeedsDisplay];
    //    [self setNeedsDisplayInRect:CGRectMake(50, 50, 100, 200)];

}

@end
