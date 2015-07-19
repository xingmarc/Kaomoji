//
//  ViewController.swift
//  Kaomoji
//
//  Created by Xing Yichi on 7/17/15.
//  Copyright (c) 2015 xing. All rights reserved.
//

import UIKit

class KaomojiViewController: UIViewController {

    
    @IBOutlet weak var kaomoji: UILabel!{
        didSet{
            kaomoji.text = "( ^ _ ^ )"
            kaomojiTextWithoutHolds = "( ^ _ ^ )"// set Initial Values
        }
    }
    
    @IBOutlet var kaomojiView: UIView!{
        didSet{
            kaomojiView.addSubview(copyButtonOutlet)
            //subKaomojiAdjustment?.removeAllSegments()
        }
    }
    
    
    // MARK: Segmented Control
    @IBOutlet weak var kaomojiAdjustment: UISegmentedControl!
    
    @IBOutlet weak var subKaomojiAdjustment: UISegmentedControl!{
        didSet{
            subKaomojiAdjustment.removeAllSegments()
        }
    }
    var subKaomojiAdjustmentAppear : Bool = false
    
    @IBAction func selectKaomojiAdjustment(sender: UISegmentedControl) {
        switch kaomojiAdjustment.selectedSegmentIndex {
        case KaomojiElements.Hands:
            if !subKaomojiAdjustmentAppear{
                createSubKaomojiSegmentations(KaomojiElements.Hands, animatedOrNot: false)
                subKaomojiAdjustmentAppear = true
            }
            else{
                removeSubKaomojiSegmentations()
                createSubKaomojiSegmentations(KaomojiElements.Hands,animatedOrNot:  false)
            }
            
        case KaomojiElements.Eye:
            if !subKaomojiAdjustmentAppear{
                createSubKaomojiSegmentations(KaomojiElements.Eye, animatedOrNot: false)
                subKaomojiAdjustmentAppear = true
            }
            else{
                removeSubKaomojiSegmentations()
                createSubKaomojiSegmentations(KaomojiElements.Eye, animatedOrNot: false)
            }
        default:
            removeSubKaomojiSegmentations()
            subKaomojiAdjustmentAppear = false
            break
        }
    }
    
    func createSubKaomojiSegmentations(forKaomoji: Int, animatedOrNot: Bool){
        if (forKaomoji == KaomojiElements.Hands){
            subKaomojiAdjustment.insertSegmentWithTitle("Left", atIndex: 0, animated: animatedOrNot)
            subKaomojiAdjustment.insertSegmentWithTitle("Right", atIndex: 1, animated: animatedOrNot)
            subKaomojiAdjustment.insertSegmentWithTitle("Both", atIndex: 2, animated: animatedOrNot)
            subKaomojiAdjustment.insertSegmentWithTitle("NoHands", atIndex: 3, animated: animatedOrNot)
        }
        
        if (forKaomoji == KaomojiElements.Eye){
            subKaomojiAdjustment.insertSegmentWithTitle("Eyebrow", atIndex: 0, animated: animatedOrNot)
            subKaomojiAdjustment.insertSegmentWithTitle("NoEyebrow", atIndex: 1, animated: animatedOrNot)
        }
    }
    func removeSubKaomojiSegmentations(){
        subKaomojiAdjustment.removeAllSegments()
    }
    
    
    
    
    
    // MARK: Copy button
    @IBOutlet weak var copyButtonOutlet: UIButton!
    @IBAction func copyKaomoji(sender: UIButton) {
        if let kaomojiToBeCopied = kaomoji.text{
            UIPasteboard.generalPasteboard().string = kaomojiToBeCopied
        }
    }


    
    // MARK: Kaomoji Model:
    var kaomojiTextWithoutHolds:String = ""
    var numberOfTap: Int = 0
    var numberOfSwipe: Int = 0
    
    var currentHands: Int = NumOfHands.noHands
    
    let rightFaceCharacter = [")", "|", "(", "]", "}", ">"]
    let leftFaceCharacter =  ["(", "|", ")", "[", "{", "<"]
    let eyeCharacter =   [ "^", "*", "@", "●", "⊙", "༎ຶ","┬","☆"]
    let mouthCharacter = [ "_", "◡", "▽", "3", ".", "人", "︿", "ω", "﹏", "ロ","～"]
    let handsCharacter = ["_", "ﾉ","ˊ","~"]
    let holdsCharacter   = ["\u{035b}","\u{0309}","\u{1dc4}","\u{1dc5}"]
    
