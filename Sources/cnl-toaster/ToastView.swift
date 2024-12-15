//
//  ToastView.swift
//  cnl-toaster
//
//  Created by Kevin Armstrong on 12/15/24.
//
import SwiftUI

public struct ToastView: View {
    public var message: String
    public var cornerRadius: Double = 10
    public var width = CGFloat.infinity
    public var onCancelTapped: (() -> Void)
  
    public var body: some View {
        HStack {
          Text(message)
            .multilineTextAlignment(.center)
            .foregroundColor(Color("toastForeground"))
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(Color("toastBackground"))
        .cornerRadius(cornerRadius)
        .padding(.horizontal, 16)
    }
}
