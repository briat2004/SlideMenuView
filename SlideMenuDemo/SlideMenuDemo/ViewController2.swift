//
//  ViewController2.swift
//  SlideMenuDemo
//
//  Created by BruceWu on 2021/9/5.
//

import UIKit

class ViewController2: BaseViewController, SlideMenuViewDelegate {
    
    let btn = UIButton()
    let btn2 = UIButton()
    
    deinit {
        print(type(of: self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        btn.frame = CGRect(x: 10, y: 30, width: 120, height: 30)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(action), for: .touchUpInside)
        btn.setTitle("slideView slide", for: .normal)
        self.view.addSubview(btn)
        
        btn2.frame = CGRect(x: 150, y: 30, width: 120, height: 30)
        btn2.backgroundColor = .blue
        btn2.addTarget(self, action: #selector(backPage), for: .touchUpInside)
        btn2.setTitle("backPage", for: .normal)
        self.view.addSubview(btn2)
        
        self.slideView = SlideMenuView(frame: .zero, vc: self) {_ in
         print("Vc2 animation end")
        }
        self.slideView.list = [Model(title: "A"), Model(title: "B"), Model(title: "C")]
    }
    
    @objc func action() {
        self.slideView.menuEnable(duration: 0.2, option: .curveEaseInOut, animation: true)
    }
    
    func slideMenuView(slideMenu: SlideMenuView, didSelectRowAt indexPatch: IndexPath) {
        print(indexPatch)
    }
    
    @objc func backPage() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
