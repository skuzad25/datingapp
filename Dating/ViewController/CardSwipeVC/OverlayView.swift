//
//  OverlayView.swift
//  Dating
//
//  Created by Abhishek Chauhan on 05/10/23.
//

import Foundation
import UIKit
import Koloda
class OverlayView: UIView {
    
    // MARK: --- OUTLETS ---
    @IBOutlet weak var btnDislike: UIButton!
    
    @IBOutlet weak var imgSwipeLike: UIImageView!
    @IBOutlet weak var imgSwipeDislike: UIImageView!
    // MARK: --- VARIABLES ---
    var index = 0
    // MARK: --- VIEW LIFE CYCLE ---
    override func awakeFromNib() {
            super.awakeFromNib()

        
    }
    
    
    
    // MARK: --- ACTIONS ---
    
    var btnDislikeHandler:(()->())?
    @IBAction func btnDislike(_ sender: Any) {
        btnDislikeHandler?()
    }
    var btnLikeHandler:(()->())?
    @IBAction func btnLikeHandler(_ sender: Any) {
        btnLikeHandler?()
    }
    var btnUndoHandler:(()->())?
    @IBAction func btnUndo(_ sender: Any) {
        btnUndoHandler?()
    }
    
}
