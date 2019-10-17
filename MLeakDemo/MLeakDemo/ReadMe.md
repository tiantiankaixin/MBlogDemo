#### 常见会导致循环引用的例子
###### 1、基本的
delegate、block、NSTimer、
###### 2、特别点儿的
 [self performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>];
