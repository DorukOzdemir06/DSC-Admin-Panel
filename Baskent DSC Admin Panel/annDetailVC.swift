//
//  annDetailVC.swift
//  Baskent DSC Admin Panel
//
//  Created by Doruk Özdemir on 9.01.2023.
//

import UIKit

class annDetailVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descp: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var titlee: UILabel!
    
    var Datee:String!
    var Descp:String!
    var Image:String!
    var Titlee:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlee.text = Titlee
        date.text = Datee
        descp.text = Descp
        
       
        
    }
    

    
    

}
