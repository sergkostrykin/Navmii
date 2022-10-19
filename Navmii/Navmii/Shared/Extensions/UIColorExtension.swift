//
//  StringExtension.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import UIKit

extension UIColor {
    
    class var colorRandom: UIColor {
        return mapColorArray.randomElement() ?? .colorBlue
    }

    class var colorDarkBlue: UIColor {
        return UIColorMakeRGB(red: 11, green: 112, blue: 178)
    }
    
    class var colorSolidBlue: UIColor {
        return UIColorMakeRGB(red: 6, green: 28.0, blue: 64.0)
    }
    
    class var colorBlack: UIColor {
        return UIColorMakeRGB(red: 18, green: 18, blue: 18)
    }

    class var colorLightBlack: UIColor {
        return UIColor(hex: "#2C2C2C")
    }
    
    class var colorDarkGray: UIColor {
        return UIColor(hex: "#707070")
    }

    class var colorLightGray: UIColor {
        return UIColor(hex: "#D0D0D0")
    }
    
    class var colorBlue: UIColor {
        return UIColor(hex: "#54A8DD")
    }
    
    class var colorLightBlue: UIColor {
        return UIColor(hex: "#29ABE2")
    }

    class var colorRed: UIColor {
        return UIColor(hex: "#FD3636")
    }
    
    class var colorLightRed: UIColor {
        return UIColor(hex: "#EC5455")
    }

    class var colorGreen: UIColor {
        return UIColor(hex: "#7CBC5A")
    }
    
    class var colorBrightGreen: UIColor {
        return UIColor(hex: "#59C121")
    }
    
    class var colorGray: UIColor {
        return UIColor(hex: "#2F2F2F")
    }
    
    class var colorOrange: UIColor {
        return UIColor(hex: "#EDBE5B")
    }

    class var border: UIColor {
        return UIColor(red: 0.749, green: 0.792, blue: 0.808, alpha: 1.00)
    }
    
    class var mapBlue: UIColor {
        return UIColor(red: 0.165, green: 0.671, blue: 0.886, alpha: 1.00)
    }
    
    class var mapRed: UIColor {
        return UIColor(red: 0.929, green: 0.106, blue: 0.141, alpha: 1.00)
    }

    class var mapPurple: UIColor {
        return UIColor(red: 0.580, green: 0.366, blue: 1.000, alpha: 1.00)
    }

    class var mapGreen: UIColor {
        return UIColor(red: 0.553, green: 0.776, blue: 0.247, alpha: 1.00)
    }

    class var mapTan: UIColor {
        return UIColor(red: 0.867, green: 0.820, blue: 0.761, alpha: 1.00)
    }

    class var mapMint: UIColor {
        return UIColor(red: 0.331, green: 0.910, blue: 0.867, alpha: 1.00)
    }

    class var mapYellow: UIColor {
        return UIColor(red: 1.000, green: 0.988, blue: 0.448, alpha: 1.00)
    }

    class var mapOrange: UIColor {
        return UIColor(red: 1.000, green: 0.640, blue: 0.198, alpha: 1.00)
    }
    
    class var mapDBlue: UIColor {
        return UIColor(red: 0.000, green: 0.083, blue: 0.819, alpha: 1.00)
    }

    class var mapPastelRed: UIColor {
        return UIColor(red: 0.819, green: 0.538, blue: 0.520, alpha: 1.00)
    }

    class var mapForestGreen: UIColor {
        return UIColor(red: 0.094, green: 0.510, blue: 0.108, alpha: 1.00)
    }
    
    class var mapColorArray: [UIColor] {
        return [.mapBlue, .mapRed, .mapPurple, .mapGreen, .mapTan, .mapMint, .mapYellow, .mapOrange, .mapDBlue, .mapPastelRed, .mapForestGreen]
    }
}


func UIColorMakeRGBAlpha(red: Float, green: Float, blue: Float, alpha: Float) -> UIColor {
    return UIColor(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue: CGFloat(blue / 255.0), alpha: CGFloat(alpha))
}

func UIColorMakeRGB(red: Float, green: Float, blue: Float) -> UIColor {
    return UIColorMakeRGBAlpha(red: red, green: green, blue: blue, alpha: 1.0)
}

func UIColorMakeGray(_ level: Float) -> UIColor {
    return UIColorMakeRGBAlpha(red: level, green: level, blue: level, alpha: 1.0)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        let netHex = Int(rgbValue)
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        return String(format: "#%06x", rgb)
    }

}
