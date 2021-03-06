//
//  UIDevice.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/09.
//

import Foundation
import UIKit

extension UIDevice {
    public var isiPhoneSE: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 568 && UIScreen.main.bounds.size.width == 320) {
            return true
        }
        return false
    }
    
    public var isiPhoneSE2: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 667 && UIScreen.main.bounds.size.width == 375) {
            return true
        }
        return false
    }
    
    public var isiPhone8Plus: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 736 || UIScreen.main.bounds.size.width == 414) {
            return true
        }
        return false
    }
    
    public var isiPhone12mini: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 812 && UIScreen.main.bounds.size.width == 375) {
            return true
        }
        return false
    }
    
    public var isiPhone12Pro: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 844 && UIScreen.main.bounds.size.width == 390) {
            return true
        }
        return false
    }
}
