//
//  MyProgressView.swift
//  EggTimer
//
//  Created by mac on 08.01.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation
import UIKit

class MyProgressView: UIProgressView {
    override func layoutSubviews() {
           super.layoutSubviews()

           let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 20.0)
           let maskLayer = CAShapeLayer()
           maskLayer.frame = self.bounds
           maskLayer.path = maskLayerPath.cgPath
           layer.mask = maskLayer
       }
}
