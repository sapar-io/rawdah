//
//  IAPManager.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 20.06.2022.
//

import Foundation
import StoreKit

final class IAPManager: NSObject {
    
    // MARK: - Singleton
    static let shared = IAPManager()
    var products = [SKProduct]()
    
    // MARK: - Model
    enum Product: String, CaseIterable {
        case coffee_1490
        case coffee_4990
        case coffee_15990
        case coffee_49990
    }
    
    // MARK: - Public Methods
    public func fetchProducts() {
        let request = SKProductsRequest(
            productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue }))
        )
        request.delegate = self
        request.start()
    }
}

// MARK: - SKProductsRequestDelegate
extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
    }
}

// MARK: - SKPaymentTransactionObserver
extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
}
