//
//  cellFoldView.swift
//  LuCellFold
//
//  Created by 路政浩 on 16/8/17.
//  Copyright © 2016年 路政浩. All rights reserved.
//

import UIKit

let cellID = "cellID"
let headID = "headID"

class cellFoldView: UIView {
    
    var baseTableView = UITableView()
    
    var model = [Models]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadData { (result) in
            
            self.model = result
            
            self.baseTableView.reloadData()
        }
        
        
        setUI()
        setTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension cellFoldView{
    
    private func setUI(){
        frame = CGRectMake(0, 108, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        backgroundColor = UIColor.redColor()
    }
    func setTableView(){
        baseTableView.delegate = self
        baseTableView.dataSource = self
        baseTableView.frame = CGRectMake(0, 0, bounds.size.width, UIScreen.mainScreen().bounds.size.height - 158)
        baseTableView.backgroundColor = UIColor.whiteColor()
        baseTableView.registerClass(TableViewCell.self, forCellReuseIdentifier: cellID)
        
        baseTableView.registerClass(HeaderView.self, forHeaderFooterViewReuseIdentifier: headID)
        
        addSubview(baseTableView)
    }
    
}
extension cellFoldView:UITableViewDelegate,UITableViewDataSource,HeaderViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        let group = model[section]
        
        if group.openGroup == true {
            
            return 1
            
        }else {
            
            return 0
        }
        
        //return model[section].openGroup == true ? 1 : 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! TableViewCell
        cell.selectionStyle = .None
        
        /** 从组模型中取出行模型 */
        let models = model[indexPath.section]
        
        cell.model = models
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headID) as! HeaderView
        
        headerView.delegate = self
        
        let models = model[section]
        
        headerView.model = models
        
        return headerView
    }
    
    /** 设置组头跟随*/
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //组头高度
        let sectionHeaderH :CGFloat = 50
        
        if  scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= sectionHeaderH  {
            
            scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
            
        } else if scrollView.contentOffset.y>=sectionHeaderH {
            
            scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderH, left: 0, bottom: 0, right: 0)
            
        }
    }
    // 组高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 351+1
    }
    
    
    func clickHeaderView() {
        
        print("点击组头")
        self.baseTableView.reloadData()
    }
    
    
}


extension cellFoldView {
    
    private func loadData(finished: ((result: [Models]) -> ())) {
        // 异步获取数据
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            let dict = [["section":"01-组","cells":"cell-01"],
                        ["section":"02-组","cells":"cell-02"],
                        ["section":"03-组","cells":"cell-03"],
                        ["section":"04-组","cells":"cell-04"]]
            print(dict)
            
            var model : [Models] = [Models]()
            
            
            for str in dict {
                
                let md = Models()
                md.title = str["section"]
                md.content = str["cells"]
                model.append(md)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                finished(result: model)
            })
        }
    }
}






