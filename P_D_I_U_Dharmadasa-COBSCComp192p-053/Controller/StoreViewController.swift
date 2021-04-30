//
//  StoreViewController.swift
//  P_D_I_U_Dharmadasa-COBSCComp192p-053
//
//  Created by Upeksha Dharmadasa on 4/29/21.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    
    @IBOutlet weak var Preview: UIView!
    @IBOutlet weak var Category: UIView!
    @IBOutlet weak var Menu: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func SwitchView(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            Preview.alpha = 1
            Category.alpha = 0
            Menu.alpha = 0
        }
        else if sender.selectedSegmentIndex == 1{
            Category.alpha = 1
            Preview.alpha = 0
            Menu.alpha = 0
        }
        else if sender.selectedSegmentIndex == 2{
            Menu.alpha = 1
            Preview.alpha = 0
            Category.alpha = 0
        }
        else{
            Preview.alpha = 1
            Category.alpha = 0
            Menu.alpha = 0
        }
   }
}
