//
//  ViewController.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 6.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var secondTitle: UILabel!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        
        secondTitle.textColor = gradientColor(bounds: secondTitle.bounds, gradientLayer: getGradientLayer(bounds: secondTitle.bounds))
        
        loginButton.layer.insertSublayer(getGradientLayer(bounds: loginButton.bounds), at: 0)
        loginButton.layer.cornerRadius = 8.0
        loginButton.clipsToBounds = true
        loginButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
        
        signupButton.layer.insertSublayer(getGradientLayer(bounds: signupButton.bounds), at: 0)
        signupButton.layer.cornerRadius = 8.0
        signupButton.clipsToBounds = true
        signupButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
       
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)

        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    //order of gradient colors
        gradient.colors = [UIColor.cyan.cgColor, UIColor.systemBlue.cgColor]
    // start and end points
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    return gradient
    }
    private func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
      //create UIImage by rendering gradient layer.
    gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
      //get gradient UIcolor from gradient UIImage
    return UIColor(patternImage: image!)
    }
}

