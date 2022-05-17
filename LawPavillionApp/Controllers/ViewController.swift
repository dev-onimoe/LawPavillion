//
//  ViewController.swift
//  LawPavillionApp
//
//  Created by Apple on 5/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var helloLabel : UILabel?
    @IBOutlet var splashPic : UIImageView?
    @IBOutlet var bodyLabel : UILabel?
    @IBOutlet var solutionBtn : UIButton?
    @IBOutlet var backView : UIView?
    @IBAction func goToHome (_sender : UIButton) {
        
        let vc = HomeviewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    func setupViews() {
        
        backView?.alpha = 0
        solutionBtn?.layer.cornerRadius = 12
        solutionBtn?.sizeToFit()
        
        UIView.animate(withDuration: 5, animations: {
            
            self.backView?.alpha = 1
        })
    }


}

