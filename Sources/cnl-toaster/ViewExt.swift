//
//  ViewExt.swift
//  cnl-toaster
//
//  Created by Kevin Armstrong on 12/15/24.
//
import SwiftUI

extension View {
    public func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
