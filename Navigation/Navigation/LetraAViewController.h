//
//  LetraAViewController.h
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Palavras.h"


@interface LetraAViewController : UIViewController<UITabBarDelegate, UIGestureRecognizerDelegate>


@property Palavras *palavra;
@property UILabel *myLabel;
@property UIButton *botao;
@property UIBarButtonItem *next;
@property UIBarButtonItem *previous;
@property UIImageView *wordImage;
@property UITabBar *tabBar;


//UIImageView positioning
#define UIImageViewWIDTH 250
#define UIImageViewHEIGHT 300
#define UIImageViewX 40
#define UIImageViewY 100

//label positioning

#define labelWIDTH 100
#define labelHEIGHT 100
#define labelX 130
#define labelY 400


@end
