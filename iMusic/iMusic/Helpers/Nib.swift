//
//  Nib.swift
//  iMusic
//
//  Created by admin on 07.07.2022.
//

import Foundation
import UIKit

extension UIView {
    class func loadFromNib<T: UIView> () -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
