//
//  ViewController.swift
//  LuCellFold
//
//  Created by 路政浩 on 16/8/17.
//  Copyright © 2016年 路政浩. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cellFold = cellFoldView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController{
    private func setUI(){
//        cellFold.frame = CGRectMake(0, 108, self.view.bounds.size.width, self.view.bounds.size.height)
        view.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(cellFold)
   
    }
}
