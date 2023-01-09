//
//  announcementVC.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 7.01.2023.
//

import UIKit

struct annData: Decodable{
    let data: [annData2]
    let results: Int
    let status: String
    
    
}

struct annData2: Decodable{
    let data: [ann]
}

struct ann: Decodable{
    let imageCover: String
    let description: String
    let name: String
    let summary: String
    let date: Date
    let id: String
    
    
    
}

struct Announcement: Codable {
    let id: String
    let name: String
    let summary: String
    let description: String
    let date: Date
    let imageCover: String
}
struct Response: Codable {
    let data: [Announcement]
}


class announcementVC: UIViewController,UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    
    
    let url = URL(string: "http://localhost:8888/api/v1/announcements")
    let session = URLSession.shared
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "annCell", for: indexPath)
        
        
        
        
        return cell
    }
    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        if url != nil{
            let task = session.dataTask(with: url!) { data, res, err in
                if err != nil{
                    print(err!.localizedDescription as String)
                    
                }
                else{
                    
                    if data != nil{
                        do{
                            let jsonRes = try JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers)
                            //let jsonRes2 = jsonRes["data"] as! Dictionary<String,Any>
                            
                            //let jsonRes3 = try JSONDecoder().decode(annData.self, from: jsonRes2 as! Data)
                            
                            //let response = try decoder.decode(Response.self, from: jsonRes2 as! Data)
                                //let announcements = response.data
                                //print(announcements)
                            
                            DispatchQueue.main.async {
                                print(jsonRes)
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
        
        
        
        
    }
    



