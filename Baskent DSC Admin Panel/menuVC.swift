//
//  menuVC.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 7.01.2023.
//

import UIKit

class menuVC: UIViewController {

    @IBOutlet weak var menuTitle: UIButton!
    @IBOutlet weak var personalImg: UIImageView!
    @IBOutlet weak var adminsImg: UIImageView!
    @IBOutlet weak var announcmentImg: UIImageView!
    @IBOutlet weak var statImg: UIImageView!
    @IBOutlet weak var boardMembersImg: UIImageView!
    @IBOutlet weak var sssImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personalImg.layer.cornerRadius = 7
        adminsImg.layer.cornerRadius = 7
        announcmentImg.layer.cornerRadius = 7
        statImg.layer.cornerRadius = 7
        boardMembersImg.layer.cornerRadius = 7
        sssImg.layer.cornerRadius = 7
        
        personalImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(personalImgTapped)))
        adminsImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(adminsImgTapped)))
        menuTitle.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
        
        //-----------
        
                   /*         let url = URL(string: "http://localhost:8888/api/v1/announcements/6388e9c654ef8970e09cd093")
                            var request = URLRequest(url: url!)
                            request.httpMethod = "PATCH"
                            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                            var parameters: [String: String] = [
                                "name": "data",
                            ]
                            parameters["name"] = "31"
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
                                    print(responseString)
                                }
                            }
                            task.resume()
        */
        
    }
    @objc func personalImgTapped() {
        performSegue(withIdentifier: "menutoPersonal", sender: nil)
        personalImg.alpha = 0.5
        _ = Timer.scheduledTimer(withTimeInterval: 1/7, repeats: false) { _ in
            self.personalImg.alpha = 1
        }
       
    }
    @objc func adminsImgTapped() {
        performSegue(withIdentifier: "menutoPersonal", sender: nil)
        adminsImg.alpha = 0.5
        _ = Timer.scheduledTimer(withTimeInterval: 1/7, repeats: false) { _ in
            self.adminsImg.alpha = 1
        }
       
    }
   

}
