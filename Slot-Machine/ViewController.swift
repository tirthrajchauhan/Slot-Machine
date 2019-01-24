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
    @IBAction func quitButton(_ sender: UIButton) {
        exit(0)
    }
    
    
    @IBOutlet weak var availableCreditLabel: UILabel!
    @IBOutlet weak var currentBetLabel: UILabel!
    
    var initialCredit: Int = 500
    var currentBet: Int = 0
    
    @IBOutlet weak var stepper: UIStepper!
    
    var winningAmount:Int = 0
    @IBOutlet weak var winningAmountLabel: UILabel!
    
    var remainingCredit: Int = 0
    
    //stepper to place bet
    @IBAction func placeBetStepper(_ sender: UIStepper)
    {
        currentBet = Int((sender.value))
        //print(cBet)
        //credit = (credit - currentBet)
        self.currentBetLabel.text = String(currentBet)
        
        let c = self.updateCredit(currentBet: currentBet)
        
        self.availableCreditLabel.text = String(c)
        //self.availableCreditLabel.text = String(credit)
        
        self.winningAmountLabel.text = ""
        lblwin.isHidden = true
    }
    
    //updating available credit after every bet
    func updateCredit(currentBet: Int) -> Int
    {
        remainingCredit = (initialCredit - currentBet)
        return remainingCredit
    }
    
    //resetting the credit and bet data to start a new game
    @IBAction func resetButton(_ sender: UIButton)
    {
        initialCredit = 500
        currentBet = 0
        stepper.value = 0
        self.availableCreditLabel.text = String(initialCredit)
        self.currentBetLabel.text = String(currentBet)
    }
    
    
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
        self.availableCreditLabel.text = String(initialCredit)
        self.currentBetLabel.text = String(currentBet)
        
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
    
    
        //updating remaining credit after every spin
        updateCurrentBet()
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
        if comp1 == comp2 && comp2 == comp3
        {
            lblwin.isHidden = false
            self.lblwin.text = "You Win!"
            
            //calculating winning amount after every win
            winningAmount = (currentBet * 2)
            self.winningAmountLabel.text = String(winningAmount)
            print("winningAmt ",winningAmount)
            
            self.updateRemainingCredit(winningAmount: winningAmount)
        }
        else
        {
            lblwin.isHidden = false
            self.lblwin.text = "Try again!"
            self.currentBetLabel.text = String(currentBet)
            
            
            winningAmount = 0
            self.winningAmountLabel.text = String(winningAmount)
            
            // update remaining credit after every lose
            self.updateRemainingCredit(winningAmount: winningAmount)
        }
    }
    
    //function to resetting current bet after every bet
    func updateCurrentBet()
    {
        currentBet = 0
        stepper.value = 0
        self.currentBetLabel.text = String(currentBet)
    }
    
    //function to update available credit after every spin
    func updateRemainingCredit(winningAmount:Int)
    {
            remainingCredit += winningAmount
            print(remainingCredit)
            initialCredit = remainingCredit
            self.availableCreditLabel.text = String(remainingCredit)
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

