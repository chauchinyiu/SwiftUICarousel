//
//  ViewController.swift
//  SwiftUICarousel
//
//  Created by chauchinyiu on 01/18/2021.
//  Copyright (c) 2021 chauchinyiu. All rights reserved.
//

import UIKit
import SwiftUI
import SwiftUICarousel
 
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: SwiftUIView(uiState: UIStateModel()))
        addChildViewController(childView)
        childView.view.frame = self.view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

