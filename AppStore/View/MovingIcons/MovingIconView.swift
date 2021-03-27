//
//  MovingIconView.swift
//  AppStore
//
//  Created by Ahmad Khalil on 3/18/21.
//  Copyright © 2021 ahmad. All rights reserved.
//

import UIKit

class MovingIconView : UIView {
    let mainView = UIView()
    
    
    // MARK: - puplic Properties
    // MARK: sizing of the icon
    let iconHeight : CGFloat             = 90
    let margins    : CGFloat             = 15
    let iconOffset : CGFloat             = 10

    // MARK: speed of animation
    let speed      : Double

    // MARK: image Feed as Array
    var imagesArray : [UIImage]
    
    // MARK: - Private Properties
    
    fileprivate let scrollView           : IconScrollView
    fileprivate let scrollView_2          : IconScrollView
    fileprivate let scrollView_3         : IconScrollView

//    fileprivate let scrollView_3         : IconScrollView

    
    fileprivate let multiplier           : Int // how many you want to replay (remove and adding the array)
  

    // MARK: - Icon Configration
    fileprivate func addIconsToScrollView() {
        addIcons(toView: scrollView, icons: imagesArray.rearrange(fromIndex: [5,4,3,2,1,0], toIndex: [imagesArray.count - 1 , imagesArray.count - 2 , imagesArray.count - 3 , imagesArray.count - 4 , imagesArray.count - 5 , imagesArray.count - 6 ]))
        addIcons(toView: scrollView_3, icons: imagesArray)
        addIcons(toView: scrollView_2, icons: imagesArray.rearrange(fromIndex: [2,1,0], toIndex: [imagesArray.count - 1 , imagesArray.count - 2 , imagesArray.count - 3 ]))
    }
    
    func addIcons(toView : UIScrollView ,icons array : [UIImage]) {
        for ( index , image ) in array.enumerated() {
            let icon = UIImageView()
            icon.image = image
            icon.contentMode = .scaleAspectFit
//            icon.backgroundColor = UIColor.darkGray
            icon.layer.borderColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1).cgColor
            icon.layer.borderWidth = 0.5
            icon.layer.cornerRadius = iconHeight/4
            icon.layer.masksToBounds = true
            if index == 0 {
                icon.frame = .init(x: (CGFloat(index) * iconHeight)  , y: 0, width: iconHeight , height: iconHeight)
            }else {
                icon.frame = .init(x: CGFloat(index) * (iconHeight + iconOffset ), y: 0, width: iconHeight , height: iconHeight)
            }
            toView.addSubview(icon)
        }
    }
    
    // MARK: - ScrollView Configration
    
    fileprivate func ConfigureScrollView() {
        let viewFrame = mainView.frame
        let scrollViewHeight = iconHeight + margins
        scrollView.frame = CGRect(x: 0, y: viewFrame.height - scrollViewHeight  , width: viewFrame.width  , height: scrollViewHeight)
        scrollView_2.frame = CGRect(x: -iconHeight/2, y: viewFrame.height - (2*scrollViewHeight)  , width: viewFrame.width + iconHeight/2, height: scrollViewHeight)
        scrollView_3.frame = CGRect(x: 0, y: viewFrame.height - (3*scrollViewHeight)  , width: viewFrame.width, height: scrollViewHeight)
        print("conFigureScrollView logger")
        scrollView.recycleViews()
        scrollView_2.recycleViews()
        scrollView_3.recycleViews()

    }
    
    // MARK: - Configring the Main View
    
    fileprivate func ConfigureMainView() {
        backgroundColor = .clear
        addSubview(mainView)
        mainView.frame = .init(x: 0, y:  frame.height - 425 , width: frame.width , height: 400 )
//        mainView.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.8392156863, blue: 0.8588235294, alpha: 1)
        mainView.backgroundColor = .clear
        mainView.clipsToBounds = true
    }
    
    // MARK: - collecting ALl Configration
    func configuration(){
        ConfigureMainView()
        ConfigureScrollView()
        addIconsToScrollView()
        mainView.addSubview(scrollView)
        mainView.addSubview(scrollView_2)
        mainView.addSubview(scrollView_3)
    }
    
    // MARK: - View Life Cycle
    init(imagesArray : [UIImage] , speed : Double , multiplier : Int) {
        self.scrollView_2 = IconScrollView(views: imagesArray, iconHeight: iconHeight, iconOffset: iconOffset, speed: speed, multiplier: multiplier)
        self.scrollView_3 = IconScrollView(views: imagesArray, iconHeight: iconHeight, iconOffset: iconOffset, speed: speed, multiplier: multiplier)
        self.scrollView = IconScrollView(views: imagesArray , iconHeight: iconHeight, iconOffset: iconOffset, speed: speed, multiplier: multiplier)
        self.multiplier = multiplier
        self.imagesArray = imagesArray
        self.speed = speed
        super.init(frame: CGRect.zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        configuration()
    }

}
