//
//  DetailViewController.swift
//  MindX
//
//  Created by Hoang Van Pau on 9/9/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var countryName: UILabel!
    @IBOutlet var populationLlabel: UILabel!

    var countryDetail: CoutryDetail? {
        didSet {
            countryName.text = countryDetail?.name
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

struct CoutryDetail {
    let name: String
}
