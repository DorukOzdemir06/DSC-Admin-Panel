//
//  ViewController.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 6.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
       
        
     
                
        
        mailField.layer.cornerRadius = 6
        passwordField.layer.cornerRadius = 6
        
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
   
    @IBAction func loginButtonPressed(_ sender: Any) {
        let url = URL(string: "http://localhost:8888/api/v1/users/login")
        let session = URLSession.shared
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var parameters: [String: String] = [
            "email": "mail",
            "password": "pass"
        ]
        
        parameters["email"] = mailField.text
        parameters["password"] = passwordField.text
        
        let body = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("server error")
                return
            }
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    print(responseString)
                    
                    self.performSegue(withIdentifier: "logintoMenu", sender: nil)
                }
                
                
            }
        }
        task.resume()
        



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

