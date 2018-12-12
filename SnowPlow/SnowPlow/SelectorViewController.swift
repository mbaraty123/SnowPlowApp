//
//  SelectorViewController.swift
//  SnowPlow
//
//  Created by Michael Baraty on 12/12/18.
//  Copyright © 2018 Baraty Hannibal Enterprises. All rights reserved.
//

import UIKit

class SelectorViewController: UIViewController {
    
    
    @IBOutlet weak var userOptionButton: UIButton!
    @IBOutlet weak var plowOptionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userOptionButton.layer.cornerRadius = 60
        plowOptionButton.layer.cornerRadius = 60
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
