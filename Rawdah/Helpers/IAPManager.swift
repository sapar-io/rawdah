//
//  IAPManager.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 07.06.2022.
//

import Foundation
import StoreKit

final class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let shared = IAPManager()
    
    var products = [SKProduct]()
    
    private var completion: (() -> Void)?
    
    enum Product: String, CaseIterable {
        case rawdah_499
        case rawdah_1490
        case rawdah_3490
        case rawdah_4990
        case rawdah_15990
        case rawdah_49990
        case rawdah_99990
        case rawdah_499990
    }
    
    public func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue })))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        
        products.sort(by: { (p0, p1) -> Bool in
            return p0.price.floatValue < p1.price.floatValue
        })
    }
    
    func purchase(product: Product, completion: @escaping (() -> Void)) {
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        
        guard let storeKitProduct = products.first(where: { $0.productIdentifier == product.rawValue }) else {
            return
        }
        
        self.completion = completion
        
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchasing:
                break
            case .purchased:
                completion?()
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
                break
            case .failed:
                break
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        }
    }
}
