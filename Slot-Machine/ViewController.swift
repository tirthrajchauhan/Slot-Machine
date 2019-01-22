//
//  ViewController.swift
//  Slot-Machine
//
//  Created by Tirthrajsinh Chauhan on 2019-01-22.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource{

    @IBOutlet weak var slotMachine: UIPickerView!
    @IBOutlet weak var lblwin: UILabel!
   
    struct slotComp{
        var image: UIImage!
        var color: String
        
    }
    var images = [slotComp]()
    var counter = 0
    var comp1 = ""
    var comp2 = ""
    var comp3 = ""
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblwin.isHidden = true
        
    let img1  = slotComp(image: UIImage(named: "Kiwi"), color: "green")
        let img2 = slotComp(image: UIImage(named: "Apple"), color: "red")
    let img3 = slotComp(image: UIImage(named: "Grape"), color: "blue")
        
 images = [img1, img2, img3,img2, img2, img3,img1, img2, img3,img1,
           img2, img1,img1, img2, img3,img3, img2, img3,img1, img1, img3,
           img3, img2,img3, img1, img3,img3, img1, img2,img1, img1, img2,
           img3, img2,img1, img3, img3,img2, img3, img1,img2, img3, img1,
           img2, img1,img1, img2, img3,img1, img3, img3,img1, img2, img3,
           img1,img1, img3, img1, img1, img3]
    
        slotMachine.dataSource = self
        slotMachine.delegate = self
        
        srandom(UInt32(time(nil)))
    }

    @IBAction func spin(_ sender: Any) {
       
        lblwin.isHidden = true
        comp1 = ""
        comp2 = ""
        comp3 = ""
        counter = 0
       
        randomSpin()
        randomSpin()
        randomSpin()
    
    }
    
    func randomSpin(){
        var randRow: Int = 0
         randRow = Int(arc4random() % UInt32(images.count))
        slotMachine.selectRow(randRow, inComponent: counter, animated: true)
        self.pickerView(slotMachine, didSelectRow: randRow, inComponent: counter)
        counter += 1
        if counter == 3{
            counter = 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component{
        case 0:
            comp1 = images[row].color
            break
            case 1:
                comp2 = images[row].color
            break
        case 2:
            comp3 = images[row].color
            break
        default:
            break
        }
        if comp1 == comp2 && comp2 == comp3{
            lblwin.isHidden = false
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return UIImageView(image: images[row].image)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return images[0].image.size.height
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return images[0].image.size.width
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
}

