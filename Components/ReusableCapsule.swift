//
//  ReusableCapsule.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import SwiftUI

struct ReusableCapsule: View {
    var body: some View {
        Capsule()
            .foregroundStyle(Color(.systemGray4))
            .frame(width: 48, height: 6)
    }
}

#Preview {
    ReusableCapsule()
}
