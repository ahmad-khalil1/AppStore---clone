//
//  File.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String , font : UIFont ,numberOfLines : Int = 1 ){
        self.init(frame:.zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

extension Array {
    func rearrange( fromIndex : [Int] , toIndex : [Int]) -> Array {
        if fromIndex.count == toIndex.count {
            var arr = self
            for (index , fromIndex) in fromIndex.enumerated() {
                let element = arr.remove(at: fromIndex)
                arr.insert(element, at: toIndex[index])
            }
            return arr

        }else{
            fatalError()
        }
        fatalError()
       return self
    }
}

extension UIStackView {
    convenience init(verticalStackedViews : [UIView] , spacing : CGFloat? = nil , distrubtion : UIStackView.Distribution = .fill ){
        self.init(arrangedSubviews: verticalStackedViews)
        if let spacing = spacing {
            self.spacing = spacing
        }
        self.alignment = .leading
        self.axis = .vertical
        self.distribution = distrubtion
        
    }
    convenience init(horizontalStackedViews : [UIView] , spacing : CGFloat? = nil , distrubtion : UIStackView.Distribution = .fill ){
        self.init(arrangedSubviews: horizontalStackedViews)
        if let spacing = spacing {
            self.spacing = spacing
        }
        self.alignment = .center
        self.axis = .horizontal
        self.distribution = distrubtion
        
    }
}

