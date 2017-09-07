//
//  ViewController.swift
//  Project27
//
//  Created by Mike Killewald on 9/6/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentDrawType = 0

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 6 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
            
        case 1:
            drawCircle()
            
        case 2:
            drawCheckerboard()
        
        case 3:
            drawRotatedSquare()
            
        case 4:
            drawLines()
            
        case 5:
            drawImagesAndText()
            
        case 6:
            drawRainbow()
            
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            // awesome drawing code
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            // awesome drawing code
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img

    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            // awesome drawing code
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = img

    }
    
    func drawRotatedSquare() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            // awesome drawing code
            ctx.cgContext.translateBy(x: 256, y: 256) // sets rotation point in center of our renderer
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256)) // adds CGRects centered on center of our renderer
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img

    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            // awesome drawing code
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: CGFloat.pi / 2)  // rotate by 90 degrees on each iteration
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y:50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img

    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            // awesome drawing code
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 36)!, NSParagraphStyleAttributeName: paragraphStyle]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            string.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        imageView.image = img

    }
    
    func drawRainbow() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let colors = [UIColor.red, UIColor.brown, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.gray, UIColor.darkGray, UIColor.black]
    
        let img = renderer.image { ctx in
            // awesome drawing code
            let lineWidth: CGFloat = 20
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setLineWidth(lineWidth)
            ctx.cgContext.translateBy(x: 0, y: 256)
            
            for i in 0 ..< colors.count {
                let inset: CGFloat = lineWidth / 2 + CGFloat(i) * lineWidth
                ctx.cgContext.setStrokeColor(colors[i].cgColor)
                ctx.cgContext.addEllipse(in: rectangle.insetBy(dx: inset, dy: inset))
                ctx.cgContext.drawPath(using: .stroke)
            }
        }
        
        imageView.image = img
    }
}
