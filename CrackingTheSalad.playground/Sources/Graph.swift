import UIKit

public class Graph {
    public var dataSet: [(key: String, value: Int)]
    
    public var barMargin: CGFloat = 3.0
    public var descriptionHeight: CGFloat = 20.0
    public var barColor = UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0)
    public var textColor = UIColor.black
    
    public init(dataSet: [(key: String, value: Int)]? = nil) {
        if let dataSet = dataSet {
            self.dataSet = dataSet
        } else {
            self.dataSet = [(key: String, value: Int)]()
        }
    }
    
    public func draw(with size: CGSize = CGSize(width: 512, height: 256)) -> UIImage? {
        guard dataSet.count > 0 else { return nil }
        
        let sectionWidth = size.width / CGFloat(dataSet.count)
        let sectionMaxHeight = size.height - descriptionHeight
        
        let maxValue = dataSet.reduce(0) { (result, partialValue) -> Int in
            return max(result, partialValue.value)
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let stringAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: descriptionHeight - 5), NSAttributedStringKey.paragraphStyle: paragraphStyle, NSAttributedStringKey.foregroundColor: textColor]
            
            var index = 0
            dataSet.forEach { key, value in
                let height = sectionMaxHeight * CGFloat(value) / CGFloat(maxValue)
                
                context.cgContext.setFillColor(barColor.cgColor)
                context.cgContext.addRect(CGRect(x: CGFloat(index) * sectionWidth, y: 0 + sectionMaxHeight - height, width: sectionWidth - 2 * barMargin, height: height))
                context.cgContext.drawPath(using: .fill)
                
                key.draw(with: CGRect(x: CGFloat(index) * sectionWidth, y: sectionMaxHeight + 2, width: sectionWidth, height: descriptionHeight), options: .usesLineFragmentOrigin, attributes: stringAttributes, context: nil)
                
                index += 1
            }
        }
    }
}

/*
 
 // How to: random graph?
 
 var dataset = [(key: String, value: Int)]()
 (0..<26).forEach { i in
     dataset.append((key: String(Character(UnicodeScalar(97 + i)!)), value: Int(arc4random_uniform(100))))
 }
 Graph(dataSet: dataset).draw()
 
*/
