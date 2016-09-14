#CollectionView实现瀑布流布局

核心代码:[FlowLayout](FlowLayout)

####使用方法:
导入文件[FlowLayout](FlowLayout)
	
	#import "SIWaterFlowLayout.h"
	
设置为相应布局:
	
	SIWaterFlowLayout *flowLayout = [[SIWaterFlowLayout alloc]init] ;
	self.collectionView.collectionViewLayout = flowLayout ;
	
设置布局基本属性:
	
	flowLayout.itemSpace = 10 ;  // 水平间距
    flowLayout.lineSpace = 10 ;   // 垂直间距
    flowLayout.colCount = 3 ;   // 列数
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10) ;  // 组间距
    
设置代理:

	flowLayout.delegate = self ;
	
实现代理方法:

	#pragma mark -SIWaterFlowLayoutDelegate
	
	// 获取item的高度
	- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SIWaterFlowLayout 	*)waterFlowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    	DataModel *mo = _dataArray[indexPath.section][indexPath.item] ;
    	return mo.h / mo.w *width + bottomHeight ;
	}
	
	// 获取Fooder的Size
	- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SIWaterFlowLayout 	*)waterFlowLayout referenceSizeForFooterInSection:(NSInteger)section{
    	return CGSizeMake(self.view.frame.size.width - 20, 40);
	}

	// 获取Header的Size
	- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SIWaterFlowLayout 	*)waterFlowLayout referenceSizeForHeaderInSection:(NSInteger)section{
    	return CGSizeMake(self.view.frame.size.width - 20, 40);
	}


![img](screenshot.gif)