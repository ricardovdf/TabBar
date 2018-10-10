//
//  TabBarController.swift
//  TabBar
//
//  Created by Dennis Dreissen on 02/07/2018.
//  Copyright © 2018 DennisDreissen. All rights reserved.
//

import UIKit

open class TabBarController: UITabBarController {
    
    private var customTabBar: TabBar?
    private var didLoad = false
    
    public var configuration: TabBarConfiguration = .shared
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if didLoad { return }
        didLoad = true
        
        let tabBarItems = viewControllers?.map({ (viewController) -> UITabBarItem in
            return viewController.tabBarItem
        })
        
        customTabBar = TabBar(items: tabBarItems ?? [], configuration: configuration)
        customTabBar?.delegate = self
        
        if let customTabBar = customTabBar {
            customTabBar.backgroundColor = .white
            customTabBar.frame = .zero
            
            let view = UIView(frame: .zero)
            view.backgroundColor = .white
            view.tag = 666
            
            if let tabBarContainer = self.tabBar as? TabBarContainer {
                tabBarContainer.addSubview(view)
                tabBarContainer.addSubview(customTabBar)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                tabBarContainer.addGestureRecognizer(tap)
            }
            
            view.snp.makeConstraints { (make) in
                make.bottom.top.trailing.leading.equalToSuperview()
            }
            
            self.view.backgroundColor = .white
        }
    }
    
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.recognized {
            if let tabBarContainer = self.tabBar as? TabBarContainer {
                let location = gestureRecognizer.location(in: tabBarContainer)
                
                if location.y <= 72.0 {
                    let width = UIScreen.main.bounds.width / CGFloat(customTabBar?.customTabBarItems.count ?? 0)
                    let index = Int(ceil(location.x / width)) - 1
                    customTabBar?.customTabBarItems[index].tapHandler?()
                }
            }
        }
    }
    
    public func set(visibleTabIndex index: Int) {
        if let tab = customTabBar?.customTabBarItems[index] {
            tab.tapHandler?()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        object_setClass(self.tabBar, TabBarContainer.self)
        object_setClass(self.view, TabBarContainerView.self)
    }
}

class TabBarContainerView: UIView {}

extension TabBarController: TabBarDelegate {
    public func tabBar(_ tabBar: TabBar, didSelectTabAt index: Int) {
        self.selectedViewController = self.viewControllers?[index]
    }
}

class TabBarContainer: UITabBar {
    
    public var configuration: TabBarConfiguration?
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let height = TabBarConfiguration.shared.tabBarHeight + ((UIDevice.deviceType == .iPhoneX) ? 34 : 0)
        return CGSize(width: size.width, height: height)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in subviews {
            if subview.tag == 666 {
                continue
            }
            
            if subview as? TabBar == nil {
                subview.removeFromSuperview()
            }
        }
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 8.0
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
