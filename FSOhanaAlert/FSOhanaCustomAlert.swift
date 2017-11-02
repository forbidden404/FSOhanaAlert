//
//  FSOhanaCustomAlert.swift
//  FSOhanaAlert
//
//  Created by Francisco Soares on 26/10/17.
//  Copyright © 2017 Francisco Soares. All rights reserved.
//

import UIKit

public class FSOhanaCustomAlert: UIView {

    @IBOutlet weak var ohanaImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var okButton: UIButton!
    var hasOkButton: Bool = false {
        willSet {
            okButton.isHidden = !newValue
            okButton.isUserInteractionEnabled = newValue
            okButton.tintColor = FSOhanaButtonType.standard.color()
            okButton.titleLabel?.font = FSOhanaButtonType.standard.font()
        }
    }
    
    var completion: ((Any?, Error?) -> Void)? {
        didSet {
            leftButton.isHidden = false
            rightButton.isHidden = false
            leftButton.isUserInteractionEnabled = true
            rightButton.isUserInteractionEnabled = true
            hasOkButton = false
        }
    }
    
    let nibName = "FSOhanaCustomAlert"
    var contentView: UIView!
    
    // MARK: Set Up View
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    public override func layoutSubviews() {
        self.layoutIfNeeded()
        
         if completion == nil && !hasOkButton {
         self.buttonStackView.removeFromSuperview()
         self.contentView.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height - (self.buttonStackView.bounds.size.height/2.0))
         }
        
        // Shadow
        self.contentView.backgroundColor = UIColor.clear
        for subview in self.contentView.subviews {
            subview.backgroundColor = UIColor.clear
        }
        let shadowPath = UIBezierPath(rect: self.contentView.bounds)
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.contentView.layer.shadowOpacity = 0.5
        self.contentView.layer.shadowPath = shadowPath.cgPath

        // Corner
        let border = UIView()
        border.frame = self.contentView.bounds
        border.layer.masksToBounds = true
        border.clipsToBounds = true
        border.layer.cornerRadius = 10
        border.layer.backgroundColor = UIColor.white.cgColor
        self.contentView.addSubview(border)
        self.contentView.sendSubview(toBack: border)
    }
    
    public override func didMoveToSuperview() {
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = CGAffineTransform.identity
        }) { _ in
            if self.completion == nil && !self.hasOkButton {
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when) {
                    UIView.animate(withDuration: 0.20, delay: 0, options: .curveEaseOut, animations: {
                        self.contentView.alpha = 0.0
                        self.contentView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                    }) { _ in
                        self.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
                
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        contentView.frame = aspectRatio()
        addSubview(contentView)
        
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.alpha = 0.0
        
        textLabel.text = ""
        textLabel.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        leftButton.isHidden = true
        leftButton.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        rightButton.isHidden = true
        rightButton.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        hasOkButton = false
        okButton.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func aspectRatio() -> CGRect {
        var frame = self.contentView.frame
        
        while frame.width > self.frame.width {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width / 1.2, height: frame.height / 1.2)
        }
        
        return frame
    }
    
    public func set(image: UIImage) {
        self.ohanaImageView.image = image
    }
    
    public func set(text: String) {
        self.textLabel.text = text
        self.textLabel.adjustsFontSizeToFitWidth = true
    }
    
    public func set(completion: @escaping ((Any?, Error?) -> Void), with titles: [String] = ["Cancel", "Take"], and types: [FSOhanaButtonType] = [.cancel, .standard]) {
        self.completion = completion
        leftButton.tintColor = types[0].color()
        rightButton.tintColor = types[1].color()
        leftButton.titleLabel?.font = types[0].font()
        rightButton.titleLabel?.font = types[1].font()
        leftButton.setTitle(titles[0], for: .normal)
        rightButton.setTitle(titles[1], for: .normal)
    }
    
    public func has(okButton: Bool) {
        self.hasOkButton = okButton
    }

    @IBAction func leftButtonPressed(_ sender: UIButton) {
        guard let completion = completion else {
            return
        }
        completion(nil, FSError.LeftButton)
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        guard let completion = completion else {
            return
        }
        completion(self, FSError.RightButton)
    }
    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        self.removeFromSuperview()
    }
}
