//
//  ImageView.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 18/2/21.
//

import Cocoa

class ImageView: NSImageView {

    var images: [NSImage] = []

    func autoAnimate(interval: TimeInterval) {
        image = nil
        stopAnimation()
        let sequenceLayer = SequenceLayer(sequence: images, interval: interval, frame: bounds)
        wantsLayer = true
        layer?.addSublayer(sequenceLayer)
    }

    func stopAnimation() {
        (layer?.sublayers ?? []).forEach {
            if $0 is SequenceLayer {
                $0.removeAnimation(forKey: imageAnimationKey)
                $0.removeFromSuperlayer()
            }
        }
    }
    
}

private let imageAnimationKey = "SequenceLayerAnimationKey"

class SequenceLayer: CALayer {


     init(sequence: [NSImage], interval: TimeInterval = 1, frame: CGRect? = nil) {
        super.init()
        if let f = frame { self.frame = f }
        autoresizingMask = [.layerWidthSizable, .layerHeightSizable]

        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "contents")
        keyFrameAnimation.values = sequence
        keyFrameAnimation.calculationMode = .discrete
        keyFrameAnimation.fillMode = .forwards
        keyFrameAnimation.duration = TimeInterval(sequence.count) * interval
        keyFrameAnimation.repeatCount = Float.infinity
        keyFrameAnimation.autoreverses = false
        keyFrameAnimation.isRemovedOnCompletion = false
        keyFrameAnimation.beginTime = 0.0

        add(keyFrameAnimation, forKey: imageAnimationKey)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
