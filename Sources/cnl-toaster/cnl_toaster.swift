// The Swift Programming Language
// https://docs.swift.org/swift-book
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

extension View {
    public func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
