//
//  VerticalStackView.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/28/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class VerticalStackView : UIStackView {
    
    init(arrangedSubViewsArray : Array<UIView>  , spacing: CGFloat = 0) {
        super.init(frame : .zero)
        arrangedSubViewsArray.forEach{addArrangedSubview($0)}
        super.spacing = spacing
        super.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
