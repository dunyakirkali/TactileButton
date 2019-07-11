//
//  ViewController.swift
//  TactileButton
//
//  Created by f941381defc64b2588b9f4db8ade0a4896544b6c on 09/04/2018.
//  Copyright (c) 2018 f941381defc64b2588b9f4db8ade0a4896544b6c. All rights reserved.
//

import UIKit
import TactileButton

class ViewController: UIViewController {
    let curves = [
        Curve<Float>.quadratic,
        Curve<Float>.cubic,
        Curve<Float>.quartic,
        Curve<Float>.quintic,
        Curve<Float>.sine,
        Curve<Float>.circular,
        Curve<Float>.exponential,
        Curve<Float>.elastic,
        Curve<Float>.back,
        Curve<Float>.bounce,
    ]
    var easing = [
        EasingMode<Float>.easeIn,
        EasingMode<Float>.easeOut,
        EasingMode<Float>.easeInOut
    ]
    
    @IBOutlet weak var shadowRadius: UISlider!
    @IBOutlet weak var heightRate: UISlider!
    @IBOutlet weak var curveSelector: UIPickerView!
    @IBOutlet weak var easeSelector: UIPickerView!
    @IBOutlet weak var scaleRate: UISlider!
    @IBOutlet weak var sdwButton: TactileButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curveSelector.delegate = self
        easeSelector.delegate = self
    }
}

extension ViewController {
    @IBAction func shadowRadiusChanged(_ sender: Any) {
        sdwButton.shadowSize = shadowRadius.value
    }
    
    @IBAction func scaleRateChanged(_ sender: Any) {
        sdwButton.scaleRate = scaleRate.value
    }
    
    @IBAction func heightRateChanged(_ sender: Any) {
        sdwButton.heightRate = heightRate.value
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case curveSelector:
            return curves.count
        case easeSelector:
            return easing.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case curveSelector:
            sdwButton.curveType = curves[row]
        case easeSelector:
            sdwButton.easingType = easing[row]
        default:
            print("Who is this?")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case curveSelector:
            return "\(curves[row])"
        case easeSelector:
            return "\(easing[row])"
        default:
            return "Who is this?"
        }
    }
}
