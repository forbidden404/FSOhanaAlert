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
    
    var completion: ((Any?, Error?) -> Void)?
    
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
        // Rounded corners
        self.layoutIfNeeded()
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
    }
    
    public override func didMoveToSuperview() {
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = CGAffineTransform.identity
        })
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
        
        leftButton.setTitle("Cancel", for: .normal)
        rightButton.setTitle("Take", for: .normal)
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
    }
    
    public func set(completion: @escaping ((Any?, Error?) -> Void)) {
        self.completion = completion
        leftButton.isHidden = false
        rightButton.isHidden = false
        leftButton.isUserInteractionEnabled = true
        rightButton.isUserInteractionEnabled = true
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
}
