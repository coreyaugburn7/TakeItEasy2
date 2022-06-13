//
//  PDFViewController.swift
//  TakeItEasy2
//
//  Created by Liban Abdinur on 6/10/22.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var pdfName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = PDFView(frame: view.bounds)
        
        pdfView.autoScales = true
        
        let filePath = Bundle.main.url(forResource: pdfName, withExtension: "pdf")
        
        pdfView.document = PDFDocument(url: filePath!)
        
        view.addSubview(pdfView)
       
    }
    
    
   

}
