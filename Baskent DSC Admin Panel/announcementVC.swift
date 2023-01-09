//
//  announcementVC.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 7.01.2023.
//

import UIKit

class announcementVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    var finalData: [[String: Any]] = []
    var ready:Bool = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "annCell", for: indexPath) as! announcementCell
        
        cell.title.text = finalData[indexPath.row]["name"] as? String
        cell.short.text = finalData[indexPath.row]["summary"] as? String
        cell.imageMain.image =  UIImage(named: finalData[indexPath.row]["imageCover"] as! String)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "test123", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        DispatchQueue.global().async {
            self.fetchData()
        }
        while !self.ready {
            if self.ready {
                table.reloadData()
                break
            }
        }

        
    }



        
    func fetchData() {
        let url = URL(string: "http://localhost:8888/api/v1/announcements")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
          guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
          }
          let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
          if let responseJSON = responseJSON as? [String: Any] {
            if let status = responseJSON["status"] as? String, status == "success" {
              if let dataDict = responseJSON["data"] as? [String: Any],
                 let dataArray = dataDict["data"] as? [[String: Any]] {
                  self.finalData = dataArray
                  self.ready = true
              } else {
                print("Error: Could not retrieve data from response")
              }
            } else {
              print("Error: Invalid status in response")
            }
          } else {
            print("Error: Could not parse response as JSON")
          }
        }
        task.resume()
        
      }


    


    }
    



