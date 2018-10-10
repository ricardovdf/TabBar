//
//  TabBar.swift
//  TabBar
//
//  Created by Dennis Dreissen on 02/07/2018.
//  Copyright © 2018 DennisDreissen. All rights reserved.
//

import UIKit

public class TabBar: UIView {
    
    public var tabBarItems: [UITabBarItem] = [] {
        didSet {
            self.updateTabBarItems()
        }
    }
    
    public var customTabBarItems: [TabBarItem] = []
    
    private var configuration: TabBarConfiguration = .shared
    
    public var delegate: TabBarDelegate?
    
    convenience public init(items: [UITabBarItem], configuration: TabBarConfiguration) {
        self.init(frame: .zero)
        self.configuration = configuration
        
        frame.size.height = configuration.tabBarHeight
        tabBarItems = items
        
        updateTabBarItems()
    }
    
    private func updateTabBarItems() {
        let width = UIScreen.main.bounds.width / CGFloat(tabBarItems.count)
    
        customTabBarItems.forEach { (item) in
            item.removeFromSuperview()
        }
        customTabBarItems.removeAll()
        
        for (index, item) in tabBarItems.enumerated() {
            let tabBarItem = TabBarItem(from: item, configuration: configuration)
            
            tabBarItem.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: frame.height)
            tabBarItem.selected = (index == 0) ? true : false
            
            tabBarItem.tapHandler = {
                self.deselectAll()
                tabBarItem.selected = true
                self.delegate?.tabBar(self, didSelectTabAt: index)
            }
            
            customTabBarItems.append(tabBarItem)
            addSubview(tabBarItem)
        }
    }
    
    public func deselectAll() {
        customTabBarItems.forEach { (item) in
            item.selected = false
        }
    }
}

public protocol TabBarDelegate {
    func tabBar(_ tabBar: TabBar, didSelectTabAt index: Int)
}
