//
//  SlideMenuView.swift
//  SlideMenuDemo
//
//  Created by BruceWu on 2021/9/4.
//

import UIKit

protocol SlideMenuViewDelegate: NSObject {
    func slideMenuView(slideMenu: SlideMenuView, didSelectRowAt indexPatch: IndexPath)
}

class SlideMenuView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: SlideMenuViewDelegate?
    
    var slideView: SlideTableView = {
        let view = SlideTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var duration: TimeInterval = 0.5
    private var animationOption: UIView.AnimationOptions = .curveEaseInOut
    private var complition: ((Bool) -> ())?
    private var trailing: NSLayoutConstraint?
    private var leading: NSLayoutConstraint?
    private var slideMenuWidth: NSLayoutConstraint?
    private weak var vc: UIViewController?
    
    var widthMultiplier: CGFloat = 0.5 {
        didSet {
            slideMenuWidth?.isActive = false
            slideMenuWidth? = slideView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: widthMultiplier)
            slideMenuWidth?.isActive = true
        }
    }
    
    var list: [Model]? {
        didSet {
            DispatchQueue.main.async {
                self.slideView.reloadData()
            }
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, vc: UIViewController, complition: ((Bool) -> ())?) {
        self.init(frame: frame)
        self.complition = complition
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.alpha = 0.3
        self.delegate = vc as? SlideMenuViewDelegate
        vc.view.addSubview(self)
        self.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        
        slideView.delegate = self
        slideView.dataSource = self
        vc.view.addSubview(slideView)
        slideMenuWidth = slideView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: widthMultiplier)
        slideMenuWidth?.isActive = true
        slideView.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
        slideView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        if #available(iOS 11.0, *) {
            slideView.contentInset = UIEdgeInsets(top: vc.view.safeAreaInsets.top, left: 0, bottom: vc.view.safeAreaInsets.bottom, right: 0)
        }
        trailing = slideView.trailingAnchor.constraint(equalTo: self.leadingAnchor)
        trailing?.isActive = true
        self.isHidden = true
    }
    
    func menuEnable(duration: TimeInterval, option: UIView.AnimationOptions, animation: Bool) {
        guard let vc = self.delegate as? UIViewController else { return }
        self.duration = duration
        self.animationOption = option
        self.isHidden.toggle()
        if !self.isHidden {
            trailing?.isActive = false
            leading = slideView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor)
            leading?.isActive = true
        } else {
            leading?.isActive = false
            trailing = slideView.trailingAnchor.constraint(equalTo: vc.view.leadingAnchor)
            trailing?.isActive = true
        }
        if animation {
            UIView.animate(withDuration: self.duration, delay: 0, options: self.animationOption, animations: {
                vc.view.layoutIfNeeded()
            }, completion: self.complition)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        menuEnable(duration: self.duration, option: self.animationOption, animation: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        delegate.slideMenuView(slideMenu: self, didSelectRowAt: indexPath)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
