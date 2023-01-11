//
//  announcementVC.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 7.01.2023.
//

import UIKit

class announcementVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var addAnn: UIBarButtonItem!
    var finalData: [[String: Any]] = []
    var ready:Bool = false
    var selectedRow:Int?
    
    
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
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "anntoAnnDetails", sender: nil)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            let ID = finalData[indexPath.row]["id"] as? String
            
             let url = URL(string: "http://localhost:8888/api/v1/announcements/" + ID!)
             
             
             var request = URLRequest(url: url!)
             request.httpMethod = "DELETE"
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             

             
             let task = URLSession.shared.dataTask(with: request) { data, response, error in
             if let error = error {
             print(error)
             return
             }
             guard let httpResponse = response as? HTTPURLResponse,
             (200...299).contains(httpResponse.statusCode) else {
             print(response!)
             return
             }
                 
  
             }
             task.resume()
            self.finalData.remove(at: indexPath.row)
            self.table.reloadData()
             }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "anntoAnnDetails"{
            let annDetailVC = segue.destination as! annDetailVC
            annDetailVC.Titlee = finalData[self.selectedRow!]["name"] as? String
            annDetailVC.Descp = finalData[self.selectedRow!]["description"] as? String
            annDetailVC.Datee = finalData[self.selectedRow!]["date"] as? String
            annDetailVC.Image = finalData[self.selectedRow!]["imageCover"] as? String
        }
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
    



