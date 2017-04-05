//
//  TapSlider.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

protocol TapSliderDelegate {
    func changeValue(value: Float)
}

class TapSlider: UISlider {
    
    
    let step = 1
    
    let redColor : UIColor = UIColor(red:0.93, green:0.26, blue:0.31, alpha:1.0)
    let yellowColor : UIColor = UIColor(red:1.00, green:0.79, blue:0.19, alpha:1.0)
    let greenColor : UIColor = UIColor(red:0.41, green:0.82, blue:0.50, alpha:1.0)
    
    
    var delegate : TapSliderDelegate?
    

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.size.width, height: 10)
    }
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        setTapGestureRecognizer()
        
    }
    
    
    func triggerDelegate() {
        delegate?.changeValue(value: getRating())
    }
    
    
    func getRawRating() -> Float {
        return self.value
    }
    
    func getRating() -> Float {
        return self.value / 2
    }
    func setRating(value : Float) {
        calculateValue(value: value)
    }
    
    func setTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sliderTapped))
        self.addGestureRecognizer(tapGestureRecognizer)
        //
        self.addTarget(self, action: #selector(sliderValueChanged), for: UIControlEvents.valueChanged)
    }
    func sliderTapped(gestureRecognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = gestureRecognizer.location(in: self)
        let positionOfSlider: CGPoint = self.frame.origin
        let widthOfSlider: CGFloat = self.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(self.maximumValue) / widthOfSlider)
        calculateValue(value: Float(newValue))
    }
    //
    func sliderValueChanged(slider: UISlider!) {
        calculateValue(value: slider.value)
    }
    
    private func calculateValue(value : Float) {
        let roundedValue = round(value / Float(step)) * Float(step)
        self.setValue(roundedValue, animated: true)
        setTintColor()
        delegate?.changeValue(value: getRating())
    }
    
    private func setTintColor() {
        if self.value <= 3 {
            self.tintColor = redColor
        }
        if self.value > 3 && self.value <= 7 {
            self.tintColor = yellowColor
        }
        if self.value > 7 {
            self.tintColor = greenColor
        }
    }
}
