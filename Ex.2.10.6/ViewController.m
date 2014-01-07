//
//  ViewController.m
//  Ex.2.10.6
//
//  Created by SDT-1 on 2014. 1. 7..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"
#define IMAGE_NUM 4
@interface ViewController (){
    
    UIScrollView * _scrollView;
    UIPageControl *pageControl;
    int loadedPageCount;
    
}

@end

@implementation ViewController



-(void)loadContentsPage:(int)pageNo{
    
    if(pageNo<0 ||pageNo < loadedPageCount || pageNo >= IMAGE_NUM){
        return;
    }
    
    
    float width = _scrollView.frame.size.width;
    float height = _scrollView.frame.size.height;
    
    NSString *fileName = [NSString stringWithFormat:@"car%d", pageNo];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(width* pageNo, 0, width, height);
    [_scrollView addSubview:imageView];
    loadedPageCount++;
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float width = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    int pageNO = floor(offsetX / width);
    pageControl.currentPage = pageNO;
    
    [self loadContentsPage:pageNO -1];
    [self loadContentsPage:pageNO];
    [self loadContentsPage:pageNO+1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    float width =  _scrollView.bounds.size.width;
    float height=  _scrollView.bounds.size.height;
    
    _scrollView.delegate = self;
    _scrollView. pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(width *IMAGE_NUM, height);
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(130, 400, 60, 40)];
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = IMAGE_NUM;
    
    
    loadedPageCount = 0;
    [self loadContentsPage:0];
    [self loadContentsPage:1];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
