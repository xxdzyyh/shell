# mvvm.sh

authorInfoFunc() {
	mdate=`date +%Y/%m/%d`
	year=${mdate%%/*}
	info="//\n//	$1\n//  BFMoney\n//\n//  Created by ${USER} on ${mdate}.\n//  Copyright © ${year} xiaoniu88. All rights reserved.\n//\n
"
	echo $info
}

createEntityFiles() {
entity=$1"Model"
authorInfo=`authorInfoFunc ${viewModel}.swift`
# 创建model.swift
echo "${authorInfo}

import HandyJSON

class $entity : HandyJSON {
	required init() {
        
    }
}

" >> $entity".swift"
}


createViewModelFiles() {
	
	entity=$1"Model"
	viewModel=$1ViewModel
	authorInfo=`authorInfoFunc ${viewModel}.swift`

	echo "${authorInfo}

class ${viewModel}: PageContainerDataRefreshViewModel<${entity}> {

     override func refreshPageDataAPI(page: Int, limit: Int) -> Single<ResponseModel<PageContainerModel<${entity}>>> {
        let api = AssetsAPI.selectRechargeList(pageNum: page.string, pageSize: limit.string)
        return Network.request(api,dataType: ResponseModel<PageContainerModel<${entity}>>.self)
    }
}

" >> ${viewModel}.swift

}


createVCFiles() {
	# 创建.h

	entity=$1"Model"
	viewModel=$1ViewModel
	viewController=$1VC
	cell=$1Cell
	authorInfo=`authorInfoFunc ${viewController}.swift`

	# 创建.m
echo "${authorInfo}

import UIKit

class ${viewController}: DataRefreshTableViewController<${entity}> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        
        viewModel.refreshData()
    }
        
    override func initViewModel() {
        viewModel = ${viewModel}()
    }
    
    override func initTableView() {
        super.initTableView()
        
        tableView.separatorColor = UIColor.qd_background
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets.make(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 65
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ${cell}.cell(for: tableView) as! ${cell}
        cell.selectionStyle = .none
        cell.config(model: self.viewModel.dataList[indexPath.row])
        return cell
    }
    
}
" >> ${viewController}.swift
}


createCellFiles() {

	entity=$1"Model"
	viewModel=$1ViewModel
	viewController=$1VC
	cell=$1Cell
	echo "#import \"BFBaseCell.h\"

import UIKit

class ${cell}: BaseTableViewCell {
    
    func config(model:${entity}) {

    }
}
" >> ${cell}.swift

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
		elif [[ $2 = "vm" ]]; then
			createViewModelFiles $1
		elif [[ $2 = "model" ]]; then
			createEntityFiles $1
		fi
	else	
		createEntityFiles $1
		createViewModelFiles $1
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





