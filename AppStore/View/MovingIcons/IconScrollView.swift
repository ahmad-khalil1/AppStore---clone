//
//  IconScrollView.swift
//  AppStore
//
//  Created by Ahmad Khalil on 3/18/21.
//  Copyright © 2021 ahmad. All rights reserved.
//

import UIKit

func delay(_ seconds: Double, completion: @escaping ()->Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class IconScrollView : UIScrollView {
    
    fileprivate let imagesArray : [UIImage]
    fileprivate let speed : Double
    fileprivate let iconOffset : CGFloat
    fileprivate let iconHeight : CGFloat
    fileprivate let multiplier : Int
    
    
    fileprivate var numberofIconOnScreen : Double{
        let iconHeightAndOffset = CGFloat(iconHeight + iconOffset)
        let mainViewFrameWidth = self.frame.width
        
        return Double (mainViewFrameWidth / iconHeightAndOffset)
    }

    
    fileprivate var distanceToAnimate : Double { // the distance animation will elapse based on the muliplayer Factor
        let count = Double(imagesArray.count)
        let multiplier_Double = Double(multiplier)
        let iconHeightAndOffset = Double(iconHeight + iconOffset)
        if multiplier_Double == 1 {
            return  ((count + (count - numberofIconOnScreen)) * iconHeightAndOffset) * multiplier_Double
        }else {
            return ((count + (count - numberofIconOnScreen)) * iconHeightAndOffset) + ((multiplier_Double - 1.0)  * (count * iconHeightAndOffset) )
        }
    }
    //
    fileprivate var duration : Double{ //the time it will take to satisfay the speed and the distance
        distanceToAnimate / speed
    }
    
    fileprivate var delayInSeconds : Double { // return the delay in seconds
        let passedBlock = iconOffset/2 + iconHeight
        return ( Double(passedBlock) / speed )
    }
    
    func animateIcons() {
        let animator = UIViewPropertyAnimator(duration: TimeInterval(duration), curve: .linear) {
            self.contentOffset = .init(x: self.distanceToAnimate, y: 0)
        }
        animator.startAnimation()
    }
    
    func recycleViews() {
        
        let lastIndex = imagesArray.count - 1
        
        for index in 0...((imagesArray.count)*multiplier - 1) {
            
            
            let additionCorrection = Int ( index / 10 )
            let seconds = index > 9 ? ( ( Double(index + 1 + additionCorrection) * (delayInSeconds))) : Double(index + 1) * (delayInSeconds)
            delay( seconds ) { [self] in
                // delay to add and remove from subView
                
                
                var subviews = self.subviews.filter{ image in
                    if image is UIImageView {
                        return true
                    }else{
                        return false
                    }}
                let lastViewFrameMaxX = subviews[lastIndex].frame.maxX
                
                
                if let view = subviews.first {
                    
                    view.removeFromSuperview()
                    subviews.removeFirst()
                    //removed and changing the frame to the last frame.maxX + margin
                    view.frame = .init(x: lastViewFrameMaxX + iconOffset , y: 0, width: iconHeight , height: iconHeight)
                    
                    subviews.append(view)
                    self.addSubview(view)
                    
                }
                
            }
        }
        animateIcons()
     }
    
    
    init(views: [UIImage] , iconHeight : CGFloat ,  iconOffset : CGFloat , speed : Double , multiplier : Int  ){
        self.multiplier = multiplier
        self.imagesArray = views
        self.speed = speed
        self.iconHeight = iconHeight
        self.iconOffset = iconOffset
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
