//
//  TactileButton.swift
//  TactileButton
//
//  Created by Dunya Kirkali on 04/09/2018.
//

@IBDesignable
public class TactileButton: UIButton {
    var impactOccured: Bool = false
    
    public var scaleRate: Float = 0.1
    public var heightRate: Float = 0.05
    public var shadowSize: Float = 10.0
    public var curveType = Curve<Float>.quadratic
    public var easingType = EasingMode<Float>.easeIn
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    private func curvedForce(_ normalizedForce: Float) -> Float {
        return easingType.mode(curveType)(normalizedForce)
    }
    
    // TODO: Clean up!
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if let firstTouch = touches.first {
            let impact = UIImpactFeedbackGenerator()
            let force: Float = Float(firstTouch.force)
            let macForce: Float = Float(firstTouch.maximumPossibleForce)
            let normalizedForce = force / macForce
            let scaleTransform = 1.0 - scaleRate * curvedForce(normalizedForce)

            if scaleTransform <= 1.0 - scaleRate {
                if !impactOccured {
                    impactOccured = true
                    impact.impactOccurred()
                }
            } else {
                impactOccured = false
            }
            let transform = CGAffineTransform(scaleX: CGFloat(scaleTransform), y: CGFloat(scaleTransform))
            
            let scaleRadius: Float = shadowSize - (normalizedForce * shadowSize)
            let translationY: Float = normalizedForce * (Float(frame.size.height) * heightRate)
            
            let traslationTransform = CGAffineTransform(translationX: 0.0, y: CGFloat(translationY))
            
            self.shadowRadius = CGFloat(scaleRadius)
            self.transform = traslationTransform.concatenating(transform)
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        resetScale()
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        resetScale()
    }
    
    private func resetScale() {
        let scale: CGFloat = 1.0
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        
        self.transform = transform
        self.shadowRadius = CGFloat(shadowSize)
    }
}
