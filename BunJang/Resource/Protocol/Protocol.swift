//
//  Protocol.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import Foundation
import UIKit

protocol optionDataDelegate{
    
    func sendData(_ data : OptionModel)
}

protocol FilterDelegate{
    
    func sendFilter(_ data : Filter)
}

protocol FirstCategoryDelegate{
    
    func sendFirstCategory(_ data : FirstCategoryResult)
    
}

protocol SecondCategoryDelegate{
    
    func sendSecondCategory(_ data : SecondCategoryResult)
    
}

protocol ArrayStringDelegate{
    func sendArrayString(_ data : [String])
}

protocol StringDelegate{
    func sendString(_ data : String)
}

protocol IntDelegate{
    func sendInt(_ data : Int)
    
}



protocol ViewControllerDelegate{
    func sendViewController(_ vc : UIViewController)
}



