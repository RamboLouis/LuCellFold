//
//  HeaderView.swift
//  LuCellFold
//
//  Created by 路政浩 on 16/8/18.
//  Copyright © 2016年 路政浩. All rights reserved.
//

import UIKit
@objc
protocol HeaderViewDelegate : NSObjectProtocol {
    optional  func clickHeaderView()
}


class HeaderView: UITableViewHeaderFooterView {
    
    weak var delegate : HeaderViewDelegate?
    
    var model: Models? {
        didSet{
            if model?.openGroup == true {
                
                line.hidden = true
                selectedButton.selected = false
                imageView.image = UIImage(named: "向上")
                
            }else {
                line.hidden = false
                selectedButton.selected = true
                imageView.image = UIImage(named: "向下")
                
            }
            titleLabel.text = model?.title
        }
    }
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var selectedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.whiteColor()
        button.contentHorizontalAlignment = .Center
        button.addTarget(self, action: #selector(btnClickHeaderView), forControlEvents: .TouchUpInside)
        return button
    }()
    lazy var titleLabel : UILabel = {
        let title = UILabel()
        //        title.textColor = UIColor.whiteColor()
//        title.text = "这个是测试代码啊啊啊啊啊啊啊啊"
        title.font = UIFont.systemFontOfSize(15)
        title.numberOfLines = 0
        return title
    }()
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named:"向下")
        return img
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGrayColor()
        return line
    }()
}
extension HeaderView{
    func setUI(){
        contentView.backgroundColor = UIColor.redColor()
        
        
        contentView.addSubview(selectedButton)
        selectedButton.addSubview(titleLabel)
        selectedButton.addSubview(imageView)
        selectedButton.bringSubviewToFront(line)
        selectedButton.addSubview(line)
        //
        selectedButton.snp_makeConstraints { (make) in
            //            make.centerY.equalTo(self)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(selectedButton).offset(15)
            make.right.equalTo(selectedButton).offset(-50)
            make.centerY.equalTo(selectedButton)
        }
        
        imageView.snp_makeConstraints { (make) in
            make.right.equalTo(selectedButton).offset(-15)
            make.centerY.equalTo(selectedButton)
            make.width.equalTo(10)
            make.height.equalTo(5.5)
        }
        line.snp_makeConstraints { (make) in
            make.left.equalTo(selectedButton)
            make.right.equalTo(selectedButton)
            make.bottom.equalTo(selectedButton)
            make.height.equalTo(1)
        }
        
//        self.contentView.snp_makeConstraints { (make) in
//            make.left.top.right.equalTo(self)
//            make.bottom.equalTo(selectedButton.snp_bottom).offset(40)
//        }
        
    }
    @objc
    private func btnClickHeaderView(){
        
        print("点击组头")
        
        if self.model?.openGroup == true {
            
            self.model?.openGroup = false
        }else {
            
            self.model?.openGroup = true
        }
        
        delegate?.clickHeaderView!()
        
    }
    
}














