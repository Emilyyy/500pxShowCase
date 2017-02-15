//
//  ViewController.swift
//  Popular 500px
//
//  Created by Emily Liu on 2017-02-13.
//  Copyright © 2017 Emily Liu. All rights reserved.
//

import UIKit
let CONSUMER_KEY = "&consumer_key=QIEirwEcU0sgPfIId2Dy6W0mOJjyaOKvBBCEEGk6"


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var navTitle: UINavigationItem!
  
    
    
    var photos3: [[String: Any]]?
    var photos4: [[String: Any]]?
    
    var photoList: [[String: Any]]?
    
    @IBAction func nudeImageSwitch(_ sender: UISwitch) {
        _ = photoList?.map {print($0["nsfw"] ?? 0)}
        photoList = photos3?.filter({
          sender.isOn || !sender.isOn &&  (($0["nsfw"] as? Int) ?? 0) == 0
           
            
        })
        collectionView.reloadData()
        print("count:  \(photoList?.count)")
        _ = photoList?.map {print($0["nsfw"] ?? 0)}
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    func fetchImages() {
        var imageStr = "https://api.500px.com/v1/photos?feature=popular&sort=created_at&image_size=3&include_store=store_download&include_states=voted&consumer_key=QIEirwEcU0sgPfIId2Dy6W0mOJjyaOKvBBCEEGk6"
        
        if let url = URL(string: imageStr){
            if let json = try? Data(contentsOf: url){
                if let d = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any]{
                    photos3 = d?["photos"] as? [[String: Any]]
                    photoList = photos3
                    navTitle.title = d?["feature"] as? String
                   // print(d)
                    
                }

            }
            
        }
        imageStr = "https://api.500px.com/v1/photos?feature=popular&sort=created_at&image_size=4&include_store=store_download&include_states=voted&consumer_key=QIEirwEcU0sgPfIId2Dy6W0mOJjyaOKvBBCEEGk6"
        
        if let url = URL(string: imageStr){
            if let json = try? Data(contentsOf: url){
                if let d = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any]{
                    photos4 = d?["photos"] as? [[String: Any]]
                   // print(d)
                    
                }
                
            }
            
        }

        
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
       // let str = photos?[indexPath.row]
        
        if let photo = photoList?[indexPath.row]{
            //let a = ((photo["user"] as? [String: Any])?["avatars"] as? [String: Any])?["large"]
           // if let str = (((photo["user"] as? [String: Any])?["avatars"] as? [String: Any])?["large"] as? [String:Any])?["https"] as? String {
            if let str = photo["image_url"] as? String {
                if let url = URL(string: str){
                    if let data = try? Data(contentsOf: url){
                        let image = UIImage(data: data)
                        cell.imageView?.image = image
                        cell.titleLabel?.text = ""
                        cell.imageView.contentMode = UIViewContentMode.scaleAspectFit
                        cell.imageView.sizeToFit()
                       // print(data)
                        
                    }
                }

            }
//            if let name = photo["name"] as? String{
//                cell.titleLabel?.text = name
//            }
        }
        
        
       
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showImage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage"
        {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as IndexPath
            
            let vc = segue.destination as! NewViewController
            
            vc.photo = self.photos4![indexPath.row]
           // vc.title = self.appleProduct[indexPath.row]
            
            
        }
    }
    
    
    
    


}

