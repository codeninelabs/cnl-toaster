//
//  Toast.swift
//  cnl-toaster
//
//  Created by Kevin Armstrong on 12/15/24.
//
import SwiftUI

public struct Toast: Equatable {
    public var message: String
    public var duration: Double = 3
    public var cornerRadius: Double = 10
    public var offset: Double = 0
    public var width: Double = .infinity
    public var alignment: Alignment = .bottom
    
    public init(message: String, duration: Double? = nil, cornerRadius: Double? = nil, offset: Double? = nil, width: Double? = nil, alignment: Alignment? = nil) {
        self.message = message
        self.duration = duration ?? 3
        self.cornerRadius = cornerRadius ?? 10
        self.offset = offset ?? 0
        self.width = width ?? .infinity
        self.alignment = alignment ?? .bottom
    }
}
