//
//  DrawView.swift
//  ABC
//
//  Created by Игорь Майсюк on 2.11.21.
//

import UIKit

final class DrawView: UIView {

    private var lines: [Line] = []
    var drawColor: UIColor = .red

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(20)
        context.setLineCap(.round)

        for line in lines {
            context.beginPath()
            context.setStrokeColor(line.color)
            context.move(to: line.startPoint)

            for point in line.points {
                context.addLine(to: point)
            }
            context.strokePath()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let line = Line(startPoint: touch.location(in: self), color: drawColor)
        lines.append(line)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        lines[lines.endIndex - 1].add(touch.location(in: self))
        setNeedsDisplay()
    }
}

private struct Line {
    let startPoint: CGPoint
    let color: CGColor
    private(set) var points: [CGPoint]

    init(startPoint: CGPoint, color: UIColor) {
        self.startPoint = startPoint
        self.color = color.cgColor
        self.points = [startPoint]
    }

    mutating func add(_ point: CGPoint) {
        points.append(point)
    }
}
