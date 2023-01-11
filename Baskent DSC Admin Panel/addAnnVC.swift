//
//  addAnnVC.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 11.01.2023.
//

import UIKit

class addAnnVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addSummary: UITextField!
    @IBOutlet weak var addKatil: UITextField!
    @IBOutlet weak var addDescp: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTapRecog = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        addImage.addGestureRecognizer(imageTapRecog)
        
        
        
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
    }
    
    

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func selectImage(){
           let picker = UIImagePickerController()
           picker.delegate = self
           picker.sourceType = .photoLibrary
           picker.allowsEditing = true
           present(picker, animated: true,completion: nil)
       }
                                      
    @IBAction func addButtonPressed(_ sender: Any) {
        let url = URL(string: "http://localhost:8888/api/v1/announcements")
        
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let date = Date()
        let isoFormatter = ISO8601DateFormatter()
        let isoDate = isoFormatter.string(from: date)
        
        var parameters: [String: Any] = [
            "name": "nil",
            "summary": "nil",
            "link": "nil",
            "description": "nil",
            "imageCover": "nil",
            "date": "nil"
            
        ]
 
        parameters["name"] = addTitle.text
        parameters["summary"] = addSummary.text
        parameters["link"] = addKatil.text
        parameters["description"] = addDescp.text
        parameters["imageCover"] = "null"
        parameters["date"] = isoDate
       
        
        let body = try! JSONSerialization.data(withJSONObject: parameters , options: [])
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("server error")
                print(response!)
                return
            }
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print(responseString!)
                DispatchQueue.main.async {
            
                    self.navigationController?.popViewController(animated: true)
                    
                }
                
                
            }
        }
        task.resume()
    }
                                      
    
}
