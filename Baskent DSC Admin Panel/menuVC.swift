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
        announcmentImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(announcmentImgTapped)))
        menuTitle.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
        
        
    }
    @objc func personalImgTapped() {
        personalImg.alpha = 0.5
        performSegue(withIdentifier: "menutoPersonal", sender: nil)
        _ = Timer.scheduledTimer(withTimeInterval: 1/7, repeats: false) { _ in
            self.personalImg.alpha = 1
        }
       
    }
    @objc func adminsImgTapped() {
       
        adminsImg.alpha = 0.5
        _ = Timer.scheduledTimer(withTimeInterval: 1/7, repeats: false) { _ in
            self.adminsImg.alpha = 1
        }
       
    }
    
    @objc func announcmentImgTapped() {
        
        announcmentImg.alpha = 0.5
        performSegue(withIdentifier: "menutoAnn", sender: nil)
        _ = Timer.scheduledTimer(withTimeInterval: 1/7, repeats: false) { _ in
            self.announcmentImg.alpha = 1
        }
       
    }

}
