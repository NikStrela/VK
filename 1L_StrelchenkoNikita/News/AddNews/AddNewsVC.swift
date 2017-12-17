//
//  AddNewsVC.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 16.11.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit

class AddNewsVC: UIViewController {

    @IBOutlet weak var textPost: UITextField!
    var coordinateNews: (Double,Double) = (0,0)
    let vkService = VKService()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddPostService(_ sender: Any) {
        vkService.addPostVK(message: textPost.text ?? "", coordinate: coordinateNews)
    }
    
    
    @IBAction func CancelMapNews(unwindSegue: UIStoryboardSegue){
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
