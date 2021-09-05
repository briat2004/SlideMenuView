//
//  SlideTableView.swift
//  SlideMenuDemo
//
//  Created by BruceWu on 2021/9/4.
//

import UIKit

class SlideTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.tableFooterView = UIView()
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
