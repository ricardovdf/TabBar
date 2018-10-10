//
//  UIDevice+Extension.swift
//  TabBar
//
//  Created by Dennis Dreissen on 02/07/2018.
//  Copyright © 2018 DennisDreissen. All rights reserved.
//

import Foundation

internal extension UIDevice {
    static func getDeviceType() -> String {
        var deviceTypeName : String = ""
        
        #if targetEnvironment(simulator)
            if let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                deviceTypeName = identifier
            }
        #else
            var size : size_t = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0) 
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            deviceTypeName = String(cString: machine)
        #endif
        
        return deviceTypeName
    }
    
    static var deviceType: deviceType {
        switch UIDevice.getDeviceType() {
            case "iPhone10,3", "iPhone10,6", "iPhone11,2", "iPhone11,4", "iPhone11,6", "iPhone11,8": return .iPhoneX
            default: return .other
        }
    }
}

internal enum deviceType {
    case iPhoneX
    case other
}
