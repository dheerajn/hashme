//
//  RootViewController.swift
//  HashMe
//
//  Created by Dheeru on 10/2/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    weak var flowDelegate: HashTagFlowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.LightGreyBackgroundColor()
        self.flowDelegate = HashTagFlowController(navigationController: self.navigationController!)
    }
}
