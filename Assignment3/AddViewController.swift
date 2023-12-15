//
//  AddViewController.swift
//  Assignment3
//
//  Created by Tsz Kit Cheung on 2023-11-12.
//

import UIKit

protocol NewPictureDelegate {
    
    func pictureAddCorrectly(newpic: picture)
}

class AddViewController: UIViewController
    {

    var delegate : NewPictureDelegate?
    
    @IBOutlet weak var TF1: UITextField!
    
    @IBOutlet weak var TF2: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addInput(_ sender: Any) {
        // Add newStudent by textfield
        if let goodTitle = TF1.text{
            if let goodURL = TF2.text{
                if !goodTitle.isEmpty && !goodURL.isEmpty{
                    let newPicture = picture(title: goodTitle, url: goodURL)
                    
                    
                    delegate!.pictureAddCorrectly(newpic: newPicture)
                    

                    dismiss(animated: true)
                    
                    print("goodTitle: \(goodTitle)")

                }
            }
        }
    }
    
    @IBAction func cancelInput(_ sender: Any) {
        dismiss(animated: true)
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
