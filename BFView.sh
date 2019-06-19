# 两个参数 
# $1 名称前缀 生成的视图名称为 $1View
# $2 是否需要搭配 viewModel 

authorInfoFunc() {
    mdate=`date +%Y/%m/%d`
    year=${mdate%%/*}
    info="//\n//    $1\n//  BFMoney\n//\n//  Created by ${USER} on ${mdate}.\n//  Copyright © ${year} xiaoniu88. All rights reserved.\n//\n
"
    echo $info
}

createHeadFile() {
    view=$1View
    authorInfo=`authorInfoFunc ${view}.h`

    echo "${authorInfo}
#import <UIKit/UIKit.h>" >> ${view}.h

if [[ -n $2 ]]; then
    # 第二个参数存在

    echo "#import \"$1VM.h\"" >> ${view}.h
fi

echo "
NS_ASSUME_NONNULL_BEGIN

@interface $view : UIView
" >> ${view}.h

if [[ -n $2 ]]; then
    echo "- (instancetype)initWithVM:($1VM *)viewModel;" >> ${view}.h      
fi

echo "
@end

NS_ASSUME_NONNULL_END" >> ${view}.h  
}

createMFile() {

    view=$1View
    authorInfo=`authorInfoFunc ${view}.m`

        echo "${authorInfo}
#import \"${view}.h\"
" >> ${view}.m

    if [[ -n $2 ]]; then
        echo "#import \"$1VM.h\"" >>${view}.m
    fi

    echo "@interface ${view}()" >> ${view}.m  

    if [[ -n $2 ]]; then
        echo "@property (nonatomic, strong) $1VM *viewModel;" >> ${view}.m
    fi

    echo "" >> ${view}.m
    echo "@end

@implementation ${view}

#pragma mark - Initialize Methods" >> ${view}.m

    if [[ -n $2 ]]; then
        echo "- (instancetype)initWithVM:($1VM *)viewModel {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _viewModel = viewModel;
        
        [self setupSubviews];
        [self setupConstraint];
        [self bind];
    }
    return self;
}" >> ${view}.m
    fi

    echo "
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        [self setupConstraint];
        [self bind];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupSubviews {

}

- (void)setupConstraint {

}

- (void)bind { 

}

#pragma mark - Public Methods


#pragma mark - Property


@end

" >> ${view}.m

}


createViewFiles() {
	mkdir View
    cd View
	authorInfo=`authorInfoFunc ${view}.m`


    createHeadFile $1 $2
    createMFile $1 $2

    cd ..

}


if [[ -n $1 ]]; then

    createViewFiles $1 $2
else

    echo "please input view name"

fi









