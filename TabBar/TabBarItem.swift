//
//  TabBarItem.swift
//  TabBar
//
//  Created by Dennis Dreissen on 02/07/2018.
//  Copyright © 2018 DennisDreissen. All rights reserved.
//

import UIKit
import SnapKit

public class TabBarItem: UIView {
    
    private var titleLabel: UILabel?
    private var iconImageView: UIImageView?
    private var containerView: UIView?
    
    private var configuration: TabBarConfiguration = .shared
    
    public var title: String? {
        get {
            return self.titleLabel?.text
        }
        set {
            self.titleLabel?.text = newValue
        }
    }
    
    public var icon: UIImage? {
        get {
            return self.iconImageView?.image
        }
        set {
            self.iconImageView?.image = newValue?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    public var selected = false {
        didSet {
            self.titleLabel?.textColor = (self.selected) ? self.configuration.tabBarItemSelectedTitleColor : self.configuration.tabBarItemTitleColor
            self.iconImageView?.tintColor = (self.selected) ? self.configuration.tabBarItemSelectedIconColor : self.configuration.tabBarItemIconColor
        }
    }
    
    public var tapHandler: (()->())?
    
    convenience public init(from tabBarItem: UITabBarItem, configuration: TabBarConfiguration) {
        self.init(frame: .zero)
        self.configuration = configuration
        
        containerView = UIView()
        addSubview(containerView!)
        
        containerView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.centerY.equalTo(self)
        })
        
        iconImageView = UIImageView()
        iconImageView?.contentMode = .center
        containerView?.addSubview(iconImageView!)
        
        iconImageView?.snp.makeConstraints({ (make) in
            make.height.width.equalTo(configuration.tabBarItemIconSize)
            make.top.equalTo(containerView!)
            make.centerX.equalTo(containerView!)
        })
        
        titleLabel = UILabel()
        titleLabel?.textAlignment = .center
        titleLabel?.font = configuration.tabBarItemTitleFont
        containerView?.addSubview(titleLabel!)
        
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(containerView!)
            make.top.equalTo(iconImageView!.snp.bottom).offset(configuration.tabBarItemTitleIconSpacing)
            make.bottom.equalTo(containerView!)
        })
        
        backgroundColor = configuration.tabBarBackgroundColor
        containerView?.backgroundColor = configuration.tabBarBackgroundColor
        
        title = NSLocalizedString(tabBarItem.title ?? "", comment: "")
        icon = tabBarItem.image
    }
}
