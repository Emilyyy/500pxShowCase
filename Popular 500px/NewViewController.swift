//
//  NewViewController.swift
//  Popular 500px
//
//  Created by Emily Liu on 2017-02-13.
//  Copyright © 2017 Emily Liu. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var imageRating: UILabel!
    @IBOutlet weak var imageAuthor: UILabel!
    
    @IBOutlet weak var descritionPanel: UIView!

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
                    imageView?.contentMode = UIViewContentMode.scaleAspectFit
                    //cell.titleLabel?.text = ""
                    // print(data)
                    
                }
            }
            
        }

        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageName.text = photo["name"] as? String
        imageAuthor.text = (photo["user"] as? [String: Any])? ["fullname"] as? String
        if let rate = photo["rating"]{
             imageRating.text = String(describing: rate)
        }
       
    }
    
    override func viewDidLayoutSubviews() {
        print(self.view.frame)
        var rect = imageView.frame
        //rect.origin.y = navigationItem.titleView?.frame
        rect.size.height = view.frame.height - descritionPanel.frame.height - imageView.frame.origin.y
        imageView.frame = rect
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
