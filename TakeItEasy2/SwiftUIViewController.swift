//
//  SwiftUIViewController.swift
//  TakeItEasy2
//
//  Created by Corey Augburn on 6/13/22.
//

import UIKit
import SwiftUI

class SwiftUIViewController: UIViewController {

    @IBOutlet weak var theContainer : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let childView = UIHostingController(rootView: SwiftUIView())
        
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
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
