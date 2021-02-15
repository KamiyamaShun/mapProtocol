//
//  NextViewController.swift
//  mapProtocol
//
//  Created by 神山駿 on 2021/02/15.
//

import UIKit

protocol searchLocationDelegate {
    func searchLocation(latValue: String, logValue: String)
}

class NextViewController: UIViewController {

    @IBOutlet weak var latTextFeild: UITextField!
    @IBOutlet weak var logTextFeild: UITextField!
    
    var delegate:searchLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okButoon(_ sender: Any) {
        let latValue = latTextFeild.text!
        let logValue = logTextFeild.text!
        
        
        if latTextFeild.text != nil && logTextFeild.text != nil{
            delegate?.searchLocation(latValue: latValue, logValue: logValue)
            dismiss(animated: true, completion: nil)
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
