//
//  ToastModifier.swift
//  cnl-toaster
//
//  Created by Kevin Armstrong on 12/15/24.
//
import SwiftUI

public struct ToastModifier: ViewModifier {
  @Binding public var toast: Toast?
  @State private var workItem: DispatchWorkItem?
  
    public func body(content: Content) -> some View {
        content
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .overlay(
            ZStack { mainToastView().offset(y: toast?.offset ?? 0) }.animation(.spring(), value: toast)
          )
          .onChange(of: toast) { _, value in
            showToast()
          }
    }
  
  @ViewBuilder public func mainToastView() -> some View {
    if let toast = toast {
        VStack {
            ToastView(
              message: toast.message,
              cornerRadius: toast.cornerRadius,
              width: toast.width
            ) {
              dismissToast()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: toast.alignment)
    }
  }
  
  private func showToast() {
    guard let toast = toast else { return }
    
    UIImpactFeedbackGenerator(style: .light)
      .impactOccurred()
    
    if toast.duration > 0 {
      workItem?.cancel()
      
      let task = DispatchWorkItem {
        dismissToast()
      }
      
      workItem = task
      DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
    }
  }
  
  private func dismissToast() {
    withAnimation {
      toast = nil
    }
    
    workItem?.cancel()
    workItem = nil
  }
}
