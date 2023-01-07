//
//  registerVC.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 7.01.2023.
//

import UIKit

class registerVC: UIViewController {
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passFieldAgain: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailField.layer.cornerRadius = 6
        passField.layer.cornerRadius = 6
        passFieldAgain.layer.cornerRadius = 6
        
        signupButton.layer.insertSublayer(getGradientLayer(bounds:signupButton.bounds), at: 0)
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

}