    private struct KaomojiElements {
        static let Face   :Int  = 0
        static let Mouth :Int  = 1
        static let Eye  :Int  = 2
        static let Hands :Int  = 3
        static let Holds  :Int  = 4

    }
    private struct SubKaomojiElements {
        static let Left  :Int = 0
        static let Right :Int = 1
        static let Both  :Int = 2
        static let NoHands:Int = 3
    }
    
    struct Indices {
        static var faceIndex  :Int = 0
        static var eyeIndex   :Int = 0
        static var mouthIndex :Int = 0
        static var handsIndex :Int = 0
        static var rightHandIndex:Int = 0
        static var leftHandIndex :Int = 0
        
        static var holdsIndex   :Int = 0
    }
    
    struct NumOfHands {
        static var leftHand: Int = 0
        static var rightHand:Int = 1
        static var bothHand: Int = 3
        static var noHands: Int = 4
    }
    

    // MARK: Kaomoji Making
    func makeKaomojiChange(face :Int, eye :Int, mouth : Int, hands: Int, handsNumber: Int){
        var newKaomoji :String = ""
        switch handsNumber{
        case 0://left hand
            newKaomoji = handsCharacter[hands] + leftFaceCharacter[face] + " " + eyeCharacter[eye] + " " + mouthCharacter[mouth] + " " + eyeCharacter[eye] + " " + rightFaceCharacter[face]
        case 1://right hand
            newKaomoji = leftFaceCharacter[face] + " " + eyeCharacter[eye] + " " + mouthCharacter[mouth] + " " + eyeCharacter[eye] + " " + rightFaceCharacter[face] + handsCharacter[hands]
        case 3://both hands
            newKaomoji = handsCharacter[hands] + leftFaceCharacter[face] + " " + eyeCharacter[eye] + " " + mouthCharacter[mouth] + " " + eyeCharacter[eye] + " " + rightFaceCharacter[face]+handsCharacter[hands]
        default://no hands
            newKaomoji = leftFaceCharacter[face] + " " + eyeCharacter[eye] + " " + mouthCharacter[mouth] + " " + eyeCharacter[eye] + " " + rightFaceCharacter[face]
        }
        
        kaomoji.text? =  newKaomoji
        kaomojiTextWithoutHolds = newKaomoji
    }
    
    // overload makeKaomojiChange
    
    func makeKaomojiChange(leftFace: String, rightFace: String ,eye :String, mouth :String, leftHand :String, rightHand :String, handsNumber: Int)
    {
        var newKaomoji :String = ""
        switch handsNumber {
        case 0://left hand
            newKaomoji = leftHand + leftFace + " " + eye + " " + mouth + " " + eye + " " + rightFace
        case 1://right hand
            newKaomoji = leftFace + " " + eye + " " + mouth + " " + eye + " " + rightFace + rightHand
        case 3://both hands
            newKaomoji = leftHand + leftFace + " " + eye + " " + mouth + " " + eye + " " + rightFace + rightHand
        default://no hands
            newKaomoji = leftFace + " " + eye + " " + mouth + " " + eye + " " + rightFace
        }
        kaomoji.text? = newKaomoji
        kaomojiTextWithoutHolds = newKaomoji
    }
    
    func addCombiningCharacter(originalString:String, combiningCharUnicode: String, combiningTimes: Int) -> String{
        if combiningTimes <= 0{
            return originalString
        }
        else{
            var i :Int = 0
            var newString: String = originalString
            while( i < combiningTimes){
                newString += combiningCharUnicode
                i += 1
            }
            println(newString)
            return newString
        }
    }
    
