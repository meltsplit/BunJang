//
//  Protocol.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import Foundation

protocol optionDataDelegate{
    
    func sendData(_ data : OptionModel)
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
