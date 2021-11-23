import UIKit

extension UIFont {
    public enum NotoSansType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
    }
    
    static func NotoSans(_ type: NotoSansType, size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansKR-\(type.rawValue)", size: size)!
    }
    
    public enum LatoType: String {
        case bold = "Bold"
        case regular = "Regular"
    }
    
    static func Lato(_ type: LatoType, size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-\(type.rawValue)", size: size)!
    }
}
