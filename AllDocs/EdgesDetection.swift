//
//  ImageConverter.swift
//  CameraDocumentScanner
//
//  Created by Olivier Robin on 15/11/2016.
//  Copyright © 2016 olivier. All rights reserved.
//

import Foundation

import UIKit
import AVKit
import AVFoundation



public class EdgesDetection {
    
    var edgesDetectionIPDF = EdgesDetector()
    public var borderDetected = false
    public var pixelBuffer: CVPixelBuffer?
    
    public init() {
        
    }
    
    // Search a document edges in a picture ( CMSampleBuffer comes from camera preview for ex. )
    //
    func startDetection(sampleBuffer: CMSampleBuffer!) -> Quadrilateral? {
        //        print ("image width / height : " + String(describing: self.image?.size.width) + " / " + String(describing: self.image?.size.height))
        
        pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)! as CVPixelBuffer
        let quadrilateral:Quadrilateral?  = self.startEdgesDetection(pixelBuffer: pixelBuffer)
        
        return quadrilateral
    }
    
    // detect the document edges in a pixelbuffer ( comes from a document loaded for ex., pixel buffer created from uiimage )
    //
    func startEdgesDetection(pixelBuffer: CVPixelBuffer!) -> Quadrilateral? {
        
        let edges = edgesDetectionIPDF.startDetection(pixelBuffer: pixelBuffer)
        
        borderDetected = edgesDetectionIPDF.borderDetected
        
        let r = edges!
        
        var p1: CGPoint!
        var p2: CGPoint!
        var p3: CGPoint!
        var p4: CGPoint!
        
        if borderDetected {
            
            p1 = CGPoint(x: (r.topRight?.x)!, y: (r.topRight?.y)!)
            p2 = CGPoint(x: (r.bottomRight?.x)!, y: (r.bottomRight?.y)!)
            p3 = CGPoint(x: (r.topLeft?.x)!, y: (r.topLeft?.y)!)
            p4 = CGPoint(x: (r.bottomLeft?.x)!, y: (r.bottomLeft?.y)!)
        
       } else {
            
           p1 = CGPoint(x: (r.topLeft?.x)!, y: (r.topLeft?.y)!)
           p2 = CGPoint(x: (r.topRight?.x)!, y: (r.topRight?.y)!)
           p3 = CGPoint(x: (r.bottomLeft?.x)!, y: (r.bottomLeft?.y)!)
           p4 = CGPoint(x: (r.bottomRight?.x)!, y: (r.bottomRight?.y)!)
        }
        

        
        let quadrilateral = Quadrilateral(p1: p1, p2: p2, p3: p3, p4: p4)
        return quadrilateral
    }
    
    
    
    
    
}

