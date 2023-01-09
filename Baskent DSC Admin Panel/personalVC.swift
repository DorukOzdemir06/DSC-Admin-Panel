//
//  personalVC.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 7.01.2023.
//

import UIKit

class personalVC: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var role: UILabel!
    
    let url = URL(string: "http://localhost:8888/api/v1/users/me")
    let session = URLSession.shared
    
    override func viewWillAppear(_ animated: Bool) {
        if url != nil{
            let task = session.dataTask(with: url!) { data, res, err in
                if err != nil{
                    print(err!.localizedDescription as String)
                    
                }
                else{
                    
                    if data != nil{
                        do{
                            let jsonRes = try JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                            DispatchQueue.main.async {
                                let dat = jsonRes["data"] as! Dictionary<String,Any>
                                let data = dat["data"] as! Dictionary<String,Any>
                                
                                self.name.text = "Name: " + (data["name"] as! String)
                                self.mail.text = "E-mail: " + (data["email"] as! String)
                                self.role.text = "Role: " + (data["role"] as! String)

                            }

                        }
                        catch{
                            print("could not load json object")
                        }
                    }
                    else{
                        print("data is empty")
                    }
                }
            }
            task.resume()
        }
        else{
            print("url is null")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    

    

}
