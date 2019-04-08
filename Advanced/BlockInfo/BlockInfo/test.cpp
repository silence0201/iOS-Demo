#import <Foundation/Foundation.h>

void test_orign() {
    //下面分别定义各种类型的变量
    int a = 10;                       //普通变量
    __block int b = 20;                //带__block修饰符的block普通变量
    NSString *str = @"123";
    __block NSString *blockStr = str;  //带__block修饰符的block OC变量
    NSString *strongStr = @"456";      //默认是__strong修饰的OC变量
    __weak NSString *weakStr = @"789"; //带__weak修饰的OC变量
    
    //定义一个block块并带一个参数
    void (^testBlock)(int) = ^(int c){
        int  d = a + b + c;
        NSLog(@"d=%d, strongStr=%@, blockStr=%@, weakStr=%@", d, strongStr, blockStr, weakStr);
    };
    
    a = 20;  //修改值不会影响testBlock内的计算结果
    b = 40;  //修改值会影响testBlock内的计算结果。
    testBlock(30);  //执行block代码。
}


///  每个block变量都会生成一个和OC类内存结构兼容的结构体。下面是_block int b 的结构体定义：
struct Block_b {
    void *isa;    //固定为NULL
    Block_b *forwarding;  //指向真正的block对象变量。
    int flags;
    int size; //结构体的size
    int b;   //保存代码中定义的变量值。
};

//每个block变量都会生成一个和OC类内存结构兼容的结构体。下面是 __block NString *blockStr 的结构体定义：
struct Block_blockStr {
    void *isa;  //固定为NULL
    Block_blockStr *forwarding;  //指向真正的block对象变量
    int flags;
    int size;  //结构体的size
    NSString * blockStr;  //保存代码中定义的变量值。
};


//每个block块都会生成一个和OC类内存结构兼容的结构体和一个描述这个block块信息描述的结构体
struct Block_testBlock {
    //所有block块的固定部分，这也是一个OC类的内存结构。
    Class isa;  //block的OC类型
    int flags;
    int reserved;
    void *funcPtr;       //block块函数的地址。
    Block_testBlock_Desc* desc;   //block的描述信息。
    
    //所有在block代码块内引用的外部数据都会成为结构体内的数据成员。
    int a;
    NSString * strongStr;
    NSString * __weak weakStr;
    Block_b *b;
    Block_blockStr *blockStr;
    
    //结构体的构造函数。
    Block_testBlock(void *_funcPtr, Block_testBlock_Desc *_desc, int _a, NSString * _strongStr, NSString * _weakStr, struct Block_b *_b, Block_blockStr *_blockStr, int _flags)
    {
        isa = &_NSConcreteStackBlock;  //根据具体的block类型赋值。
        flags = _flags;
        reserved = 0;
        funcPtr = _funcPtr;
        desc = _desc;
        a = _a;
        strongStr = _strongStr;
        weakStr = _weakStr;
        b = _b->forwarding;  //b保存真实的block变量的地址。
        blockStr = _blockStr->forwarding;  //blockStr保存真实的block变量的地址。
    }
};

//block块信息描述的结构体定义，主要有block对象的尺寸，以及block中函数的参数信息，也就是参数的签名信息。并生成一个全局的常量对象_testBlock_desc_DATA
struct Block_testBlock_Desc {
    unsigned long reserved;
    unsigned long size; //块的尺寸
    void *rest[1];    //块的参数签名信息
}_testBlock_desc_DATA = {0, sizeof(Block_testBlock), "v12@?0i8"};


//这部分是block块函数体的定义部分，可以看出block的代码块都转化为了普通的函数，并且函数会默认增加一个隐藏的__cself参数，用来指向block对象本身。
static void testBlockfn(Block_testBlock *__cself, int c) {
    
    //还原函数体内引用外部的数据对象和变量。
    Block_b *b = __cself->b;
    Block_blockStr *blockStr = __cself->blockStr;
    int a = __cself->a;
    NSString *__strong strongStr = __cself->strongStr;
    NSString *__weak weakStr = __cself->weakStr;
    
    //int d = a + b + c;
    int d = a + b->forwarding->b + c;  //注意这里block变量使用方式。
    
    //NSLog(@"d=%d, strongStr=%@, blockStr=%@, weakStr=%@", d, strongStr, blockStr, weakStr);
    NSLog(@"d=%d, strongStr=%@, blockStr=%@, weakStr=%@", d, strongStr, blockStr->forwarding->blockStr, weakStr);
    
}

void test()
{
    int a = 10;
    
    //__block int b = 20;
    Block_b b = {nil, &b, 0, sizeof(struct Block_b), 20};
    
    // __block NSString *blockStr = @"123";
    Block_blockStr blockStr = {nil, &blockStr, 33554432, sizeof(Block_blockStr), @"123"};
    
    NSString *strongStr = @"456";
    
    __weak NSString *weakStr = @"789";
    
    //每个在代码中的block块都会生成对应的OC block对象，这里面用构造函数初始化这个block对象。
    Block_testBlock testBlock(&testBlockfn, &_testBlock_desc_DATA, a, strongStr, weakStr, &b, &blockStr, 570425344);
    
    a = 20;   //这个不会影响到block块内执行时a的值。
    // b = 40; 这个赋值会影响到block块内执行时b的值。
    b.forwarding->b = 40;  //注意__block类型变量的值的更新方式。
    
    //执行block块其实就是执行block对象里面的函数。
    //testBlock(30);
    testBlock.funcPtr(&testBlock, 30);
}
