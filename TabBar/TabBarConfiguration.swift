//
//  TabBarConfiguration.swift
//  TabBar
//
//  Created by Dennis Dreissen on 02/07/2018.
//  Copyright © 2018 DennisDreissen. All rights reserved.
//

import Foundation

public class TabBarConfiguration {
    public static let shared = TabBarConfiguration()
    
    public var tabBarHeight: CGFloat = 67.0
    public var tabBarBackgroundColor = UIColor.white
    
    public var tabBarItemIconColor = UIColor.black
    public var tabBarItemTitleColor = UIColor.black
    public var tabBarItemSelectedIconColor = UIColor(red:0.968, green:0.29, blue:0.325, alpha:1)
    public var tabBarItemSelectedTitleColor = UIColor(red:0.968, green:0.29, blue:0.325, alpha:1)
    
    public var tabBarItemTitleFont = UIFont.systemFont(ofSize: 10)
    public var tabBarItemTitleIconSpacing: CGFloat = 4.0
    public var tabBarItemIconSize: CGFloat = 22.0
}