    // MARK: gestures
    @IBAction func tap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended{
            numberOfTap += 1
            switch kaomojiAdjustment.selectedSegmentIndex{
                
            case KaomojiElements.Eye:
                /*
                let id: Int = numberOfTap % eyeCharacter.count
                Indices.eyeIndex = id
                makeKaomojiChange(Indices.faceIndex, eye:id, mouth: Indices.mouthIndex, hands: Indices.handsIndex)
*/
                addEyesForKaomoji(numberOfTap)
                
            case KaomojiElements.Mouth:
                let id: Int = numberOfTap % mouthCharacter.count
                Indices.mouthIndex = id
                makeKaomojiChange(Indices.faceIndex, eye: Indices.eyeIndex, mouth: id, hands: Indices.handsIndex, handsNumber: currentHands)
                
            case KaomojiElements.Face:
                let id: Int = numberOfTap % leftFaceCharacter.count
                Indices.faceIndex = id
                makeKaomojiChange(id, eye: Indices.eyeIndex, mouth: Indices.mouthIndex, hands: Indices.handsIndex, handsNumber: currentHands)
                
            case KaomojiElements.Hands:
                addHandsForKaomoji(numberOfTap)

            case KaomojiElements.Holds:
                let id: Int = numberOfTap % holdsCharacter.count
                Indices.holdsIndex = id
                println("holds Index: \(id)")
            
            default: break
                ////println("\u{1F496}\u{032A}\u{032A}\u{032A}")
            }
        }
    }
    
    func addHandsForKaomoji(tapNum :Int){
        if subKaomojiAdjustment != nil{
            
            let id: Int = tapNum % handsCharacter.count
            switch subKaomojiAdjustment.selectedSegmentIndex{
            case SubKaomojiElements.Left:
                Indices.leftHandIndex = id
                Indices.handsIndex = id
                
                currentHands = NumOfHands.leftHand
                makeKaomojiChange(Indices.faceIndex, eye: Indices.eyeIndex, mouth: Indices.mouthIndex, hands:id, handsNumber: currentHands)
            case SubKaomojiElements.Right:
                Indices.rightHandIndex = id
                Indices.handsIndex = id
                
                currentHands = NumOfHands.rightHand
                makeKaomojiChange(Indices.faceIndex, eye: Indices.eyeIndex, mouth: Indices.mouthIndex, hands: id,handsNumber: currentHands)
            case SubKaomojiElements.Both:
                Indices.handsIndex = id;
                Indices.leftHandIndex = id
                Indices.rightHandIndex = id
                
                currentHands = NumOfHands.bothHand
                makeKaomojiChange(Indices.faceIndex, eye: Indices.eyeIndex, mouth: Indices.mouthIndex, hands: Indices.handsIndex,handsNumber: currentHands)
            case SubKaomojiElements.NoHands:
                currentHands = NumOfHands.noHands
                makeKaomojiChange(Indices.faceIndex, eye: Indices.eyeIndex, mouth: Indices.mouthIndex, hands: Indices.handsIndex,handsNumber: currentHands)
            default: break
            }
        }
    }
    
    func addEyesForKaomoji(tapNum: Int){
        if subKaomojiAdjustment != nil{
            
            let idForEye: Int = tapNum % eyeCharacter.count
            let idForEyebrow: Int  = tapNum % holdsCharacter.count
            
            switch subKaomojiAdjustment.selectedSegmentIndex
            {
            case 0://Eyebrow
                Indices.holdsIndex = idForEyebrow
                makeKaomojiChange(leftFaceCharacter[Indices.faceIndex], rightFace: rightFaceCharacter[Indices.faceIndex], eye: eyeCharacter[Indices.eyeIndex] + holdsCharacter[idForEyebrow], mouth: mouthCharacter[Indices.mouthIndex], leftHand: handsCharacter[Indices.handsIndex], rightHand: handsCharacter[Indices.handsIndex],handsNumber: currentHands)
            case 1:
                Indices.eyeIndex = idForEye
                makeKaomojiChange(Indices.faceIndex, eye:idForEye, mouth: Indices.mouthIndex, hands: Indices.handsIndex, handsNumber: currentHands)
            default:break
            }
        }
    }
    
    
    
    @IBAction func panChangeHoldings(sender: UIPanGestureRecognizer) {

        if kaomojiAdjustment.selectedSegmentIndex == KaomojiElements.Holds{

            var numberOfPiles :Int = 0
            
            switch sender.state{
            case .Ended: fallthrough
            case .Changed:
                let translation = sender.translationInView(kaomojiView)
                let holdsAddNumber = -Int(translation.y / 30)//This is a constant, one can change this
                
                println("\(holdsAddNumber)")
                
                numberOfPiles += holdsAddNumber
        
                numberOfPiles = min(20, max(numberOfPiles, 0))
                
                var newKaomoji = addCombiningCharacter(kaomojiTextWithoutHolds, combiningCharUnicode: holdsCharacter[Indices.holdsIndex], combiningTimes: numberOfPiles)
                kaomoji.text? = newKaomoji
                println(kaomoji.text)
            
                //println("\(holdsAddNumber)")
                
                
            default: break
            }// End switch
            
            numberOfPiles = 0
        }
    }

}

