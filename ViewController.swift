//
//  ViewController.swift
//  GridMagic
//
//  Created by MAC on 9/18/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let numberOfCellsRow = 15
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / CGFloat(numberOfCellsRow)
        
        
        let numberOfColumn = 25
        for j in 0...numberOfColumn {
            for i in 0...numberOfCellsRow {
                let cell = UIView()
                cell.backgroundColor = randomColor()
                cell.layer.borderWidth = 0.5
                cell.layer.borderColor = UIColor.black.cgColor
                cell.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                let tag = 100 * i + j + 1
                cell.tag = tag
                view.addSubview(cell)
            }
        }
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
        
    }
    var selectedCell:UIView?
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        let width = view.frame.width / CGFloat(numberOfCellsRow)
        let i = Int(location.x/width)
        let j = Int(location.y/width)
        let tag = 100 * i + j + 1
        guard let cell = view.viewWithTag(tag) else {return}
        
        if selectedCell != cell {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
                
                
            }, completion: nil)
        }
        selectedCell = cell
        view.bringSubview(toFront: cell)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DMakeScale(3, 3, 3)
            
            
        }, completion: nil)
        if gesture.state == .ended {
            cell.layer.transform = CATransform3DIdentity
        }
        
    }
    func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue  = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
   
}
