//
//  TableViewCell.swift
//  LuCellFold
//
//  Created by 路政浩 on 16/8/18.
//  Copyright © 2016年 路政浩. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    lazy var videoView   = UIView()
    
    lazy var titleView   = UIView()
    
    lazy var summaryView = UIView()
    
    var summaryTitle = UILabel()
    var summaryBody  = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** 简介赋值 */
    var model: Models? {
        didSet{
            summaryBody.text = model?.content
            
        }
    }
    
}

extension TableViewCell{
    func setUI(){
        backgroundColor = UIColor.greenColor()
        videoView.backgroundColor = UIColor.redColor()
        titleView.backgroundColor = UIColor.lightGrayColor()
        summaryView.backgroundColor = UIColor.blueColor()
        
        
        
        summaryTitle.text = "视频简介"
        summaryBody.text = "大叔爱你你不爱他,测试测试测试"
        
        contentView.addSubview(videoView)
        contentView.addSubview(titleView)
        titleView.addSubview(summaryTitle)
        contentView.addSubview(summaryView)
        summaryView.addSubview(summaryBody)
        
        videoView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.equalTo(211)
        }
        titleView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(videoView.snp_bottom)
            make.height.equalTo(40)
        }
        summaryTitle.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(titleView)
        }
        summaryView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(titleView.snp_bottom)
            make.bottom.equalTo(contentView).offset(1)
        }
        summaryBody.snp_makeConstraints { (make) in
            make.left.equalTo(summaryView)
            make.right.equalTo(summaryView)
            make.top.equalTo(summaryView)
            make.bottom.equalTo(summaryView)
        }

        self.contentView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(summaryBody.snp_bottom).offset(80)
        }
        
    }
    
    
    
}