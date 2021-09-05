//
//  BaseViewController.swift
//  SlideMenuDemo
//
//  Created by BruceWu on 2021/9/5.
//

import UIKit

class BaseViewController: UIViewController {

    var slideView: SlideMenuView = {
        let slideView = SlideMenuView()
        slideView.widthMultiplier = 0.35
        return slideView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
