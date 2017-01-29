//
//  Tag.swift
//  AmusementPark
//
//  Created by Andros Slowley on 1/21/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import UIKit

class Tag: UIView {

    
    override func draw(_ rect: CGRect) {
    let rect = CGRect.init(x: 0, y: 0.0, width: self.frame.width, height: self.frame.height)
       let path1 = UIBezierPath.init(roundedRect: rect, cornerRadius: 25)
 UIColor.white.setFill()
        path1.fill()
     
        
        let rect2 = CGRect.init(x: (self.frame.midX - 100), y: 10.0, width: 80, height: 20)
        let path2 = UIBezierPath.init(roundedRect: rect2, cornerRadius: 10)
        UIColor
            .init(red: 211/255, green: 205/255, blue: 216/255, alpha: 1.0).setFill()
        path2.fill()

    }
    

}
