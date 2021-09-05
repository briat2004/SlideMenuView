//
//  ViewController.swift
//  SlideMenuDemo
//
//  Created by BruceWu on 2021/9/4.
//

import UIKit

class ViewController: BaseViewController, SlideMenuViewDelegate {
    
    let btn = UIButton()
    let btn2 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
        self.slideView = SlideMenuView(frame: .zero, vc: self) {_ in
            print("Vc animation end")
        }
        self.slideView.widthMultiplier = 0.3
        self.slideView.list = [Model(title: "1"),
                               Model(title: "2"),
                               Model(title: "3"),
                               Model(title: "4"),
                               Model(title: "5"),
                               Model(title: "6"),
                               Model(title: "7"),
                               Model(title: "8"),
                               Model(title: "9"),
                               Model(title: "10"),
                               Model(title: "11"),
                               Model(title: "12"),
                               Model(title: "13"),
                               Model(title: "14"),
                               Model(title: "15"),
                               Model(title: "16"),
                               Model(title: "17"),
                               Model(title: "18"),
                               Model(title: "19"),
                               Model(title: "20"),
                               Model(title: "21"),
                               Model(title: "22"),
                               Model(title: "23")]
    }
    
    func slideMenuView(slideMenu: SlideMenuView, didSelectRowAt indexPatch: IndexPath) {
        print(indexPatch)
    }
    
    func setupViews() {
        self.view.backgroundColor = .red
        btn.frame = CGRect(x: 10, y: 30, width: 120, height: 30)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(action), for: .touchUpInside)
        btn.setTitle("slideView slide", for: .normal)
        self.view.addSubview(btn)
        btn2.frame = CGRect(x: 150, y: 30, width: 120, height: 30)
        btn2.backgroundColor = .blue
        btn2.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        btn2.setTitle("nextPage", for: .normal)
        self.view.addSubview(btn2)
    }
    
    @objc func action() {
        self.slideView.menuEnable(duration: 0.2, option: .curveEaseInOut, animation: true)
    }
    
    @objc func nextPage() {
        let vc2 = ViewController2()
        vc2.modalPresentationStyle = .fullScreen
        self.present(vc2, animated: true, completion: nil)
    }
    
    
}

