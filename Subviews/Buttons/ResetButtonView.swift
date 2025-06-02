//
//  ResetButtonView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/05/2025.
//

import SwiftUI

struct ResetButtonView: View {
    @EnvironmentObject private var vm: FormViewModel
    
    var body: some View {
        Button {
            withAnimation(.easeOut) {
                vm.resetFormInformation()
            }
        } label: {
            Text("Reset")
                .font(.callout)
                .foregroundStyle(Color(.darkGray))
        }
        .padding(.trailing)
    }
}

#Preview {
    ResetButtonView()
        .environmentObject(FormViewModel())
}
