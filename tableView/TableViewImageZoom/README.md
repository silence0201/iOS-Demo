#Tableview简单的头部缩放
简单实现Tableview的头部缩放  

####利用contentOffset控制缩放

	- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y ;
    
    if (offsetY < 0) {
        self.headImageView.frame = CGRectMake(offsetY/2, offsetY, SCREEN_WIDTH - offsetY, HeadHeight - offsetY) ;
    	}
	}

效果如下:  
![img](screenshot.gif)