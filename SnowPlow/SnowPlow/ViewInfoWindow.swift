//
//  ViewInfoWindow.swift
//  SnowPlow
//
//  Created by Michael Baraty on 1/15/19.
//  Copyright © 2019 Baraty Hannibal Enterprises. All rights reserved.
//

import UIKit

protocol MapMarkerDelegate: class {
    func didPressAcceptButton(data: NSDictionary)
}


class ViewInfoWindow: UIView {

    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        
    }
        override init(frame: CGRect) {
            super.init(frame: frame)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        func loadView() -> ViewInfoWindow{
            let customInfoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)?[0] as! ViewInfoWindow
            return customInfoWindow
        }
    }

