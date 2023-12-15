//
//  ImageViewController.swift
//  Assignment3
//
//  Created by Tsz Kit Cheung on 2023-11-12.
//

import UIKit

class ImageViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, NewPictureDelegate{

    var pictureList = (UIApplication.shared.delegate as! AppDelegate).allPicture
    
    @IBOutlet weak var IV1: UIImageView!
    @IBOutlet weak var PV1: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Need to declare self to show them
        PV1.dataSource = self
        PV1.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pictureList.count
    }
    
    
    // func show labels and using UIlabel
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pictureList[row].title
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        // choose the url
        let urlString = pictureList[row].url
        
        let queue = DispatchQueue.init(label: "myq")
        
        // async to donwload photo
        queue.async{
            do{

                let url = URL(string: urlString)
                

                // download to local
                // welf self can prevent retain cycle
                URLSession.shared.dataTask(with: url!)  { [weak self] data, response, error in
                    
                    if let error = error {
                        print("Error downloading image: \(error)")
                        return
                    }
                    
                    
                    // if there is a good response 200 - 400
                    guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                        print("Error in HTTP response")
                        return
                    }

                    // get the image
                    if let data = try? Data (contentsOf: url!){
                    DispatchQueue.main.async {
                                if let image = UIImage(data: data) {
                                    self!.IV1.image = image
                            }
                        }
                    }
                }.resume()
        
               
                
            }
            catch{

            }
        }

        PV1.reloadAllComponents()
    }

    
    func pictureAddCorrectly(newpic: picture) {
        pictureList.append(newpic)
        PV1.reloadAllComponents()
        
        
        print(pictureList)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAdd"{
            var des = segue.destination as! AddViewController
            
            des.delegate = self
        }
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
