//
//  NewViewController.swift
//  Popular 500px
//
//  Created by Emily Liu on 2017-02-13.
//  Copyright © 2017 Emily Liu. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

   // var image = UIImage()
    var photo: [String: Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.imageView.image = self.image
        if let str = photo["image_url"] as? String {
            if let url = URL(string: str){
                if let data = try? Data(contentsOf: url){
                    let image = UIImage(data: data)
                    imageView?.image = image
                    //cell.titleLabel?.text = ""
                    // print(data)
                    
                }
            }
            
        }

        //imageView.contentMode = UIViewContentMode.scaleAspectFit
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
