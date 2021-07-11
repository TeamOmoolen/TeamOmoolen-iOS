//
//  UIColor.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/01.
//

import Foundation
import UIKit

// MARK: - Component Color

extension UIColor {

  @nonobjc class var omThirdGray: UIColor {
    return UIColor(white: 137.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var omSecondGray: UIColor {
    return UIColor(white: 99.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var omMainOrange: UIColor {
    return UIColor(red: 1.0, green: 154.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var omFifthGray: UIColor {
    return UIColor(white: 240.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var omMainGreen: UIColor {
    return UIColor(red: 106.0 / 255.0, green: 210.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var omMainRed: UIColor {
    return UIColor(red: 215.0 / 255.0, green: 38.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var omFourthGray: UIColor {
    return UIColor(white: 202.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var omMainBlack: UIColor {
    return UIColor(white: 87.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var omWhite: UIColor {
    return UIColor(white: 1.0, alpha: 1.0)
  }

  @nonobjc class var bubbleGumPink: UIColor {
    return UIColor(red: 243.0 / 255.0, green: 114.0 / 255.0, blue: 161.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var omAlmostwhite: UIColor {
    return UIColor(white: 251.0 / 255.0, alpha: 1.0)
  }

}


// MARK: - hex to UIColor

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
}
