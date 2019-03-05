# mvvm.sh

authorInfoFunc() {
	mdate=`date +%Y/%m/%d`
	year=${mdate%%/*}
	info="//\n//	$1\n//  XNOnline\n//\n//  Created by ${USER} on ${mdate}.\n//  Copyright © ${year} xiaoniu88. All rights reserved.\n//\n
"
	echo $info
}

createEntityFiles() {
entity=$1Entity

# 创建model.h
echo "$entity.h

#import \"XNOBaseEntity.h\"

NS_ASSUME_NONNULL_BEGIN

@interface $entity : XNOBaseEntity

- (instancetype)initWithEntity:(id)entity;

@end

NS_ASSUME_NONNULL_BEGIN

" >> $entity".h"

# 创建Model.m

echo "import \"${entity}.h\"

@implementation ${entity}

- (instancetype)initWithEntity:(id)entity {

}

@end

" >> ${entity}.m
}


createViewModelFiles() {
	# 创建VM.h
	viewModel=$1VM
	authorInfo=`authorInfoFunc ${viewModel}.m`

	echo "${authorInfo}
#import \"XNOBaseVM.h\"

NS_ASSUME_NONNULL_BEGIN

@interface $viewModel : XNOBaseVM

- (instancetype)initWithEntity:(id)entity;

@end

NS_ASSUME_NONNULL_END
" >> ${viewModel}.h

	authorInfo=`authorInfoFunc ${viewModel}.m`

	# 创建VM.m
	echo "${authorInfo}

#import \"${viewModel}.h\"

@interface ${viewModel}()

@end

@implementation ${viewModel}

- (instancetype)initWithEntity:(id)entity {

}

@end

" >> ${viewModel}.m
}

createCellVMFiles() {
	viewModel=$1Cell
	createViewModelFiles $viewModel
}

createVCFiles() {
	# 创建.h

	viewController=$1VC

	echo "#import \"XNOListViewController.h\"
#import \"#viewModel#\"

NS_ASSUME_NONNULL_BEGIN

@interface $viewController : XNOListViewController

- (instancetype)initWithViewModel:(#viewModel# *)viewModel;

@end

NS_ASSUME_NONNULL_END
" >> $viewController.h

	# 创建.m
	echo "#import \"$viewController.h\"

@interface ${viewController}()


@end

@implementation ${viewController}

#pragma mark - Initialize Methods

- (instancetype)initWithViewModel:(#viewModel# *)viewModel {

}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupLayout];
    [self setupBinding];
    [self showBackgroundLoadingView];
    [self sendRequest];
}

#pragma mark - Super Methods

- (void)requestHandlerWishIsRefresh:(BOOL)isRefresh {
    [self sendRequest];
}

#pragma mark - Private Methods

- (void)sendRequest {

}

- (void)setupLayout {

}

- (void)setupBinding {

}


#pragma mark - Property

@end

" >> ${viewController}.m
}

createCellFiles() {

	cell=$1Cell
	echo "#import \"XNOBaseTableViewCell.h\"

NS_ASSUME_NONNULL_BEGIN
@interface $cell : XNOBaseTableViewCell

- (void)setContentWithCellVM:(id)cellViewModel;

@end

NS_ASSUME_NONNULL_END
" >> ${cell}.h

	echo "#import \"${cell}.h\"

@interface ${cell}()

@end

@implementation ${cell}

#pragma mark - Initialize Methods

- (instancetype)initWithCellIdentifier:(NSString *)cellId {
	self = [super initWithCellIdentifier:cellId];
    if (self) {
        [self setupLayout];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupLayout {

}

- (void)setupConstraints {

}

#pragma mark - Public Methods

- (void)setContentWithCellVM:(id)cellViewModel {

}

@end

" >> ${cell}.m

}


if [[ -n $1 ]]; then
echo $1
#创建一个目录

mkdir $1
cd $1

	if [[ -n $2 ]]; then
	
		if [[ $2 = "vc" ]]; then
			createVCFiles $1
		elif [[ $2 = "cell" ]]; then
			createCellFiles $1
		elif [[ $2 = "cellVM" ]]; then
			createCellVMFiles $1
		elif [[ $2 = "vm" ]]; then
			createViewModelFiles $1
		elif [[ $2 = "model" ]]; then
			createEntityFiles $1
		fi

	else	
		createEntityFiles $1
		createViewModelFiles $1
		createCellVMFiles $1
		createVCFiles $1
		createCellFiles $1
	fi

path=`pwd`

osascript <<EOF
set a to  POSIX file "$path"
tell application "Finder"
	open folder a
end tell
EOF

else

	echo "please input model name"

fi





