//
//  Extensions.swift
//  ProfitProjects
//
//  Created by Ярослав Ерохин on 15.02.17.
//  Copyright © 2017 ProfitProjects. All rights reserved.
//

import Foundation
import UIKit

// MARK: - мусорка различных расширений и функций

public extension Sequence where Iterator.Element: Hashable {
    var uniqueElements: [Iterator.Element] {
        return Array( Set(self) )
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var viewBorderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UINavigationController {
    @discardableResult
    func addDismissButtonToRootVC(title:String) -> UINavigationController {
        let vc = self.topViewController
        let backItem = UIBarButtonItem(title: title,
                                       style: .plain,
                                       target: self,
                                       action: #selector(dismissButtonAction))
        vc?.navigationItem.rightBarButtonItem = backItem
        return self
    }
}

extension UIViewController {
    @discardableResult
    func addDismissButton(title:String) -> UIViewController {
        let backItem = UIBarButtonItem(title: title,
                                       style: .plain,
                                       target: self,
                                       action: #selector(dismissButtonAction))
        navigationItem.rightBarButtonItem = backItem
        return self
    }
    
    @objc func dismissButtonAction(_ button:UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
}


extension Collection {
    func chunked(by distance: Int) -> [[SubSequence.Iterator.Element]] {
        var index = startIndex
        let iterator: AnyIterator<Array<SubSequence.Iterator.Element>> = AnyIterator {
            defer {
                index = self.index(index, offsetBy: distance, limitedBy: self.endIndex) ?? self.endIndex
            }
            
            let newIndex = self.index(index, offsetBy: distance, limitedBy: self.endIndex) ?? self.endIndex
            let range = index ..< newIndex
            return index != self.endIndex ? Array(self[range]) : nil
        }
        
        return Array(iterator)
    }
}

public extension Sequence where Iterator.Element: Equatable {
    var uniqueElements: [Iterator.Element] {
        return self.reduce([]){
            uniqueElements, element in
            
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }
    }
}

extension UIView {
    func setBackground(withName: String){
        UIGraphicsBeginImageContext(self.frame.size)
        UIImage(named: withName)?.draw(in: self.bounds)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        self.backgroundColor = UIColor(patternImage: image)
    }
}

extension Date {
    struct Formatter { // time for Firebase
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return formatter
        }()
    }
    
    static func from(iso8601 string:String?) -> Date? {
        if let string_ = string {
            return Formatter.iso8601.date(from: string_)
        }
        return nil
    }
    
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    
    /// returns current date as string in iso8601 format
    static var nowTimestamp: String {
        return Formatter.iso8601.string(from: Date())
    }

	static var nowIso8601:String {
		return Date().iso8601
	}
}

extension Float {
	func formattedString(roundTo decimalPlaces:Int = 1) -> String {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = decimalPlaces
		return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
	}
}

extension Double {
	func formattedString(roundTo decimalPlaces:Int = 1, min:Int = 0) -> String {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = min
		formatter.maximumFractionDigits = decimalPlaces
		formatter.minimumIntegerDigits = 1
		return formatter.string(for: self)!
	}
}

func removeDuplicates(_ nums: inout [Int]) -> Int {
	
	guard let first = nums.first else {
		return 0 // Empty array
	}
	var current = first
	var count = 1
	
	for elem in nums.dropFirst() {
		if elem != current {
			nums[count] = elem
			current = elem
			count += 1
		}
	}
	
	nums.removeLast(nums.count - count)
	return count
}
extension String {
    func removing(charactersOf string: String) -> String {
        let characterSet = CharacterSet(charactersIn: string)
        let components = self.components(separatedBy: characterSet)
        return components.joined(separator: "")
    }
    
    var dateFromISO8601: Date? {
        return Date.Formatter.iso8601.date(from: self)
    }
    
    var uppercaseFirst: String {
        return String(prefix(1)).uppercased() + String(dropFirst())
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UIView {
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                                  owner: self, options: nil)?[0] as? T else { return nil }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        return view
    }
}

extension UITableView {
    func register(cellNamed name: String) {
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}

extension UICollectionView {
    func register(cellNamed name: String) {
        register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
}

extension UIViewController {
    /// create alert controller
    func alert(_ message:String = "") {
        let string = message
        let alert = UIAlertController(title: "Внимание!", message: string, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) { _ in alert.dismiss(animated: true) }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func ask(_ title: String = "Внимание!", question:String, waitFor completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message: question, preferredStyle: .alert)
        let yes = UIAlertAction(title: "Да", style: .default) { _ in completion(true); alert.dismiss(animated: true) }
        let no = UIAlertAction(title: "Нет", style: .default) { _ in completion(false); alert.dismiss(animated: true) }
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }

	func askForInput(_ title:String = "Внимание!",
					 question:String,
					 placeholder:String = "",
					 waitFor completion: @escaping (String?) -> Void) {
		let alertController = UIAlertController(title: title, message: question, preferredStyle: .alert)
		let saveAction = UIAlertAction(title: "Отправить", style: .default, handler: { alert in
			let textField = alertController.textFields![0] as UITextField
			completion(textField.text)
		})
		let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: { action in
			completion(nil)
		})
		alertController.addTextField { textField in
			textField.placeholder = placeholder
		}
		alertController.addAction(saveAction)
		alertController.addAction(cancelAction)
		present(alertController, animated: true, completion: nil)
	}

	@objc
    func dismiss(animated:Bool = false) {
        if let nav = self.navigationController {
            nav.dismiss(animated: animated, completion: nil)
        }
        else {
            dismiss(animated: animated, completion: nil)
        }
    }
}

extension UIViewController {
	var inNavigationController:UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

extension UIImage {
    static func gradientImage(rect: CGRect, colors: [UIColor]) -> UIImage? {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = rect
        gradientLayer.colors = []
        for color in colors {
            gradientLayer.colors?.append(color.cgColor)
        }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    static func imageFrom(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

@IBDesignable class RoundedView: UIView {
    @IBInspectable var isRelativeRadius:Bool = true { didSet { setNeedsLayout() } }
    @IBInspectable var cornerRadius:CGFloat = 0.5  { didSet { setNeedsLayout() } }
    @IBInspectable var borderWidth:CGFloat = 0  { didSet { setNeedsLayout() } }
    @IBInspectable var borderColor:UIColor = .clear  { didSet { setNeedsLayout() } }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = isRelativeRadius ? frame.height * cornerRadius : cornerRadius
        
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}


@IBDesignable final class RoundedImageView: UIImageView {
    @IBInspectable var isRelativeRadius:Bool = false  { didSet { setNeedsLayout() } }
    @IBInspectable var cornerRadius:CGFloat = 0  { didSet { setNeedsLayout() } }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = isRelativeRadius ? frame.height * cornerRadius : cornerRadius
    }
}

class LabelWithInsets: UILabel {
    var edgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, edgeInsets))
    }
}

final class IntrinsicTableView: UITableView {
    override var contentSize:CGSize { didSet { invalidateIntrinsicContentSize() }}
    override var intrinsicContentSize:CGSize {
        layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: contentSize.height)
    }
}

func print(_ message:String, from object:AnyObject?) {
    #if DEBUG
        if let object_ = object {
            NSLog("\(object_): \(message)")
        }
        else {
            NSLog(message)
        }
    #endif
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIViewController {
    
    func call(message:String? = nil, completion: (()->Void)? = nil) {
        guard message != nil else { return }
        
        let string = message
        let alert = UIAlertController(title: "Внимание!", message: string, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) { _ in
            completion?()
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension Array where Element: Equatable {
	public func removingDuplicates() -> [Element] {
		var arrayCopy = self
		arrayCopy.removeDuplicates()
		return arrayCopy
	}
	mutating public func removeDuplicates() {
		var seen = [Element]()
		var index = 0
		for element in self {
			if seen.contains(element) {
				remove(at: index)
			}
			else {
				seen.append(element)
				index += 1
			}
		}
	}
}

extension CharacterSet {
	var characters:[String] {
		var chars = [String]()
		for plane:UInt8 in 0...16 {
			if hasMember(inPlane: plane) {
				let p0 = UInt32(plane) << 16
				let p1 = (UInt32(plane) + 1) << 16
				for c:UTF32Char in p0..<p1 {
					if (self as NSCharacterSet).longCharacterIsMember(c) {
						var c1 = c.littleEndian
						let s = NSString(bytes: &c1, length: 4,
										 encoding: String.Encoding.utf32LittleEndian.rawValue)!
						chars.append(String(s))
					}
				}
			}
		}
		return chars
	}
}

extension String {
	func trim() -> String {
		return trimmingCharacters(in: .whitespacesAndNewlines)
	}
	func replacingCharacters(from sets:[CharacterSet], with new:String) -> String {
		return replacingCharacters(from: sets.map { $0.characters.joined() }.joined(), with: new)
	}

	func replacingCharacters(from set:CharacterSet, with new:String) -> String {
		return replacingCharacters(from: set.characters.joined(), with: new)
	}

	func replacingCharacters(from set:String, with new:String) -> String {
		var output = self
		for s in set {
			output = output.replacingOccurrences(of: String(s), with: new)
		}
		return output
	}
}

extension Dictionary {
	var jsonString:String {
		do {
			let data = try JSONSerialization.data(withJSONObject: self as AnyObject,
												  options: .prettyPrinted)
			return String(data: data, encoding: .utf8) ?? "<Error: Could not convert json data to string.>"
		} catch let error {
			return "<Error: Could not encode this dictionary: (\(error)>"
		}
	}
}

extension Array {
	func get(at indexes:[Int]) -> [Element] {
		var elements:[Element] = []
		for i in 0..<count {
			if indexes.contains(i) {
				elements.append(self[i])
			}
		}
		return elements
	}
}

extension Array where Element:Equatable {
	func indexes(of elements:[Element]) -> [Int] {
		var indexes:[Int] = []
		for i in 0..<count {
			if elements.contains(self[i]) {
				indexes.append(i)
			}
		}
		return indexes
	}
}
extension Data {
	var html2AttributedString: NSAttributedString? {
		do {
			return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
		} catch {
			print("error:", error)
			return  nil
		}
	}
	var html2String: String? {
		return html2AttributedString?.string
	}
}

extension String {
	var html2AttributedString: NSAttributedString? {
		return Data(utf8).html2AttributedString
	}
	var html2String: String? {
		return html2AttributedString?.string
	}
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Array where Element: Equatable {
    
    @discardableResult mutating func remove(object: Element) -> Bool {
        if let index = index(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
    @discardableResult mutating func remove(where predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        if let index = self.index(where: { (element) -> Bool in
            return predicate(element)
        }) {
            self.remove(at: index)
            return true
        }
        return false
    }
}
