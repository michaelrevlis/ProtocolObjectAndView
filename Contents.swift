import UIKit

protocol BasicProduct {
    var cpdtNum: NSNumber? { get }
    var cpdtName: String? { get }
    var purePrice: NSNumber? { get }
    var purePoint: NSNumber? { get }
    var mixPrice: NSNumber? { get }
    var mixPoint: NSNumber? { get }
}

protocol RankProduct {
    var rank: NSNumber? { get }
}

protocol ProductInstallment {
    var installments: Array<String>? { get }
}



struct EiffelAmwayDefault<BasicProduct, RankProduct, ProductInstallment> {
    init(dict: Dictionary<String, AnyObject>) {
        sourceData = dict
    }
    var sourceData: Dictionary<String, AnyObject>
    var cpdtNum: NSNumber? { return sourceData["cpdt_num"] as? NSNumber }
    var cpdtName: String? { return sourceData["cpdt_name"] as? String }
    var purePrice: NSNumber? { return sourceData["price03"] as? NSNumber }
    var purePoint: NSNumber? { return sourceData["point01"] as? NSNumber }
    var mixPrice: NSNumber? { return sourceData["price02"] as? NSNumber }
    var mixPoint: NSNumber? { return sourceData["point02"] as? NSNumber }
    var rank: NSNumber? { return sourceData["rank"] as? NSNumber }
    var installments: Array<String>? { return sourceData["installments"] as? Array<String>}
}

struct PortalProductDetail<BasicProduct, ProductInstallment> {
    init(dict: Dictionary<String, AnyObject>) {
        sourceData = dict
    }
    var sourceData: Dictionary<String, AnyObject>
    var price: [String: [String: NSNumber]]? { return sourceData["price"] as? [String: [String: NSNumber]] }
    var cpdtNum: NSNumber? { return sourceData["cpdt_num"] as? NSNumber }
    var cpdtName: String? { return sourceData["cpdt_name"] as? String }
    var purePrice: NSNumber? {
        if let price03 = price?["03"] {
            return price03["price"]
        } else {
            return nil
        }
    }
    var purePoint: NSNumber? {
        if let point01 = price?["01"] {
            return point01["point"]
        } else {
            return nil
        }
    }
    var mixPrice: NSNumber? {
        if let price02 = price?["02"] {
            return price02["price"]
        } else {
            return nil
        }
    }
    var mixPoint: NSNumber? {
        if let point02 = price?["02"] {
            return point02["point"]
        } else {
            return nil
        }
    }
    var installments: Array<String>? { return sourceData["seek_installment"] as? Array<String>}
}

class TMView: UIView {
    var priceLb = UILabel()
    var rankLb = UILabel()
    var dataSource: BasicProduct?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        if let price = dataSource?.purePrice {
            priceLb.text = "\(price)"
        }
        
        if let data = dataSource as? RankProduct,
            let rank = data.rank {
            rankLb.text = "\(rank)"
        }
    }
}
