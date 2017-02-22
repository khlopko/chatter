//
//  Color.swift
//
//  Created by Kirill Khlopko on 11/11/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

public extension UIColor {
 
	public static var amaranth: UIColor { return rgba(238, 45, 67) }
	
	public static var malibu: UIColor { return rgba(109, 184, 224) }
	
	public static var paleCornflowerBlue: UIColor { return rgba(191, 223, 242) }
	public static var pictonBlue: UIColor { return rgba(80, 165, 211) }
	public static var pictonBlueDarker: UIColor { return rgba(5, 90, 131) }


    // 2

    public static var v21: UIColor { return rgba(255, 209, 102) }
    public static var v22: UIColor { return rgba(78, 205, 196) }
    public static var v23: UIColor { return rgba(247, 255, 247) }
    public static var v24: UIColor { return rgba(255, 107, 107) }
    public static var v25: UIColor { return rgba(255, 230, 109) }
    public static var v26: UIColor { return rgba(196, 241, 190) }
    public static var v27: UIColor { return rgba(58, 183, 149) }
    public static var v28: UIColor { return rgba(46, 64, 82) }

    // 3

    public static var v31: UIColor { return rgba(109, 184, 224) }
}

private func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
	return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}
