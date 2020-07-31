//
//  UIView+Constrain.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/23/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    open func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,padding : UIEdgeInsets = .zero , size : CGSize = .zero ) -> AnchoredConstraints {
        
        var anchoredConstraints = AnchoredConstraints()
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    open func fillSuperviewWithPadding(padding: UIEdgeInsets = .zero) {
         translatesAutoresizingMaskIntoConstraints = false
         if let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor {
             topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
         }
         
         if let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor {
             bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
         }
         
         if let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor {
             leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
         }
         
         if let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor {
             trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
         }
     }
    
    open func fillSuperView(){
        translatesAutoresizingMaskIntoConstraints = false
        if let superView = superview {
            let top = topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor)
            let left = leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor)
            [top,bottom,left,right].forEach{$0.isActive = true }
        }
    }
    
    open func centerXanchorToSuperView(){
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXanchor = superview?.safeAreaLayoutGuide.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXanchor).isActive = true
        }
    }
    
    open func centerYanchorToSuperView(){
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterYanchor = superview?.safeAreaLayoutGuide.centerYAnchor {
            centerYAnchor.constraint(equalTo: superViewCenterYanchor).isActive = true
        }
    }
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    open func  centerInSuperview(size: CGSize = .zero){
        centerYanchorToSuperView()
        centerXanchorToSuperView()
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
