import UIKit

final class TextDecoration {
    static func getDecoratedString(name: String, lastname: String) -> NSMutableAttributedString {
        let nameFont = UIFont.systemFont(ofSize: 22, weight: .medium)
        let lastnameFont = UIFont.systemFont(ofSize: 16, weight: .light)
        let fullString = NSMutableAttributedString(string: name + " " + lastname)
        let fullLength = NSRange(location: 0, length: fullString.length)
        let nameRange = NSRange(location: 0, length: name.count)
        fullString.addAttributes([.font: lastnameFont, .foregroundColor: UIColor.lightGray], range: fullLength)
        fullString.addAttributes([.font: nameFont, .foregroundColor: UIColor.black], range: nameRange)
        return fullString
    }
}
