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
  
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var previousPage: UIBarButtonItem!
    
    @IBOutlet weak var nextPage: UIBarButtonItem!
    @IBOutlet weak var pageNumber: UIBarButtonItem!
    
    @IBAction func next(_ sender: Any) {
        page += 1
        if page > pages{
            page = pages
        }
        fetchImages()
        collectionView.reloadData()
    }
    @IBAction func previous(_ sender: Any) {
        page -= 1
        if page < 1{
            page = 1
        }

        fetchImages()
        collectionView.reloadData()
        
    }
    @IBAction func refresh(_ sender: Any) {
        fetchImages()
        collectionView.reloadData()
    }
    
    
    @IBOutlet weak var total: UIBarButtonItem!
    
    var photos4: [[String: Any]]?
    
    var photoDisplay: [[String: Any]]?
    
    var pages = 1
    var page = 1
    
    @IBAction func nudeImageSwitch(_ sender: UISwitch) {
   
//        photoDisplay = photos4?.filter({
//            sender.isOn || !sender.isOn &&  (($0["nsfw"] as? Int) ?? 0) == 0
//        })
        if let f = photos4?.filter({ sender.isOn || (!sender.isOn && !($0["nsfw"] as? Bool ?? false)) }){
            photoDisplay? = f
        }

        collectionView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
    }

    override func viewDidLayoutSubviews() {
        var rect = collectionView.frame
        rect.size.height = view.frame.height - toolbar.frame.height
        collectionView.frame = rect
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    func fetchImages() {

        let imageStr = "https://api.500px.com/v1/photos?feature=popular&sort=created_at&page=%d&image_size=4&include_store=store_download&include_states=voted&consumer_key=QIEirwEcU0sgPfIId2Dy6W0mOJjyaOKvBBCEEGk6"
        
        if let url = URL(string: String(format: imageStr, page)){
            if let json = try? Data(contentsOf: url){
                if let d = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any]{
                    if let p = d? ["total_pages"] as? Int{
                        pages = p
                        //page = p > 0 ? 1 : 0
//                        if page == 1{
//                            previousPage.isEnabled = false
//                            nextPage.isEnabled = true
//                        }
//                        else if page == pages{
//                            nextPage.isEnabled = false
//                            previousPage.isEnabled = true
//                        }
//                        else{
//                            previousPage.isEnabled = true
//                            nextPage.isEnabled = true
//                        }
                        
                        previousPage.isEnabled = page != 1
                        nextPage.isEnabled = page < pages
                        self.pageNumber.title = "\(page)/\(pages)"
                    }
                    photos4 = d?["photos"] as? [[String: Any]]
                    photoDisplay = photos4
                    navTitle.title = (d?["feature"] as? String)?.uppercased()
                   //print(d)
                    
                }
                
            }
            
        }

        
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = photoDisplay?.count ?? 0
      //  self.total.title = "Total: \(total)"
        
        return total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
       // let str = photos?[indexPath.row]
        
        if let photo = photoDisplay?[indexPath.row]{
            //let a = ((photo["user"] as? [String: Any])?["avatars"] as? [String: Any])?["large"]
           // if let str = (((photo["user"] as? [String: Any])?["avatars"] as? [String: Any])?["large"] as? [String:Any])?["https"] as? String {
            if let str = photo["image_url"] as? String {
                if let url = URL(string: str){
                    if let data = try? Data(contentsOf: url){
                        let image = UIImage(data: data)
                        cell.imageView?.image = image
                        cell.titleLabel?.text = ""
                        cell.imageView.contentMode = UIViewContentMode.scaleAspectFit
                       // cell.imageView.sizeToFit()
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
            
            vc.photo = self.photoDisplay![indexPath.row]
           // vc.title = self.appleProduct[indexPath.row]
            
            
        }
    }
    
    
    
    


}

